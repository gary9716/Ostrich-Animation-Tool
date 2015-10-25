/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void textfield1_change1(GTextField source, GEvent event) { //_CODE_:textfield1:944680:
} //_CODE_:textfield1:944680:

public void slider1_change1(GSlider source, GEvent event) { //_CODE_:slider1:882541:
  textfield9.setText(slider1.getValueS());
  servoDegree[0] = slider1.getValueI();
  arduino.servoWrite(SERVO_0_PIN, constrain(slider1.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
} //_CODE_:slider1:882541:

public void textfield2_change1(GTextField source, GEvent event) { //_CODE_:textfield2:536159:
} //_CODE_:textfield2:536159:

public void textfield3_change1(GTextField source, GEvent event) { //_CODE_:textfield3:867132:
} //_CODE_:textfield3:867132:

public void textfield4_change1(GTextField source, GEvent event) { //_CODE_:textfield4:999188:
} //_CODE_:textfield4:999188:

public void textfield5_change1(GTextField source, GEvent event) { //_CODE_:textfield5:809822:
} //_CODE_:textfield5:809822:

public void textfield6_change1(GTextField source, GEvent event) { //_CODE_:textfield6:990002:
} //_CODE_:textfield6:990002:

public void textfield7_change1(GTextField source, GEvent event) { //_CODE_:textfield7:258287:
} //_CODE_:textfield7:258287:

public void textfield8_change1(GTextField source, GEvent event) { //_CODE_:textfield8:616617:
} //_CODE_:textfield8:616617:

public void slider2_change1(GSlider source, GEvent event) { //_CODE_:slider2:559724:
  arduino.servoWrite(SERVO_1_PIN, constrain(slider2.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
  servoDegree[1] = slider2.getValueI();
  textfield10.setText(slider2.getValueS());
} //_CODE_:slider2:559724:

public void slider3_change1(GSlider source, GEvent event) { //_CODE_:slider3:995839:
  arduino.servoWrite(SERVO_2_PIN, constrain(slider3.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
  servoDegree[2] = slider3.getValueI();
  textfield11.setText(slider3.getValueS());
} //_CODE_:slider3:995839:

public void slider4_change1(GSlider source, GEvent event) { //_CODE_:slider4:409642:
  arduino.servoWrite(SERVO_3_PIN, constrain(slider4.getValueI(), 64, 85));
  servoDegree[3] = slider4.getValueI();
  textfield12.setText(slider4.getValueS());
} //_CODE_:slider4:409642:

public void slider5_change1(GSlider source, GEvent event) { //_CODE_:slider5:903541:
  arduino.servoWrite(SERVO_4_PIN, constrain(slider5.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
  servoDegree[4] = slider5.getValueI();
  textfield13.setText(slider5.getValueS());
} //_CODE_:slider5:903541:

public void slider6_change1(GSlider source, GEvent event) { //_CODE_:slider6:987868:
  arduino.servoWrite(SERVO_5_PIN, constrain(slider6.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
  servoDegree[5] = slider6.getValueI();
  textfield14.setText(slider6.getValueS());
} //_CODE_:slider6:987868:

public void slider7_change1(GSlider source, GEvent event) { //_CODE_:slider7:825980:
  arduino.servoWrite(SERVO_6_PIN, constrain(slider7.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
  servoDegree[6] = slider7.getValueI();
  textfield15.setText(slider7.getValueS());
} //_CODE_:slider7:825980:

public void slider8_change1(GSlider source, GEvent event) { //_CODE_:slider8:754130:
  arduino.servoWrite(SERVO_7_PIN, constrain(slider8.getValueI(), SERVO_DEGREE_MIN, SERVO_DEGREE_MAX));
  servoDegree[7] = slider8.getValueI();
  textfield16.setText(slider8.getValueS());
} //_CODE_:slider8:754130:

public void textfield9_change1(GTextField source, GEvent event) { //_CODE_:textfield9:599927:
  slider1.setValue(Float.parseFloat(textfield9.getText()));
} //_CODE_:textfield9:599927:

public void textfield10_change1(GTextField source, GEvent event) { //_CODE_:textfield10:203169:
  slider2.setValue(Float.parseFloat(textfield10.getText()));
} //_CODE_:textfield10:203169:

public void textfield11_change1(GTextField source, GEvent event) { //_CODE_:textfield11:262466:
  slider3.setValue(Float.parseFloat(textfield11.getText()));
} //_CODE_:textfield11:262466:

public void textfield12_change1(GTextField source, GEvent event) { //_CODE_:textfield12:685218:
  println("textfield12 - GTextField event occured " + System.currentTimeMillis()%10000000 );
  slider4.setValue(Float.parseFloat(textfield12.getText()));
} //_CODE_:textfield12:685218:

public void textfield13_change1(GTextField source, GEvent event) { //_CODE_:textfield13:209135:
  slider5.setValue(Float.parseFloat(textfield13.getText()));
} //_CODE_:textfield13:209135:

public void textfield14_change1(GTextField source, GEvent event) { //_CODE_:textfield14:846759:
  slider6.setValue(Float.parseFloat(textfield14.getText()));
} //_CODE_:textfield14:846759:

public void textfield15_change1(GTextField source, GEvent event) { //_CODE_:textfield15:492161:
  slider7.setValue(Float.parseFloat(textfield15.getText()));
} //_CODE_:textfield15:492161:

public void textfield16_change1(GTextField source, GEvent event) { //_CODE_:textfield16:537480:
  slider8.setValue(Float.parseFloat(textfield16.getText()));
} //_CODE_:textfield16:537480:

public void slider9_change1(GSlider source, GEvent event) { //_CODE_:slider9:927573:
} //_CODE_:slider9:927573:

public void slider10_change1(GSlider source, GEvent event) { //_CODE_:slider10:321774:
} //_CODE_:slider10:321774:

public void slider11_change1(GSlider source, GEvent event) { //_CODE_:slider11:563495:
} //_CODE_:slider11:563495:

public void slider12_change1(GSlider source, GEvent event) { //_CODE_:slider12:453602:
} //_CODE_:slider12:453602:

public void slider13_change1(GSlider source, GEvent event) { //_CODE_:slider13:482425:
} //_CODE_:slider13:482425:

public void slider14_change1(GSlider source, GEvent event) { //_CODE_:slider14:362812:
} //_CODE_:slider14:362812:

public void slider15_change1(GSlider source, GEvent event) { //_CODE_:slider15:518229:
} //_CODE_:slider15:518229:

public void slider16_change1(GSlider source, GEvent event) { //_CODE_:slider16:763017:
} //_CODE_:slider16:763017:

public void textfield17_change1(GTextField source, GEvent event) { //_CODE_:textfield17:472987:
} //_CODE_:textfield17:472987:

public void textfield18_change1(GTextField source, GEvent event) { //_CODE_:textfield18:327797:
} //_CODE_:textfield18:327797:

public void textfield19_change1(GTextField source, GEvent event) { //_CODE_:textfield19:642781:
} //_CODE_:textfield19:642781:

public void textfield20_change1(GTextField source, GEvent event) { //_CODE_:textfield20:434208:
} //_CODE_:textfield20:434208:

public void textfield21_change1(GTextField source, GEvent event) { //_CODE_:textfield21:974359:
} //_CODE_:textfield21:974359:

public void textfield22_change1(GTextField source, GEvent event) { //_CODE_:textfield22:361564:
} //_CODE_:textfield22:361564:

public void textfield23_change1(GTextField source, GEvent event) { //_CODE_:textfield23:630210:
} //_CODE_:textfield23:630210:

public void textfield24_change1(GTextField source, GEvent event) { //_CODE_:textfield24:654526:
} //_CODE_:textfield24:654526:

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:518785:
  appendToScript(textfield25.getText(), textfield27.getText() + ' ' + 
      textfield9.getText() + ' ' + textfield17.getText() + ' ' + 
      textfield10.getText() + ' ' + textfield18.getText() + ' ' + 
      textfield11.getText() + ' ' + textfield19.getText() + ' ' + 
      textfield12.getText() + ' ' + textfield20.getText() + ' ' + 
      textfield13.getText() + ' ' + textfield21.getText() + ' ' + 
      textfield14.getText() + ' ' + textfield22.getText() + ' ' + 
      textfield15.getText() + ' ' + textfield23.getText() + ' ' + 
      textfield16.getText() + ' ' + textfield24.getText() + ' ');
      
      textfield27.setText("" + (Integer.parseInt(textfield27.getText()) + 1));
      
} //_CODE_:button1:518785:

public void textfield25_change1(GTextField source, GEvent event) { //_CODE_:textfield25:734154:
} //_CODE_:textfield25:734154:

public void button2_click1(GButton source, GEvent event) { //_CODE_:button2:370053:
  runScript(textfield26.getText());
} //_CODE_:button2:370053:

public void textfield26_change1(GTextField source, GEvent event) { //_CODE_:textfield26:713328:
} //_CODE_:textfield26:713328:

public void textfield27_change1(GTextField source, GEvent event) { //_CODE_:textfield27:374353:
} //_CODE_:textfield27:374353:

public void button3_click1(GButton source, GEvent event) { //_CODE_:button3:926397:
  if (loadScript(textfield26.getText()) == -1) {
    println("file error");
    return;
  }
  int loadedFrameId = Integer.parseInt(textfield28.getText());
  runFrame(allFrames[loadedFrameId], -1);
  println("load frame " + loadedFrameId);
  setGuiParams(allFrames[loadedFrameId]);
  
} //_CODE_:button3:926397:

public void textfield28_change1(GTextField source, GEvent event) { //_CODE_:textfield28:987175:
} //_CODE_:textfield28:987175:

public void checkbox1_clicked1(GCheckbox source, GEvent event) { //_CODE_:checkbox1:620286:
} //_CODE_:checkbox1:620286:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  if(frame != null)
    frame.setTitle("Sketch Window");
  textfield1 = new GTextField(this, 30, 15, 65, 20, G4P.SCROLLBARS_NONE);
  textfield1.setText("頭頂上下");
  textfield1.setDefaultText("servo 0");
  textfield1.setOpaque(true);
  textfield1.addEventHandler(this, "textfield1_change1");
  slider1 = new GSlider(this, 130, 15, 200, 20, 10.0);
  slider1.setLimits(45.0, 0.0, 180.0);
  slider1.setNumberFormat(G4P.DECIMAL, 2);
  slider1.setOpaque(false);
  slider1.addEventHandler(this, "slider1_change1");
  textfield2 = new GTextField(this, 30, 52, 65, 20, G4P.SCROLLBARS_NONE);
  textfield2.setText("頭頂左右");
  textfield2.setDefaultText("servo 1");
  textfield2.setOpaque(true);
  textfield2.addEventHandler(this, "textfield2_change1");
  textfield3 = new GTextField(this, 30, 89, 65, 20, G4P.SCROLLBARS_NONE);
  textfield3.setText("底部旋轉");
  textfield3.setDefaultText("servo 2");
  textfield3.setOpaque(true);
  textfield3.addEventHandler(this, "textfield3_change1");
  textfield4 = new GTextField(this, 30, 126, 65, 20, G4P.SCROLLBARS_NONE);
  textfield4.setText("鳥嘴開合");
  textfield4.setDefaultText("servo 3");
  textfield4.setOpaque(true);
  textfield4.addEventHandler(this, "textfield4_change1");
  textfield5 = new GTextField(this, 30, 163, 65, 20, G4P.SCROLLBARS_NONE);
  textfield5.setText("底部前後");
  textfield5.setDefaultText("servo 4");
  textfield5.setOpaque(true);
  textfield5.addEventHandler(this, "textfield5_change1");
  textfield6 = new GTextField(this, 30, 200, 65, 20, G4P.SCROLLBARS_NONE);
  textfield6.setText("鳥頭左右");
  textfield6.setDefaultText("servo 5");
  textfield6.setOpaque(true);
  textfield6.addEventHandler(this, "textfield6_change1");
  textfield7 = new GTextField(this, 30, 237, 65, 20, G4P.SCROLLBARS_NONE);
  textfield7.setText("暫時沒用");
  textfield7.setDefaultText("servo 6");
  textfield7.setOpaque(true);
  textfield7.addEventHandler(this, "textfield7_change1");
  textfield8 = new GTextField(this, 30, 274, 65, 20, G4P.SCROLLBARS_NONE);
  textfield8.setText("暫時沒用");
  textfield8.setDefaultText("servo 7");
  textfield8.setOpaque(true);
  textfield8.addEventHandler(this, "textfield8_change1");
  slider2 = new GSlider(this, 130, 52, 200, 20, 10.0);
  slider2.setLimits(45.0, 0.0, 180.0);
  slider2.setNumberFormat(G4P.DECIMAL, 2);
  slider2.setOpaque(false);
  slider2.addEventHandler(this, "slider2_change1");
  slider3 = new GSlider(this, 130, 89, 200, 20, 10.0);
  slider3.setLimits(45.0, 0.0, 180.0);
  slider3.setNumberFormat(G4P.DECIMAL, 2);
  slider3.setOpaque(false);
  slider3.addEventHandler(this, "slider3_change1");
  slider4 = new GSlider(this, 130, 127, 200, 20, 10.0);
  slider4.setLimits(45.0, 0.0, 180.0);
  slider4.setNumberFormat(G4P.DECIMAL, 2);
  slider4.setOpaque(false);
  slider4.addEventHandler(this, "slider4_change1");
  slider5 = new GSlider(this, 130, 163, 200, 20, 10.0);
  slider5.setLimits(45.0, 0.0, 180.0);
  slider5.setNumberFormat(G4P.DECIMAL, 2);
  slider5.setOpaque(false);
  slider5.addEventHandler(this, "slider5_change1");
  slider6 = new GSlider(this, 130, 200, 200, 20, 10.0);
  slider6.setLimits(45.0, 0.0, 180.0);
  slider6.setNumberFormat(G4P.DECIMAL, 2);
  slider6.setOpaque(false);
  slider6.addEventHandler(this, "slider6_change1");
  slider7 = new GSlider(this, 130, 237, 200, 20, 10.0);
  slider7.setLimits(45.0, 0.0, 180.0);
  slider7.setNumberFormat(G4P.DECIMAL, 2);
  slider7.setOpaque(false);
  slider7.addEventHandler(this, "slider7_change1");
  slider8 = new GSlider(this, 130, 274, 200, 20, 10.0);
  slider8.setLimits(45.0, 0.0, 180.0);
  slider8.setNumberFormat(G4P.DECIMAL, 2);
  slider8.setOpaque(false);
  slider8.addEventHandler(this, "slider8_change1");
  textfield9 = new GTextField(this, 335, 15, 70, 20, G4P.SCROLLBARS_NONE);
  textfield9.setText("90");
  textfield9.setDefaultText("90");
  textfield9.setOpaque(true);
  textfield9.addEventHandler(this, "textfield9_change1");
  textfield10 = new GTextField(this, 335, 52, 70, 20, G4P.SCROLLBARS_NONE);
  textfield10.setText("90");
  textfield10.setDefaultText("90");
  textfield10.setOpaque(true);
  textfield10.addEventHandler(this, "textfield10_change1");
  textfield11 = new GTextField(this, 335, 89, 70, 20, G4P.SCROLLBARS_NONE);
  textfield11.setText("90");
  textfield11.setDefaultText("90");
  textfield11.setOpaque(true);
  textfield11.addEventHandler(this, "textfield11_change1");
  textfield12 = new GTextField(this, 337, 126, 70, 20, G4P.SCROLLBARS_NONE);
  textfield12.setText("90");
  textfield12.setDefaultText("90");
  textfield12.setOpaque(true);
  textfield12.addEventHandler(this, "textfield12_change1");
  textfield13 = new GTextField(this, 335, 163, 70, 20, G4P.SCROLLBARS_NONE);
  textfield13.setText("90");
  textfield13.setDefaultText("90");
  textfield13.setOpaque(true);
  textfield13.addEventHandler(this, "textfield13_change1");
  textfield14 = new GTextField(this, 335, 200, 70, 20, G4P.SCROLLBARS_NONE);
  textfield14.setText("90");
  textfield14.setDefaultText("90");
  textfield14.setOpaque(true);
  textfield14.addEventHandler(this, "textfield14_change1");
  textfield15 = new GTextField(this, 337, 238, 70, 20, G4P.SCROLLBARS_NONE);
  textfield15.setText("90");
  textfield15.setDefaultText("90");
  textfield15.setOpaque(true);
  textfield15.addEventHandler(this, "textfield15_change1");
  textfield16 = new GTextField(this, 335, 274, 70, 20, G4P.SCROLLBARS_NONE);
  textfield16.setText("90");
  textfield16.setDefaultText("90");
  textfield16.setOpaque(true);
  textfield16.addEventHandler(this, "textfield16_change1");
  slider9 = new GSlider(this, 540, 15, 100, 20, 10.0);
  slider9.setLimits(0.5, 0.0, 1.0);
  slider9.setNumberFormat(G4P.DECIMAL, 2);
  slider9.setOpaque(false);
  slider9.addEventHandler(this, "slider9_change1");
  slider10 = new GSlider(this, 540, 52, 100, 20, 10.0);
  slider10.setLimits(0.5, 0.0, 1.0);
  slider10.setNumberFormat(G4P.DECIMAL, 2);
  slider10.setOpaque(false);
  slider10.addEventHandler(this, "slider10_change1");
  slider11 = new GSlider(this, 540, 89, 100, 20, 10.0);
  slider11.setLimits(0.5, 0.0, 1.0);
  slider11.setNumberFormat(G4P.DECIMAL, 2);
  slider11.setOpaque(false);
  slider11.addEventHandler(this, "slider11_change1");
  slider12 = new GSlider(this, 540, 126, 100, 20, 10.0);
  slider12.setLimits(0.5, 0.0, 1.0);
  slider12.setNumberFormat(G4P.DECIMAL, 2);
  slider12.setOpaque(false);
  slider12.addEventHandler(this, "slider12_change1");
  slider13 = new GSlider(this, 540, 163, 100, 20, 10.0);
  slider13.setLimits(0.5, 0.0, 1.0);
  slider13.setNumberFormat(G4P.DECIMAL, 2);
  slider13.setOpaque(false);
  slider13.addEventHandler(this, "slider13_change1");
  slider14 = new GSlider(this, 540, 200, 100, 20, 10.0);
  slider14.setLimits(0.5, 0.0, 1.0);
  slider14.setNumberFormat(G4P.DECIMAL, 2);
  slider14.setOpaque(false);
  slider14.addEventHandler(this, "slider14_change1");
  slider15 = new GSlider(this, 540, 237, 100, 20, 10.0);
  slider15.setLimits(0.5, 0.0, 1.0);
  slider15.setNumberFormat(G4P.DECIMAL, 2);
  slider15.setOpaque(false);
  slider15.addEventHandler(this, "slider15_change1");
  label1 = new GLabel(this, 455, 15, 80, 20);
  label1.setText("旋轉時間");
  label1.setOpaque(false);
  label2 = new GLabel(this, 455, 52, 80, 20);
  label2.setText("旋轉時間");
  label2.setOpaque(false);
  label3 = new GLabel(this, 455, 89, 80, 20);
  label3.setText("旋轉時間");
  label3.setOpaque(false);
  label4 = new GLabel(this, 455, 126, 80, 20);
  label4.setText("旋轉時間");
  label4.setOpaque(false);
  label5 = new GLabel(this, 455, 163, 80, 20);
  label5.setText("旋轉時間");
  label5.setOpaque(false);
  label6 = new GLabel(this, 455, 200, 80, 20);
  label6.setText("旋轉時間");
  label6.setOpaque(false);
  label7 = new GLabel(this, 455, 237, 80, 20);
  label7.setText("旋轉時間");
  label7.setOpaque(false);
  label8 = new GLabel(this, 455, 274, 80, 20);
  label8.setText("旋轉時間");
  label8.setOpaque(false);
  slider16 = new GSlider(this, 540, 274, 100, 20, 10.0);
  slider16.setLimits(0.5, 0.0, 1.0);
  slider16.setNumberFormat(G4P.DECIMAL, 2);
  slider16.setOpaque(false);
  slider16.addEventHandler(this, "slider16_change1");
  textfield17 = new GTextField(this, 645, 15, 50, 20, G4P.SCROLLBARS_NONE);
  textfield17.setText("500");
  textfield17.setDefaultText("500");
  textfield17.setOpaque(true);
  textfield17.addEventHandler(this, "textfield17_change1");
  textfield18 = new GTextField(this, 645, 52, 50, 20, G4P.SCROLLBARS_NONE);
  textfield18.setText("500");
  textfield18.setDefaultText("500");
  textfield18.setOpaque(true);
  textfield18.addEventHandler(this, "textfield18_change1");
  textfield19 = new GTextField(this, 645, 89, 50, 20, G4P.SCROLLBARS_NONE);
  textfield19.setText("500");
  textfield19.setDefaultText("500");
  textfield19.setOpaque(true);
  textfield19.addEventHandler(this, "textfield19_change1");
  textfield20 = new GTextField(this, 645, 126, 50, 20, G4P.SCROLLBARS_NONE);
  textfield20.setText("500");
  textfield20.setDefaultText("500");
  textfield20.setOpaque(true);
  textfield20.addEventHandler(this, "textfield20_change1");
  textfield21 = new GTextField(this, 645, 163, 50, 20, G4P.SCROLLBARS_NONE);
  textfield21.setText("500");
  textfield21.setDefaultText("500");
  textfield21.setOpaque(true);
  textfield21.addEventHandler(this, "textfield21_change1");
  textfield22 = new GTextField(this, 645, 200, 50, 20, G4P.SCROLLBARS_NONE);
  textfield22.setText("500");
  textfield22.setDefaultText("500");
  textfield22.setOpaque(true);
  textfield22.addEventHandler(this, "textfield22_change1");
  textfield23 = new GTextField(this, 645, 237, 50, 20, G4P.SCROLLBARS_NONE);
  textfield23.setText("500");
  textfield23.setDefaultText("500");
  textfield23.setOpaque(true);
  textfield23.addEventHandler(this, "textfield23_change1");
  textfield24 = new GTextField(this, 645, 274, 50, 20, G4P.SCROLLBARS_NONE);
  textfield24.setText("500");
  textfield24.setDefaultText("500");
  textfield24.setOpaque(true);
  textfield24.addEventHandler(this, "textfield24_change1");
  button1 = new GButton(this, 224, 324, 80, 30);
  button1.setText("儲存幀");
  button1.addEventHandler(this, "button1_click1");
  textfield25 = new GTextField(this, 395, 324, 300, 30, G4P.SCROLLBARS_NONE);
  textfield25.setText("testfile1");
  textfield25.setDefaultText("testfile1");
  textfield25.setOpaque(true);
  textfield25.addEventHandler(this, "textfield25_change1");
  button2 = new GButton(this, 30, 390, 80, 30);
  button2.setText("播放腳本");
  button2.addEventHandler(this, "button2_click1");
  textfield26 = new GTextField(this, 130, 390, 565, 30, G4P.SCROLLBARS_NONE);
  textfield26.setText("testfile1");
  textfield26.setDefaultText("testfile1");
  textfield26.setOpaque(true);
  textfield26.addEventHandler(this, "textfield26_change1");
  textfield27 = new GTextField(this, 117, 324, 100, 30, G4P.SCROLLBARS_NONE);
  textfield27.setText("0");
  textfield27.setDefaultText("0");
  textfield27.setOpaque(true);
  textfield27.addEventHandler(this, "textfield27_change1");
  label9 = new GLabel(this, 28, 329, 80, 20);
  label9.setText("本幀編號");
  label9.setOpaque(false);
  label10 = new GLabel(this, 311, 329, 80, 20);
  label10.setText("文件名");
  label10.setOpaque(false);
  button3 = new GButton(this, 30, 443, 80, 30);
  button3.setText("播放幀");
  button3.addEventHandler(this, "button3_click1");
  textfield28 = new GTextField(this, 130, 444, 160, 30, G4P.SCROLLBARS_NONE);
  textfield28.setText("0");
  textfield28.setDefaultText("0");
  textfield28.setOpaque(true);
  textfield28.addEventHandler(this, "textfield28_change1");
  checkbox1 = new GCheckbox(this, 578, 452, 120, 20);
  checkbox1.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  checkbox1.setText("功能鍵開關");
  checkbox1.setOpaque(false);
  checkbox1.addEventHandler(this, "checkbox1_clicked1");
}

// Variable declarations 
// autogenerated do not edit
GTextField textfield1; 
GSlider slider1; 
GTextField textfield2; 
GTextField textfield3; 
GTextField textfield4; 
GTextField textfield5; 
GTextField textfield6; 
GTextField textfield7; 
GTextField textfield8; 
GSlider slider2; 
GSlider slider3; 
GSlider slider4; 
GSlider slider5; 
GSlider slider6; 
GSlider slider7; 
GSlider slider8; 
GTextField textfield9; 
GTextField textfield10; 
GTextField textfield11; 
GTextField textfield12; 
GTextField textfield13; 
GTextField textfield14; 
GTextField textfield15; 
GTextField textfield16; 
GSlider slider9; 
GSlider slider10; 
GSlider slider11; 
GSlider slider12; 
GSlider slider13; 
GSlider slider14; 
GSlider slider15; 
GLabel label1; 
GLabel label2; 
GLabel label3; 
GLabel label4; 
GLabel label5; 
GLabel label6; 
GLabel label7; 
GLabel label8; 
GSlider slider16; 
GTextField textfield17; 
GTextField textfield18; 
GTextField textfield19; 
GTextField textfield20; 
GTextField textfield21; 
GTextField textfield22; 
GTextField textfield23; 
GTextField textfield24; 
GButton button1; 
GTextField textfield25; 
GButton button2; 
GTextField textfield26; 
GTextField textfield27; 
GLabel label9; 
GLabel label10; 
GButton button3; 
GTextField textfield28; 
GCheckbox checkbox1; 

