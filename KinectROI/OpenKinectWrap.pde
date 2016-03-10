import org.openkinect.freenect.*;
import org.openkinect.processing.*;

public class OpenKinectWrap extends KinectWrap
{
  OpenKinectWrap(PApplet app)
  {
    m_numDevices = Kinect.countDevices();
    println("number of Kinect v1 devices  "+m_numDevices);
    switch()
    {
      case 1:
      w = 640;h = 480;
      break;
      case 2:
      h=640;w=2*480;
    }
    m_multiKinect = new ArrayList<Kinect>();
    
    for (int i  = 0; i < m_numDevices; i++) {
      Kinect tmpKinect = new Kinect(app);
      tmpKinect.activateDevice(i);
      tmpKinect.initDepth();
      tmpKinect.enableColorDepth(true);
      m_multiKinect.add(tmpKinect);
    }
  }
  PImage getDepthImage()
  {
    PImage out = new PImage();
    switch(m_numDevices)
    {
      case 1:
      {
        out = m_multiKinect.get(0).getDepthImage();
      }
      break;
      case 2:
      {
          PGraphics output = createGraphics(3840, 1080, JAVA2D);
          output.beginDraw();
          output.pushMatrix();
            output.imageMode(CENTER);
            output.translate(width >> 2,height >> 1);
            output.rotate(PI+HALF_PI);
            output.image(m_multiKinect.get(0).getDepthImage(), 0, 0);
          output.popMatrix();
          output.pushMatrix();
            output.imageMode(CENTER);
            output.translate( (width >> 1)+(width >> 2),height >> 1);
            output.rotate(HALF_PI);
            output.image(m_multiKinect.get(1).getDepthImage(), 0, 0);
          output.popMatrix();
          output.endDraw();
          out = output;
      }
      break;
    }
    return out;
  }
  public int w,h;
  private ArrayList<Kinect> m_multiKinect;
  private int m_numDevices;
}