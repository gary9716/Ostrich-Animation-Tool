import java.io.FileReader;
import java.io.FileOutputStream;
import processing.serial.*;
import cc.arduino.*;

//ARDUINO
public static final int SERVO_NUM = 8;
public static final int SERVO_0_PIN = 2;
public static final int SERVO_1_PIN = 3;
public static final int SERVO_2_PIN = 4;
public static final int SERVO_3_PIN = 5;
public static final int SERVO_4_PIN = 6;
public static final int SERVO_5_PIN = 7;
public static final int SERVO_6_PIN = 8;
public static final int SERVO_7_PIN = 9;
public static final int[] SERVO_PIN_ARRAY = new int[]{SERVO_0_PIN, SERVO_1_PIN, SERVO_2_PIN, SERVO_3_PIN, SERVO_4_PIN, SERVO_5_PIN, SERVO_6_PIN, SERVO_7_PIN};
public static final int SERVO_DEGREE_MIN = 0;
public static final int SERVO_DEGREE_MAX = 180;
public static final int SERVO_DEGREE_INIT = 45;

public static final int FRAME_MAX_NUM = 200;

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
}

Arduino arduino;
FrameUnit[] allFrames;
float[] servoDegree;

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
        if (i == 3) {
          arduino.servoWrite(SERVO_PIN_ARRAY[i], constrain((int)(servoDegree[i] + rotVelPerMs[i] * 10), 64, 85));
        } else {
          arduino.servoWrite(SERVO_PIN_ARRAY[i], constrain((int)(servoDegree[i] + rotVelPerMs[i] * 10), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
        }
        servoDegree[i] += rotVelPerMs[i] * 10;
      }
    }
    delay(10);
  }
}

public void arduinoInit(){    
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
    for (int i = 0; i < SERVO_NUM; i++) {
      arduino.pinMode(SERVO_PIN_ARRAY[i], Arduino.SERVO);
    }

    servoDegree = new float[]{180, 85.65, 0, 85, 89.52, 100.16, 90, 90};
    
    allFrames = new FrameUnit[FRAME_MAX_NUM];
    for (int i = 0; i < FRAME_MAX_NUM; i++)
      allFrames[i] = new FrameUnit(); 

    arduino.servoWrite(SERVO_0_PIN, constrain((int)servoDegree[0], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_1_PIN, constrain((int)servoDegree[1], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_2_PIN, constrain((int)servoDegree[2], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_3_PIN, constrain((int)servoDegree[3], 64, 85));
    arduino.servoWrite(SERVO_4_PIN, constrain((int)servoDegree[4], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_5_PIN, constrain((int)servoDegree[5], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_6_PIN, constrain((int)servoDegree[6], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
    arduino.servoWrite(SERVO_7_PIN, constrain((int)servoDegree[7], SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
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
  