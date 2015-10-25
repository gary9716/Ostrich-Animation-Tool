// Need G4P library
import g4p_controls.*;
import java.io.FileReader;
import java.io.FileOutputStream;
import processing.serial.*;
import cc.arduino.*;

import ddf.minim.*; //for music playing

Minim minim;
AudioPlayer talker;
int maxPossibleMoves = 8;
boolean idleState = false;
String defaultSketchPath;
//boolean isEditMode = true;
boolean isEditMode = true;
int BGcolor = 0;
int BGcounter = 0;
int delayValue = 100;

class FrameUnit {
  int id;
  float[] servoDegree;
  float[] rotateTime;
  int frameTime;
  
  FrameUnit() {
    id = -1;
    servoDegree = new float[SERVO_NUM];
    rotateTime = new float[SERVO_NUM];
    frameTime = 0;
  }
  
  String toString() {
    String str = "";
    
    str = "" + id;
    for (int i = 0; i < SERVO_NUM; i++) {
      str += (" " + servoDegree[i] + " " + rotateTime[i]);
    }
    return str;
  }
}

void appendToScript(String filename, String data) {
  try {
    PrintWriter scriptPw = new PrintWriter(new FileOutputStream(sketchPath("") + filename, true));
    scriptPw.println(data);
    scriptPw.close();
    println("successfully append data");
  }
  catch(Exception e) {
    println(e.getMessage());
  }
}

int loadScript(String filename) {
  try {
    BufferedReader br = new BufferedReader(new FileReader(sketchPath("") + filename));

    int frameCnt = 0;
    String line = "";
    while ((line = br.readLine()) != null) {
      FrameUnit fu = new FrameUnit();
      String[] params = line.split(" ");
      
      fu.id = Integer.parseInt(params[0]);
      for (int i = 0; i < SERVO_NUM; i++) {
        fu.servoDegree[i] = Float.parseFloat(params[i * 2 + 1]);
        fu.rotateTime[i] = Float.parseFloat(params[i * 2 + 2]);
      }
      allFrames[fu.id] = fu;
      frameCnt++;
    }
    return frameCnt;
  } catch (Exception e) {
    println(e.getMessage());
    return -1;
  }
}

void runScript(String filename) {
  int totalFrameCnt = loadScript(filename);
  println("total frame count = " + totalFrameCnt);
  if (totalFrameCnt == -1) return;

  //TODO
  //add your code here
//  example: runFrame(allFrame[frameNumber/ID], delay time(ms));



//YAW
//    runFrame(allFrames[0], 200);
//    runFrame(allFrames[5], 1000);
//    runFrame(allFrames[6], 300);
//    runFrame(allFrames[7], 300);
//    runFrame(allFrames[8], 300);
//    runFrame(allFrames[0], 1000);
//    
////LEFT RIGHT
//    runFrame(allFrames[0], 200);
//    runFrame(allFrames[9], 500);
//    runFrame(allFrames[10], 500);
//    runFrame(allFrames[9], 500);
//    runFrame(allFrames[10], 500);
//    runFrame(allFrames[0], 1000);
////RAISE
//    runFrame(allFrames[0], 200);
//    runFrame(allFrames[11], 500);
//    runFrame(allFrames[12], 500);
//    runFrame(allFrames[13], 1000);
//    runFrame(allFrames[14], 800);
//    runFrame(allFrames[11], 500);
//    runFrame(allFrames[0], 1000);

   
//  runFrame(allFrames[4], 400);
//  runFrame(allFrames[2], 400);
  

//  for (int i = 0; i < totalFrameCnt; i++) {
//    runFrame(allFrames[i], 500);
//  }
}

