import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

boolean ir = false;
boolean colorDepth = false;
boolean mirror = false;
PImage kImg;
Vector<ROI> ROIContainer;
Iterator<ROI> it_roi;
int actMouseX,actMouseY;
boolean lock;
int startTime;
PlayVideo video;
ConfigParser parser;
boolean lockROIContainer;

void setup() {
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableColorDepth(true);
  ROIContainer = new Vector<ROI>();
  video = new PlayVideo();
  lock = false;
  parser =new ConfigParser();
  lockROIContainer = parser.loadROI("config.xml",ROIContainer);
}

void draw() {
  background(0);
  kImg = kinect.getDepthImage();
  image(kinect.getDepthImage(), 0, 0);
  
  for(int i=0;i<ROIContainer.size();++i)
  {
    if( ROIContainer.get(i).visualize(kImg) && !lock)
    {
      startTime = millis();
      video.play(i);
      thread("lockFunction");
    }
  }
  if(lock)
  {
    fill(0, 102, 153);
    textSize(150);
    text((int)((millis()-startTime)/1e3),213,240);
  }
}
void lockFunction()
{
  lock = true;
  delay(45000);
  lock = false;
}
void keyPressed() {
  switch (key) 
  {
    case 'c':
    {
      color actColor = kImg.pixels[mouseX+mouseY*kImg.width];
      actColor &= 0x00FFFFFF; 
      println(hex(actColor)+" color("+((actColor >> 16)&0x0000FF)+", "+((actColor >> 8)&0x0000FF)+", "+(actColor & 0xFF)+")");
    }
     break;
    case 's':
    {
      if(!lockROIContainer )
      {
        XML xml = loadXML("roi.xml");
        xml.setName("Regions");
        for(int i=0;i<ROIContainer.size();++i)
        {
           XML child = xml.addChild("roi");
          child.setInt( "id", i );
          child.setInt( "x", ROIContainer.get(i).x );
          child.setInt( "y", ROIContainer.get(i).y );
          child.setInt( "w", ROIContainer.get(i).w );
          child.setInt( "h", ROIContainer.get(i).h );
          
          child.setContent(Integer.toString(ROIContainer.get(i).getAvgColor()));
        }
        saveXML(xml,"config.xml");
      }
    }
    break;
    case 'a':
    {
      ROIContainer.lastElement().setAvgColor( kImg.pixels[mouseX+mouseY*kImg.width] );
    }
    break;
  }
}
void mousePressed() {
  if (mouseButton == RIGHT && !lockROIContainer)
  {
    if(!ROIContainer.isEmpty())ROIContainer.remove(ROIContainer.lastElement());
  }else
  {
    actMouseX = mouseX;
    actMouseY = mouseY;
  }
}
void mouseReleased() {
  if (mouseButton != RIGHT && !lockROIContainer)
  {
    ROIContainer.addElement(new ROI(actMouseX,actMouseY,mouseX-actMouseX,mouseX-actMouseX));
  }
}