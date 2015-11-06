import net.victorcheung.WSProcessor.*;

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

//constant declaration
final int maxRecFileNum = 10;
final int serverPort = 7122;

final int numExistedAudioFiles = 20; //v0.wav, v1.wav ...

//varaible declaration
PFont font;

//state machine
boolean isIdleState = true;

//audio recording
int currentRecFileNum = 0, currentRecFileIndex = 0;
Minim minim;
AudioInput micIn;
AudioRecorder recorder;
VoiceChanger voiceChanger;

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
	font = createFont("Arial", 16);

  audioPrefixPath = sketchPath("") + "Sound/";

	//Audio Setup
	minim = new Minim(this);
	micIn = minim.getLineIn();
	recorder = minim.createRecorder(micIn, audioPrefixPath + "dummy.wav");

  voiceChanger = new VoiceChanger(this, audioPrefixPath);

	//server setup
	localServer = new Server(this, serverPort);
  
  //Aduino setup
  arduinoInit();
  loadScript("newOstrich");  //TODO script filename
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
AudioPlayer transAudioPlayer = null;

void idleBehavior() {
	  
  if(transAudioPlayer != null && transAudioPlayer.isPlaying()) {
    return;
  }

  delay(2000);

  String fileNameWithPath = null;
  String selectedFileNameWithPath = null;

  boolean applyEffect = true;

  if(Math.random() > 0.5 && currentRecFileNum != 0) {
    //choose from recorded audio files
    Double rand = Math.random() * currentRecFileNum;
    playFileIndex = rand.intValue();
    
    // println("curr:" + currentRecFileNum + ",fileIndex:" + playFileIndex);
  
    fileNameWithPath = audioPrefixPath + "record" + playFileIndex + ".wav";
  }
  else {

    Double rand = Math.random() * numExistedAudioFiles;
    playFileIndex = rand.intValue();
    if(playFileIndex >= numExistedAudioFiles) {
      playFileIndex = numExistedAudioFiles - 1;
    }

    //TODO: you can comment this to apply effect on v*.wav files.
    applyEffect = false;

    fileNameWithPath = audioPrefixPath + "v" + playFileIndex + ".wav";

  }

  if(applyEffect) {
    selectedFileNameWithPath = audioPrefixPath + voiceChanger.process(fileNameWithPath);
  }
  else {
    selectedFileNameWithPath = fileNameWithPath;
  }
  

  transAudioPlayer = minim.loadFile(selectedFileNameWithPath);
  transAudioPlayer.play();

  //TODO: make Orstrich perform default move
  
  
}

@Override
void stop() {
  localServer.stop();
  recogClient.stop();
  
  super.stop();
}

void draw() {
  background(0);

	//two states: idle and record
	if(isIdleState) {
		//idle state
		//perform idle behavior
		idleBehavior();
	}
  else if(transAudioPlayer == null || !transAudioPlayer.isPlaying()) {
    //if the machine is still playing, then we wait for the playback ending.
  
		//record state
		//check connection with client
		if(!isConnected) {
			//attempt to build connection
			recogClient = localServer.available();
			if(recogClient != null) {
				//build connection with client
				webSocketProcessor = new WSProcessor(recogClient, true);
				webSocketProcessor.connect();
				isConnected = true;
				if(!recorder.isRecording()) {
					recorder = minim.createRecorder(micIn, audioPrefixPath + "record" + currentRecFileNum + ".wav");
					recorder.beginRecord();
				}

			}
		}
		else {
			//client already connected, and recording
			String clientRet = webSocketProcessor.getMessageAsString();
			if(clientRet != null) {
				recogRet = clientRet;
				evalSentiment();
				if(recorder.isRecording()) {
					recorder.save();
					recorder.endRecord();
					currentRecFileNum = min(currentRecFileNum + 1, maxRecFileNum);
				}

        //TODO
        // println("evalRet:" + evalRet);
        if (evalRet.equals("Neutral")) {
          //TODO add Neutral relateive movement
          println("play Neutral animation");
          say0();  //example
        } else if (evalRet.equals("Positive")) {
          //TODO add Positive relateive movement
          println("play Positive animation");
          say1();  //example
        } else if (evalRet.equals("Negative")) {
          //TODO add Negative relateive movement
          println("play Negative animation");
          say2();  //example
        }

				//reset connection, back to idle state
				isConnected = false;
				isIdleState = true;
			}
		}
	}

	//check if the client is active (i.e. still connected)
	if(recogClient != null && !recogClient.active()) {
		webSocketProcessor.stop();
		isConnected = false;
	}

  if(transAudioPlayer != null && transAudioPlayer.isPlaying()) {
    text("Ostrich is busying, please wait for a while.", 10, 30);
  }
  else if(!isConnected || recogClient == null) {
    text("not connected, no available client found.", 10, 30);
  }
  else {
    text("client connected, you can start speaking", 10, 30);
  }

	text("Last Recognition result received from client: ", 10, 50);
	text(recogRet, 10, 70);
	text(evalRet, 10, 90);
}

void keyPressed() {
	if(key == 'r' || key == 'R') {
		//if key r is pressed, switch to record mode
		if(isIdleState)
			isIdleState = false;
	}
  else if(key == 's' || key == 'S') {
    if(transAudioPlayer != null) {
      transAudioPlayer.pause();
    }

  }
}