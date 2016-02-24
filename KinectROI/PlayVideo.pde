import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.Robot;
import java.awt.AWTException;
import java.util.Random;

class PlayVideo
{
  private KeystrokeSimulator keySim;
  private Random rand;
  
  PlayVideo()
  {
     rand = new Random();
     keySim = new KeystrokeSimulator();
  }
  void play( int area )
  {
    try
    {
      
      //RAND STRATEGY
      /* 
      int randValue = rand.nextInt(numberOfVideo);
      println("RandValue: "+randValue+" char: "+(char)videos[area][randValue]);
      keySim.simulate(videos[area][randValue]);
      */
      //SEQUENTIAL
      /**/
      //println("RandValue: "+count[area]+" char: "+(char)videos[area][count[area]]);
      keySim.simulate(videos[area][count[area]]);
      println("Sended: "+(char)(videos[area][count[area]]));
      count[area] = (++count[area])%numberOfVideo;
      println("Spazio: "+count[0]+" Parola: "+count[1]+" Tempo: "+count[2]);
    }catch(AWTException e){
      println(e);
    }
  }
  private int numberOfVideo = 5;
  private int count[] = {0,0,0};
  private int videos[][] =
  { 
	{KeyEvent.VK_H,KeyEvent.VK_J,KeyEvent.VK_K,KeyEvent.VK_L,KeyEvent.VK_Z}, 
    {KeyEvent.VK_A,KeyEvent.VK_S,KeyEvent.VK_D,KeyEvent.VK_F,KeyEvent.VK_G},
    {KeyEvent.VK_X,KeyEvent.VK_C,KeyEvent.VK_V,KeyEvent.VK_B,KeyEvent.VK_N}
  };
  
}
