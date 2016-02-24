import processing.video.*;
import processing.opengl.*;
Movie myMovie;

PImage tex;
float rotx = PI/4, roty = PI/4, rotz = PI/4;
float incX=0; float incY=0;
int xw,yw;
PyramidalPattern device;
PyramidFace prova;
Point base,top,center,pyramidH;
float aspect;
void setup(){
  size(800, 600, P3D);
  //size(320, 240, P3D);
  //size(1024, 768, P3D);
  aspect = 3.0/4.0;
  //aspect = 9.0/16.0;
  println("Aspect "+aspect);
  device = new PyramidalPattern(184,(int)(184*aspect),width,height);
  /*
  base = _device.metric2Pixel(new Point(10,10));
  top =  _device.metric2Pixel(new Point(60,60));
  pyramidH = _device.metric2Pixel(new Point(35,35));
  center = _device.getCenter();
  println("base: "+base.x+" "+base.y);
  println("top: "+top.x+" "+top.y);
  println("center: "+center.x+" "+center.y);
  println("pyramidH: "+pyramidH.x+" "+pyramidH.y);
  prova = new PyramidFace(new Point(center.x-(base.x/2),center.y-(base.y/2)),
                          new Point(center.x-( top.x/2),(center.y-pyramidH.y)-(base.y/2)),
                          new Point(center.x+( top.x/2),(center.y-pyramidH.y)-(base.y/2)),
                          new Point(center.x+(base.x/2),center.y-(base.y/2)));*/
  //device = new PyramidalPattern(110,62, width, height);
  //myMovie = new Movie(this, "station.mov");
  //myMovie.speed(1);
  //myMovie.loop();

  //textureMode(NORMALIZED);
}


void draw(){
  
  //println("base: "+base.x+" "+base.y);
  //println("top: "+top.x+" "+top.y);
  //rect((width/2)-(base.x/2),(height/2)-(base.y/2),base.x,base.y);
  device.display();
}