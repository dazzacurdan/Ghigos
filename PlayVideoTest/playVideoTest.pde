import netP5.*;
import oscP5.*;

import java.awt.Robot;
import java.awt.AWTException;
import java.util.Random;

import java.awt.event.KeyEvent;

public enum PlayType
{
  RANDOM,
  SEQUENTIAL
}

abstract class PlayVideo
{
  PlayVideo(PlayType playType)
  {
    println("Init PlayVideo, mode is: "+playType);
    m_playType = playType;
    switch(m_playType)
    {
      case RANDOM:
      {
        m_rand = new Random();
      }
      break;
      case SEQUENTIAL:
      {
        m_count = new int[]{0,0,0};
      }
      break;
    }
    m_videos = new int[][]
    { {KeyEvent.VK_A,KeyEvent.VK_S,KeyEvent.VK_D,KeyEvent.VK_F,KeyEvent.VK_G},
      {KeyEvent.VK_H,KeyEvent.VK_J,KeyEvent.VK_K,KeyEvent.VK_L,KeyEvent.VK_Z},
      {KeyEvent.VK_X,KeyEvent.VK_C,KeyEvent.VK_V,KeyEvent.VK_B,KeyEvent.VK_N}
    };
    m_numberOfVideo = 5;
  }
  public int getVideoID(int area)
  {
    //println("count0: "+m_count[0]+" count1: "+m_count[1]+" count2: "+m_count[2]);
    int videoId = -1;
    switch(m_playType)
    {
      case RANDOM:
      {
        videoId = m_videos[area][m_count[m_rand.nextInt(m_numberOfVideo)]];
      }
      break;
      case SEQUENTIAL:
      {
        videoId = m_videos[area][m_count[area]];
        m_count[area] = (++m_count[area])%m_numberOfVideo;
      }
      break;
    }
    return videoId;
  }
  abstract boolean play(int area);
  protected int[] m_count;
  protected int[][] m_videos;
  protected int m_numberOfVideo;
  private Random m_rand;
  private PlayType m_playType;
}
public class PlayVideoOSC extends PlayVideo
{
  PlayVideoOSC(PlayType playType,String ip,int port)
  {
    super(playType);
    m_port = port;
    m_oscP5 = new OscP5(this,m_port);
    m_remoteLocation = new NetAddress(ip,m_port);
    m_message = new OscMessage("");
    playBackGround();
  }
  boolean playBackGround()
  {
    OscBundle bundle =new OscBundle();
    m_message.setAddrPattern("/Q");
    m_message.add(1.0);
    bundle.add(m_message);
    m_message.clear();
    
    m_message.setAddrPattern("/W");
    m_message.add(1.0);
    bundle.add(m_message);
    m_message.clear();
    
    m_message.setAddrPattern("/E");
    m_message.add(1.0);
    bundle.add(m_message);
    
    m_oscP5.send(bundle, m_remoteLocation);
    return true;
    
  }
  boolean play(int area)
  {
    int videoId = getVideoID(area);
    println("Send videoId: "+"/"+((char)videoId));
    m_message.setAddrPattern("/"+((char)videoId));
    m_message.add(1.0);
    m_oscP5.send(m_message, m_remoteLocation);
    return true;
  }
  private OscP5 m_oscP5;
  private int m_port;
  OscMessage m_message;
  NetAddress m_remoteLocation;
}

public class PlayVideoKeyBoard extends PlayVideo
{
  PlayVideoKeyBoard(PlayType playType,int delay)
  {
    super(playType);
    m_delay = delay;
    try{
      m_robot = new Robot();  
    }catch(AWTException e){
      println(e);
    }
  }
  void keyboardEvent(int videoId) throws AWTException
  {
    m_robot.keyPress(videoId);
    m_robot.delay(m_delay);
    m_robot.keyRelease(videoId);
  }
  boolean play(int area)
  {
    try
    {
      keyboardEvent(getVideoID(area));
    }catch(AWTException e)
    {
      println(e);
    }
    return true;
  }
  private Robot m_robot;
  private int m_delay;
}
PlayVideoOSC playVideo;
int count;
void setup()
{
  playVideo = new PlayVideoOSC(PlayType.SEQUENTIAL,"127.0.0.1",12000);
  count = 0;
  size(400,400);
  frameRate(25);
}
void draw()
{
  background(0);
}
void mousePressed()
{
  playVideo.play(count%3);
  ++count;
}