void runFrame(FrameUnit frame, int frameTime) {
  float[] servoDegreePerMs = new float[SERVO_NUM];
  float[] rotateTimePerMs = new float[SERVO_NUM];
  
  float[] rotVelPerMs = new float[SERVO_NUM];
  int maxRotTime = 0;
  for (int i = 0; i < SERVO_NUM; i++) {
    rotVelPerMs[i] = (frame.servoDegree[i] - servoDegree[i]) / frame.rotateTime[i];
    if (maxRotTime < frame.rotateTime[i]) maxRotTime = (int) frame.rotateTime[i];
  }
  
  if (frameTime == -1) frameTime = maxRotTime;
  for (int ms = 0; ms < frameTime; ms+=10) {
    for (int i = 0; i < SERVO_NUM; i++) {
      if (ms < frame.rotateTime[i]) {
        arduino.servoWrite(SERVO_PIN_ARRAY[i], constrain((int)(servoDegree[i] + rotVelPerMs[i] * 10), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
        servoDegree[i] += rotVelPerMs[i] * 10;
      }
    }
    delay(10);
  }
}

//GUI
void setGuiParams(FrameUnit fr)
{
  textfield27.setText("" + fr.id);
  
  slider1.setValue(fr.servoDegree[0]);
  slider2.setValue(fr.servoDegree[1]);
  slider3.setValue(fr.servoDegree[2]);
  slider4.setValue(fr.servoDegree[3]);
  slider5.setValue(fr.servoDegree[4]);
  slider6.setValue(fr.servoDegree[5]);
  slider7.setValue(fr.servoDegree[6]);
  slider8.setValue(fr.servoDegree[7]);
  
  textfield9.setText("" + fr.servoDegree[0]);
  textfield10.setText("" + fr.servoDegree[1]);
  textfield11.setText("" + fr.servoDegree[2]);
  textfield12.setText("" + fr.servoDegree[3]);
  textfield13.setText("" + fr.servoDegree[4]);
  textfield14.setText("" + fr.servoDegree[5]);
  textfield15.setText("" + fr.servoDegree[6]);
  textfield16.setText("" + fr.servoDegree[7]);

  textfield17.setText("" + fr.rotateTime[0]);
  textfield18.setText("" + fr.rotateTime[1]);
  textfield19.setText("" + fr.rotateTime[2]);
  textfield20.setText("" + fr.rotateTime[3]);
  textfield21.setText("" + fr.rotateTime[4]);
  textfield22.setText("" + fr.rotateTime[5]);
  textfield23.setText("" + fr.rotateTime[6]);
  textfield24.setText("" + fr.rotateTime[7]);
}
//GUI END

//ARDUINO
Arduino arduino;
public static final int SERVO_NUM = 8;

public static final int SERVO_START_PIN = 2;
public static final int SERVO_0_PIN = 2;
public static final int SERVO_1_PIN = 3;
public static final int SERVO_2_PIN = 4;
public static final int SERVO_3_PIN = 5;
public static final int SERVO_4_PIN = 6;
public static final int SERVO_5_PIN = 7;
public static final int SERVO_6_PIN = 8;
public static final int SERVO_7_PIN = 9;
public static final int[] SERVO_PIN_ARRAY = new int[]{SERVO_0_PIN, SERVO_1_PIN, 
    SERVO_2_PIN, SERVO_3_PIN, SERVO_4_PIN, SERVO_5_PIN, SERVO_6_PIN, SERVO_7_PIN};
public static final int SERVO_DEGREE_MIN = 0;
public static final int SERVO_DEGREE_MAX = 180;

public static final int SERVO_DEGREE_INIT = 45;
//ARDUINO END

public static final int FRAME_MAX_NUM = 200;
float[] servoDegree;
FrameUnit[] allFrames;

public void setup(){
    size(810, 540, JAVA2D);
    if(isEditMode) {
      createGUI();
      customGUI();
    }
    
    // Prints out the available serial ports.
    println(Arduino.list());
    
    // Modify this line, by changing the "0" to the index of the serial
    // port corresponding to your Arduino board (as it appears in the list
    // printed by the line above).
    try {
      arduino = new Arduino(this, Arduino.list()[5], 57600);
    }
    catch(Exception e) {
      println(e.getLocalizedMessage());
      exit();
    }
    // Alternatively, use the name of the serial port corresponding to your
    // Arduino (in double-quotes), as in the following line.
    //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);
    
    // Configure digital pins 4 and 7 to control servo motors.
    arduino.pinMode(SERVO_0_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_1_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_2_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_3_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_4_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_5_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_6_PIN, Arduino.SERVO);
    arduino.pinMode(SERVO_7_PIN, Arduino.SERVO);
    
    arduino.servoWrite(SERVO_0_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_1_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_2_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_3_PIN, constrain(SERVO_DEGREE_INIT, 64, 85));
    arduino.servoWrite(SERVO_4_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_5_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_6_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_7_PIN, constrain(SERVO_DEGREE_INIT, SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    
    servoDegree = new float[SERVO_NUM];
    for (int i = 0; i < SERVO_NUM; i++)
      servoDegree[i] = SERVO_DEGREE_INIT;
      
    allFrames = new FrameUnit[FRAME_MAX_NUM];
    for (int i = 0; i < FRAME_MAX_NUM; i++)
      allFrames[i] = new FrameUnit();
      

//    println("button3 - GButton event occured " + System.currentTimeMillis()%10000000 );
//    delay(1000);
//    println("button3 - GButton event occured " + System.currentTimeMillis()%10000000 );
      
  minim = new Minim(this);    
  defaultSketchPath = sketchPath("");
  println(defaultSketchPath + "Sound/v0.wav");
  talker = minim.loadFile(defaultSketchPath + "Sound/v0.wav");
  println("init load done.");
  runScript("newOstrich");
}

void Move(int motionIndex) {
  switch(motionIndex) {
    //say 0 ~ 2, shakehead 0, 1, rollhead 0, yell
    case 0:
      say0();
      break;
    case 1:  
      say1();
      break;
    case 2:
      say2();
      break;
    case 3:
      yell();
      break;
    case 4:
      shakeHead0();
      break;
    case 5:
      shakeHead1();
      break;
    case 6:
      rollHead0();
      break;
    case 7:
      yell();
      break;
    default:
  }
}

public void draw(){
//  if(BGcounter>0){
//      BGcounter-=1;
//  switch(BGcolor){
//    case 0:
//        background(230);
//      break;
//    case 1:
//         background(255,0,0);
//      break;
//    case 2:
//         background(255,100,0);
//      break;
//    case 3:
//         background(255,255,0);
//      break;
//    case 4:
//         background(0,255,0);
//      break;
//    case 5:
//         background(0,0,255);
//      break;
//    case 6:
//         background(100,0,255);
//      break;
//    case 7:
//         background(255,0,255);
//      break;
//    case 8:
//         background(0,255,255);
//      break;
//      
//    }
//  }
//  else{
//    background(230);
//  }
  background(230);
  
  //play random music, mapping to random moves
  if(isEditMode == false) {
    if(idleState == true && talker.isPlaying() == false) {
      int selectedMove = (int)(Math.random() * maxPossibleMoves);

      talker.play();
      println("now playing v" + selectedMove);
      Move(selectedMove);
      delay(5000);
    }
    else if(idleState == false && talker.isPlaying() == false) {
      switch((int)(Math.random() * 2)){
        case 0:
          shakeHead0();
          break;
        case 1:
          shakeHead1();
          break;
        case 2:
          rollHead0();
          break;
      }
      delay(10000);
      
    }
  }
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){
  slider9.setEnabled(false);
  slider10.setEnabled(false);
  slider11.setEnabled(false);
  slider12.setEnabled(false);
  slider13.setEnabled(false);
  slider14.setEnabled(false);
  slider15.setEnabled(false);
  slider16.setEnabled(false);
  
  textfield9.setText("180.00");
  textfield10.setText("85.65");
  textfield11.setText("0.00");
  textfield12.setText("85");
  textfield13.setText("89.52");
  textfield14.setText("100.16");
  textfield15.setText("90");
  textfield16.setText("90");
  
  slider1.setValue(180.00);
  slider2.setValue(85.65);
  slider3.setValue(0.00);
  slider4.setValue(85);
  slider5.setValue(89.52);
  slider6.setValue(100.16);
  slider7.setValue(90);
  slider8.setValue(90);
  
}

void keyPressed() {
  if(isEditMode == false) {
    if(((key == 'q' ) || (key == 'Q')) && (isEditMode == false)) {
      //press q for enable/disable idleState
      idleState = !idleState;
    }
    else if((key == '0' ) && (isEditMode == false)) {
      BGcolor = 0;
      
    }
    else if((key == '1' ) && (isEditMode == false)) {
      BGcolor = 1;
      BGcounter = delayValue ;
    }
    else if((key == '2' ) && (isEditMode == false)) {
      BGcolor = 2;
      BGcounter = delayValue ;
    }
    else if((key == '3' ) && (isEditMode == false)) {
      BGcolor = 3;
      BGcounter = delayValue ;
    }
    else if((key == '4' ) && (isEditMode == false)) {
      BGcolor = 4;
      BGcounter = delayValue ;
    }
    else if((key == '5' ) && (isEditMode == false)) {
      BGcolor = 5;
      BGcounter = delayValue ;
    }
    else if((key == '6' ) && (isEditMode == false)) {
      BGcolor = 6;
      BGcounter = delayValue ;
    }
    else if((key == '7' ) && (isEditMode == false)) {
      BGcolor = 7;
      BGcounter = delayValue ;
    }
    else if((key == '8' ) && (isEditMode == false)) {
      BGcolor = 8;
      BGcounter = delayValue ;
    }
    return;
  }
  if (!checkbox1.isSelected()) return;
  if (key == '1') {
    servoDegree[0] = servoDegree[0] - 1 > SERVO_DEGREE_MIN ? servoDegree[0] - 1 : SERVO_DEGREE_MIN;
    slider1.setValue(servoDegree[0]);
  } else if (key == '2') {
    servoDegree[0] = servoDegree[0] + 1 < SERVO_DEGREE_MAX ? servoDegree[0] + 1 : SERVO_DEGREE_MAX;
    slider1.setValue(servoDegree[0]);
  } else if ((key == 'q') || (key == 'Q')) {
    servoDegree[1] = servoDegree[1] - 1 > SERVO_DEGREE_MIN ? servoDegree[1] - 1 : SERVO_DEGREE_MIN;
    slider2.setValue(servoDegree[1]);
  } else if ((key == 'w') || (key == 'W')) {
    servoDegree[1] = servoDegree[1] + 1 < SERVO_DEGREE_MAX ? servoDegree[1] + 1 : SERVO_DEGREE_MAX;
    slider2.setValue(servoDegree[1]);
  } else if ((key == 'a') || (key == 'A')) {
    servoDegree[2] = servoDegree[2] - 1 > SERVO_DEGREE_MIN ? servoDegree[2] - 1 : SERVO_DEGREE_MIN;
    slider3.setValue(servoDegree[2]);
  } else if ((key == 's') || (key == 'S')) {
    servoDegree[2] = servoDegree[2] + 1 < SERVO_DEGREE_MAX ? servoDegree[2] + 1 : SERVO_DEGREE_MAX;
    slider3.setValue(servoDegree[2]);
  } else if ((key == 'z') || (key == 'Z')) {
    servoDegree[3] = servoDegree[3] - 1 > SERVO_DEGREE_MIN ? servoDegree[3] - 1 : SERVO_DEGREE_MIN;
    slider4.setValue(servoDegree[3]);
  } else if ((key == 'x') || (key == 'X')) {
    servoDegree[3] = servoDegree[3] + 1 < SERVO_DEGREE_MAX ? servoDegree[3] + 1 : SERVO_DEGREE_MAX;
    slider4.setValue(servoDegree[3]);
  } else if (key == '3') {
    servoDegree[4] = servoDegree[4] - 1 > SERVO_DEGREE_MIN ? servoDegree[4] - 1 : SERVO_DEGREE_MIN;
    slider5.setValue(servoDegree[4]);
  } else if (key == '4') {
    servoDegree[4] = servoDegree[4] + 1 < SERVO_DEGREE_MAX ? servoDegree[4] + 1 : SERVO_DEGREE_MAX;
    slider5.setValue(servoDegree[4]);
  } else if ((key == 'e') || (key == 'E')) {
    servoDegree[5] = servoDegree[5] - 1 > SERVO_DEGREE_MIN ? servoDegree[5] - 1 : SERVO_DEGREE_MIN;
    slider6.setValue(servoDegree[5]);
  } else if ((key == 'r') || (key == 'R')) {
    servoDegree[5] = servoDegree[5] + 1 < SERVO_DEGREE_MAX ? servoDegree[5] + 1 : SERVO_DEGREE_MAX;
    slider6.setValue(servoDegree[5]);
  } else if ((key == 'd') || (key == 'D')) {
    servoDegree[6] = servoDegree[6] - 1 > SERVO_DEGREE_MIN ? servoDegree[6] - 1 : SERVO_DEGREE_MIN;
    slider7.setValue(servoDegree[6]);
  } else if ((key == 'f') || (key == 'F')) {
    servoDegree[6] = servoDegree[6] + 1 < SERVO_DEGREE_MAX ? servoDegree[6] + 1 : SERVO_DEGREE_MAX;
    slider7.setValue(servoDegree[6]);
  } else if ((key == 'c') || (key == 'C')) {
    servoDegree[7] = servoDegree[7] - 1 > SERVO_DEGREE_MIN ? servoDegree[7] - 1 : SERVO_DEGREE_MIN;
    slider8.setValue(servoDegree[7]);
  } else if ((key == 't') || (key == 'T')) {
    //run script
    shakeHead1();
    //add code here
  } else if ((key == 'y') || (key == 'Y')) {
    //run script
    shakeHead0();

    //add code here
  } else if ((key == 'u') || (key == 'U')) {
    //run script
    rollHead0();
   
    //add code here
  } else if ((key == 'i') || (key == 'I')) {
    //run script
     //Say
     
    
    //add code here
  } else if ((key == 'o') || (key == 'O')) {
    //run script
    
    //add code here
  } else if ((key == 'p') || (key == 'P')) {
    //run script
    //add code here
  } else if ((key == 'g') || (key == 'G')) {
    //run script
    yell();
    //add code here
  } else if ((key == 'h') || (key == 'H')) {
    //run script
    say0();
    //add code here
  } else if ((key == 'j') || (key == 'J')) {
    //run script
    say1();
    //add code here
  } else if ((key == 'k') || (key == 'K')) {
    //run script
    say2();
    //add code here
  } else if ((key == 'l') || (key == 'L')) {
    //run script
    //add code here
  } else if ((key == 'b') || (key == 'B')) {
    //run script
    //add code here
  } else if ((key == 'n') || (key == 'N')) {
    //run script
    //add code here
  } else if ((key == 'm') || (key == 'M')) {
    //run script
    //add code here
  }
}

void shakeHead0(){
      // shake head
  runFrame(allFrames[0], 200);
  runFrame(allFrames[1], 500);
  runFrame(allFrames[2], 500);
  runFrame(allFrames[1], 400);
  runFrame(allFrames[2], 400);
  runFrame(allFrames[3], 500);
  runFrame(allFrames[4], 500);
  runFrame(allFrames[1], 300);
  runFrame(allFrames[2], 200);
  runFrame(allFrames[0], 800);

}
void shakeHead1(){
      // shake head
  runFrame(allFrames[0], 200);
  runFrame(allFrames[1], 200);
  runFrame(allFrames[2], 500);
  runFrame(allFrames[1], 400);
  runFrame(allFrames[2], 800);
  runFrame(allFrames[0], 800);

}
void rollHead0(){
      // shake head
  runFrame(allFrames[0], 200);
  runFrame(allFrames[20], 1200);
  runFrame(allFrames[21], 600);
  runFrame(allFrames[0], 800);

}
void yell(){
    //
    runFrame(allFrames[0], 200);
    runFrame(allFrames[5], 400);
    runFrame(allFrames[6], 300);
    runFrame(allFrames[7], 300);
    runFrame(allFrames[8], 300);
    runFrame(allFrames[0], 1000);
}
void say0(){
   //Say
    runFrame(allFrames[0], 200);
    runFrame(allFrames[6], 300);
    runFrame(allFrames[8], 300);
    runFrame(allFrames[9], 300);
    runFrame(allFrames[10], 300);
    runFrame(allFrames[0], 500);
    runFrame(allFrames[11], 300);
    runFrame(allFrames[12], 300);
    runFrame(allFrames[0], 1000);

}
void say1(){
    runFrame(allFrames[0], 200);
    runFrame(allFrames[11], 300);
    runFrame(allFrames[0], 500);
    runFrame(allFrames[12], 300);
    runFrame(allFrames[0], 200);
    runFrame(allFrames[11], 300);
    runFrame(allFrames[10], 300);
    runFrame(allFrames[0], 1000);

}
void say2(){
   //Say
    runFrame(allFrames[0], 200);
    runFrame(allFrames[12], 300);
    runFrame(allFrames[0], 200);
    runFrame(allFrames[11], 300);
    runFrame(allFrames[10], 300);
    runFrame(allFrames[12], 300);
    runFrame(allFrames[0], 200);
    runFrame(allFrames[11], 300);
    runFrame(allFrames[0], 1000);

}
  
