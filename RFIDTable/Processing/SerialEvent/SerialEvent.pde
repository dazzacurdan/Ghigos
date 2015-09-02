import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import processing.serial.*;

KeystrokeSimulator keySim;
OSCSender          osc;

boolean enableOSC = false, sended=false;

Robot robot; 
import processing.serial.*; 
 
Serial myPort;    // The serial port
String inString="-1";  // Input string from serial port

 
void setup() { 
  size(400,200); 
  keySim = new KeystrokeSimulator();
  osc = new OSCSender(1201,12000);
  // List all the available serial ports: 
  println(Serial.list()); 
  // I know that the first port in the serial list on my mac 
  // is always my  Keyspan adaptor, so I open Serial.list()[0]. 
  // Open whatever port is the one you're using. 
  myPort = new Serial(this, Serial.list()[4], 9600); 
  myPort.buffer(1);
} 
 
void draw() { 
  background(0); 
  text("Play video: " + inString, 10,50);
} 
 
void serialEvent(Serial p) { 
  inString = p.readString();
  int videoID = Integer.parseInt(inString);
  println(videoID);
  try{
    switch(videoID){
      case 0:
        sended = enableOSC ? osc.send("/2/push1") : keySim.simulate(KeyEvent.VK_Q);
      break;
      case 1:
        sended = enableOSC ? osc.send("/2/push2") : keySim.simulate(KeyEvent.VK_W);
      break;
      case 2:
        sended = enableOSC ? osc.send("/2/push3") : keySim.simulate(KeyEvent.VK_E);
      break;
      case 3:
        sended = enableOSC ? osc.send("/2/push4") : keySim.simulate(KeyEvent.VK_R);
      break;
      case 4:
        sended = enableOSC ? osc.send("/2/push5") : keySim.simulate(KeyEvent.VK_T);
      break;
      case 5:
        sended = enableOSC ? osc.send("/2/push6") : keySim.simulate(KeyEvent.VK_Y);
      break;
      case 6:
        sended = enableOSC ? osc.send("/2/push7") : keySim.simulate(KeyEvent.VK_U);
      break;
      case 7:
        sended = enableOSC ? osc.send("/2/push8") : keySim.simulate(KeyEvent.VK_I);
      break;
      case 8:
        sended = enableOSC ? osc.send("/2/push9") : keySim.simulate(KeyEvent.VK_O);
      break;
      case 9:
        sended = enableOSC ? osc.send("/2/push10") : keySim.simulate(KeyEvent.VK_P);
      break;
      case 10:
        sended = enableOSC ? osc.send("/2/push11") : keySim.simulate(KeyEvent.VK_A);
      break;
      case 11:
        sended = enableOSC ? osc.send("/2/push12") : keySim.simulate(KeyEvent.VK_S);
      break;
    }
  }catch(AWTException e){
    println(e);
  }
}
