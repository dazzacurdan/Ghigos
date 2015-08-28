import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import processing.serial.*;

KeystrokeSimulator keySim;
OSCSender          osc;

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
  //try{
    switch(videoID){
      case 0:
        //keySim.simulate(KeyEvent.VK_Q);
        osc.send("/2/push1");
      break;
      case 1:
        //keySim.simulate(KeyEvent.VK_W);
        osc.send("/pappo");
      break;
    }
  /*}catch(AWTException e){
    println(e);
  }*/
}
