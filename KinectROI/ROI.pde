import java.util.*;

//package ghigos.kinect;

public class ROI
{

  ROI( int x, int y, int w, int h )
  {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.size = w * h;
    avg_color = color(50,0,0);
    coverage=0;
  }
  void visualize(PImage kImg)
  {
    coverage=0;
    stroke(255,0,0);
    noFill();
    rect(x, y, w, h);
    if( isActive(kImg) )
    {
      fill(0,255,0);
      rect(x, y, w, h);
    }
    fill(255,255,255);
    textSize(10);
    text("("+x+", "+y+", "+w+", "+h+") "+coverage+"%",x,y-2);
  }
  boolean isActive( PImage kImg)
  {
    color c;
    int roiH = y+h;
    int roiW = x+w;
    for( int _y=y;_y<roiH;++_y )
      for( int _x=x;_x<roiW;++_x )
      {
        c = kImg.pixels[_x+(_y*(kImg.width))];
        if( c > avg_color ) ++coverage;
      }
    coverage/=size; 
    if( coverage > 0.8  )
      return true;
    return false;
  }
  
  private int x;
  private int y;
  private int w;
  private int h;
  private float size;
  private color avg_color;
  private float coverage;
}