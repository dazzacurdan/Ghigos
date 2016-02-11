import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.util.Random;

class PlayVideo
{
  PlayVideo()
  {
     rand = new Random();
  }
  void play( int area )
  {
    try
    {
      println((char)videos[area][rand.nextInt(5)]);
      keySim.simulate(videos[area][rand.nextInt(5)]);
    }catch(AWTException e){
      println(e);
    }
  }
  private int videos[][] =
  { 
    {KeyEvent.VK_Q,KeyEvent.VK_W,KeyEvent.VK_E,KeyEvent.VK_R,KeyEvent.VK_T},
    {KeyEvent.VK_A,KeyEvent.VK_S,KeyEvent.VK_D,KeyEvent.VK_F,KeyEvent.VK_G},
    {KeyEvent.VK_Z,KeyEvent.VK_X,KeyEvent.VK_C,KeyEvent.VK_V,KeyEvent.VK_B}
  };
  private KeystrokeSimulator keySim;
  private Random rand;
}