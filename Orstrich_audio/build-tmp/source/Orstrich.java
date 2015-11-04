import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 
import net.victorcheung.WSProcessor.*; 
import ddf.minim.*; 
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

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Orstrich extends PApplet {





//Http POST request class, super ugly but needed, sad





















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
    this(url, "ISO-8859-1");
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

//here ends the ugly part

Server myServer;
// single client supported
Client myClient;
int serverPort = 7122;
boolean isConnected = false;
WSProcessor myWSProcessor;
PFont font;

String recogRet = "";
String evalRet = "";

Minim minim;
AudioInput in;
AudioRecorder recorder;
int recCnt = 0;

public void setup() {
  
  font = createFont("Arial", 16);
  textFont(font);
  
  //audio input settings
  minim = new Minim(this);
  in = minim.getLineIn();
  recorder = minim.createRecorder(in, "dummy.wav");


  // Starts a Websocket server at port defined above
  myServer = new Server(this, serverPort);
}

// supposed to be a call-back function of Processing when it closes.
// not sure if it works, but if it does it stops both server and client.
public @Override
void stop() {
  myServer.stop();
  myClient.stop();
  
  super.stop();
}

//evaluation part for therecognition result, using api from sentiment tool
//http://sentiment.vivekn.com/docs/api/

public void evalSentiment() {
  PostRequest post = new PostRequest("http://sentiment.vivekn.com/api/text/");
  post.addData("txt", recogRet);
  post.send();
  JSONObject response = parseJSONObject(get.getContent());
  JSONObject eval = response.getJSONObject("result");
  evalRet = eval.getString("sentiment");
}

//check for new clients, update and draw. 
public void draw() {
  
  background(0);
  fill(255);
  text("Server IP: "+Server.ip(), 10, 20);

  if(!isConnected) {
    //if no client is connected, wait until there is one
    //while(myClient == null) {
    myClient = myServer.available();
    //  print("waiting for connection...");
    //}
    if(myClient != null) {
      /* Here comes the golden part */
      //1. create the WProcessor object, need to pass the client so it knows whom to talk with
      myWSProcessor = new WSProcessor(myClient, true);
      //2. call the connect method, which handles all the handshaking and figuring out the masking key
      myWSProcessor.connect();
      //3. call the sendMessage to send something to the client, can call mulitple times
      myWSProcessor.sendMessage("You are connected");
      /* That's it... for the starting and sending */
      
      isConnected = true;
      if(recorder.isRecording())
        println("recording", 10, 90);
      else {
        recorder = minim.createRecorder(in, "test" + recCnt + ".wav");
        recorder.beginRecord();
      }
      println("isConnected set to true");
    } else {
      isConnected = false;
      println("isConnected set to false");
    }
  } else { //the case when a client is connected
    text("client connected", 10, 50);
    String unMaskedString = myWSProcessor.getMessageAsString();
    //String[] data = split(unMaskedString, ':');
    if(unMaskedString!=null) {
      recogRet = unMaskedString;
      evalSentiment();
      //text("stop recording", 10, 90);
      if(recorder.isRecording()) {
        recorder.save();
        recorder.endRecord();
        println("save record");
        recCnt++;
      }
      // restart connection
      isConnected = false;
    }
    text("Latest recognition result received from client: ", 10, 70);
    //if(recorder.isRecording())text("Recording", 10, 110);
    text(recogRet, 10, 90);
    text(evalRet, 10, 110);
  }

  //check if the client is active (i.e. still connected)
  if(myClient!=null && !myClient.active()) {
    myWSProcessor.stop();
    isConnected = false;
  }
 
}
  public void settings() {  size(400, 400, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Orstrich" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
