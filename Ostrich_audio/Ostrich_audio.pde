//package import
import processing.net.*;
import net.victorcheung.WSProcessor.*;
import ddf.minim.*;

//dirty part of the code, the whole class of PostRequest
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

public class PostRequest
{
  String url;
  ArrayList<BasicNameValuePair> nameValuePairs;
  HashMap<String,File> nameFilePairs;
      ArrayList<BasicNameValuePair> headerPairs;


  String content;
  String encoding;
  HttpResponse response;
  UsernamePasswordCredentials creds;

  public PostRequest(String url)
  {
    this(url, "UTF-8");
  }
  
  public PostRequest(String url, String encoding) 
  {
    this.url = url;
    this.encoding = encoding;
    nameValuePairs = new ArrayList<BasicNameValuePair>();
    nameFilePairs = new HashMap<String,File>();
    this.headerPairs = new ArrayList<BasicNameValuePair>();
  }

  public void addUser(String user, String pwd) 
  {
    creds = new UsernamePasswordCredentials(user, pwd);
  }
    
      public void addHeader(String key,String value) {
          BasicNameValuePair nvp = new BasicNameValuePair(key,value);
          headerPairs.add(nvp);
        
      } 

  public void addData(String key, String value) 
  {
    BasicNameValuePair nvp = new BasicNameValuePair(key,value);
    nameValuePairs.add(nvp);
  }

  public void addFile(String name, File f) {
    nameFilePairs.put(name,f);
  }

  public void addFile(String name, String path) {
    File f = new File(path);
    nameFilePairs.put(name,f);
  }
  
  public void send() 
  {
    try {
      DefaultHttpClient httpClient = new DefaultHttpClient();
      HttpPost httpPost = new HttpPost(url);

      if(creds != null){
        httpPost.addHeader(new BasicScheme().authenticate(creds, httpPost, null));        
      }

      if (nameFilePairs.isEmpty()) {
        httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs, encoding));
      } else {
        MultipartEntity mentity = new MultipartEntity();  
        Iterator<Entry<String,File>> it = nameFilePairs.entrySet().iterator();
          while (it.hasNext()) {
              Entry<String, File> pair =  it.next();
              String name = (String) pair.getKey();
              File f = (File) pair.getValue();
          mentity.addPart(name, new FileBody(f));
          }        
        for (NameValuePair nvp : nameValuePairs) {
          mentity.addPart(nvp.getName(), new StringBody(nvp.getValue()));
        }
        httpPost.setEntity(mentity);
      }

                      Iterator<BasicNameValuePair> headerIterator = headerPairs.iterator();
                      while (headerIterator.hasNext()) {
                          BasicNameValuePair headerPair = headerIterator.next();
                          httpPost.addHeader(headerPair.getName(),headerPair.getValue());
                      }

      response = httpClient.execute( httpPost );
      HttpEntity   entity   = response.getEntity();
      this.content = EntityUtils.toString(response.getEntity());

      if( entity != null ) EntityUtils.consume(entity);

      httpClient.getConnectionManager().shutdown();

      // Clear it out for the next time
      nameValuePairs.clear();
      nameFilePairs.clear();

    } catch( Exception e ) { 
      e.printStackTrace(); 
    }
  }

  /* Getters
  _____________________________________________________________ */

  public String getContent()
  {
    return this.content;
  }

  public String getHeader(String name)
  {
    Header header = response.getFirstHeader(name);
    if(header == null)
    {
      return "";
    }
    else
    {
      return header.getValue();
    }
  }
}
//end class

//constant declaration
final int maxRecFileNum = 10;
final int serverPort = 7122;

//varaible declaration
PFont font;

//state machine
boolean isIdleState = true;

//audio recording
int currentRecFileNum = 0, currentRecFileIndex = 0;
Minim minim;
AudioInput micIn;
AudioRecorder recorder;

//websocket connection
Server localServer;
Client recogClient;
boolean isConnected = false;
WSProcessor webSocketProcessor;

//voice recognition & sentiment evaluation
String recogRet = "", evalRet = "";

String audioPrefixPath = null; 

void setup() {
	size(400, 400, P3D);
  background(0);
	font = createFont("Arial", 16);

  audioPrefixPath = sketchPath("") + "Sound/";

	//Audio Setup
	minim = new Minim(this);
	micIn = minim.getLineIn();
	recorder = minim.createRecorder(micIn, audioPrefixPath + "dummy.wav");
	//server setup
	localServer = new Server(this, serverPort);
}

void evalSentiment() {
	PostRequest post = new PostRequest("http://sentiment.vivekn.com/api/text/");
	post.addData("txt", recogRet);
	post.send();
	JSONObject response = parseJSONObject(post.getContent());
	JSONObject eval = response.getJSONObject("result");
	evalRet = eval.getString("sentiment");
}

int playFileIndex;

void idleBehavior() {
	//select a random existing audio file to play on cell phone
	if(currentRecFileNum != 0) {
    Double rand = Math.random() * currentRecFileNum;
		playFileIndex = rand.intValue();
		PostRequest playFileCmd = new PostRequest("http://127.0.0.1:8081/PhoneCtrl");
		playFileCmd.addData("command", "play");
		playFileCmd.addData("filename", audioPrefixPath + "record" + playFileIndex + ".wav");
		playFileCmd.send();
		//TODO: make Orstrich perform default move
    
	}
}

@Override
void stop() {
  localServer.stop();
  recogClient.stop();
  
  super.stop();
}

void draw() {
	//two states: idle and record
	if(isIdleState) {
		//idle state
		//perform idle behavior
		idleBehavior();
	}
	else {
		//record state
		//check connection with client
		if(!isConnected) {
			//attempt to build connection
			recogClient = localServer.available();
			if(recogClient == null)
				text("not connected, no available client found.", 10, 30);
			else {
				//build connection with client
				webSocketProcessor = new WSProcessor(recogClient, true);
				webSocketProcessor.connect();
				isConnected = true;
				if(!recorder.isRecording()) {
					recorder = minim.createRecorder(micIn, audioPrefixPath + "record" + currentRecFileIndex + ".wav");
					recorder.beginRecord();
				}
			}
		}
		else {
			//client already connected, and recording
			text("client connected", 10, 30);
			String clientRet = webSocketProcessor.getMessageAsString();
			if(clientRet != null) {
				recogRet = clientRet;
				evalSentiment();
				if(recorder.isRecording()) {
					recorder.save();
					recorder.endRecord();
					currentRecFileNum = min(currentRecFileNum + 1, maxRecFileNum);
				}
        //TODO: add relateive movement



				//reset connection, back to idle state
				isConnected = false;
				isIdleState = true;
			}
		}
	}
	//check if the client is active (i.e. still connected)
	if(recogClient!=null && !recogClient.active()) {
		webSocketProcessor.stop();
		isConnected = false;
	}

	text("Last Recognition result received from client: ", 10, 50);
	text(recogRet, 10, 70);
	text(evalRet, 10, 90);
}

void keyPressed() {
	if(key == 'r' || key == 'R') {
		//if key r is pressed, switch to record mode
		if(isIdleState = true)
			isIdleState = false;
	}
}