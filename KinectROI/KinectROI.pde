import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float deg;

boolean ir = false;
boolean colorDepth = false;
boolean mirror = false;
PImage kImg;
Vector<ROI> ROIContainer;
Iterator<ROI> it_roi;
int actMouseX,actMouseY;

void setup() {
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableColorDepth(true);
  ROIContainer = new Vector<ROI>();
}

void draw() {
  background(0);
  kImg = kinect.getDepthImage();
  image(kinect.getDepthImage(), 0, 0);
  
  for(int i=0;i<ROIContainer.size();++i)
  {
    ROIContainer.get(i).visualize(kImg);
  }
}

void keyPressed() {
  if (key == 'c') {
    color actColor = kImg.pixels[mouseX+mouseY*kImg.width];
    actColor &= 0x00FFFFFF; 
    println(hex(actColor)+" color("+((actColor >> 16)&0x0000FF)+", "+((actColor >> 8)&0x0000FF)+", "+(actColor & 0xFF)+")");
  }
}

void mousePressed() {
  if (mouseButton == RIGHT)
  {
    if(!ROIContainer.isEmpty())ROIContainer.remove(ROIContainer.lastElement());
  }else
  {
    actMouseX = mouseX;
    actMouseY = mouseY;
  }
}
void mouseReleased() {
  if (mouseButton != RIGHT)
  {
    ROIContainer.addElement(new ROI(actMouseX,actMouseY,mouseX-actMouseX,mouseX-actMouseX));
  }
}