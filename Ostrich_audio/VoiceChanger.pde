import java.util.*;
import java.io.*;

class VoiceChanger {

  List<String> command;
  ProcessBuilder builder;
  //audio transform params
  final int tempoVal = -50;
  final int pitchVal = 1;
  final int rateVal = 200; 
  
  public VoiceChanger(PApplet parent, String audioDirPath) {
    command = new ArrayList<String>(6);
    command.add(parent.sketchPath("") + "soundstretch");
    command.add("recording.wav");
    command.add("target.wav");
    command.add("-tempo=" + String.valueOf(tempoVal));
    command.add("-pitch=" + String.valueOf(pitchVal));
    command.add("-rate=" + String.valueOf(rateVal));
     
    builder = new ProcessBuilder();
    builder.directory(new File(audioDirPath));
    builder.redirectErrorStream(true);
    
  }
  
  String process(String srcAudioName) {
    command.set(1, srcAudioName);
    builder.command(command);
    try {
      Process process =  builder.start();
      Scanner s = new Scanner(process.getInputStream());
      while (s.hasNextLine()) {
        println(s.nextLine());
        //s.nextLine();
      }
      s.close();
  
      int result = process.waitFor();
      //println("result Code:" + result);
      return command.get(2);
    }
    catch(Exception e) {
      print("audio transformation failed:");
      println(e.getLocalizedMessage());
      return null;
    }  
  
  }

  String process(String srcAudioName, String destAudioName) {
    command.set(2, destAudioName);
    return process(srcAudioName);
  }

}