import oscP5.*;
import netP5.*;
 
public class OSCSender{
  private OscP5 oscP5;
  private NetAddress myRemoteLocation;
  OscMessage myMessage;
  
  OSCSender(int readPort,int writePort){
    oscP5 = new OscP5(this,readPort);
    // set the remote location to be the localhost on port 5001
    myRemoteLocation = new NetAddress("127.0.0.1",writePort);
  }
  void send(String tagName){
    println("Send: "+tagName);
    myMessage = new OscMessage(tagName);
 
    myMessage.add(123); // add an int to the osc message
    //myMessage.add(12.34); // add a float to the osc message 
    //myMessage.add("some text!"); // add a string to the osc message
 
    // send the message
    oscP5.send(myMessage, myRemoteLocation); 
  }
  
}
