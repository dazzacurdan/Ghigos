class Point
{
  Point(int x,int y)
  {
    this.x = x;
    this.y = y;
  }
  public int x,y;
}
class PyramidFace
{
  PyramidFace(Point a,Point b,Point c,Point d )
  {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }
  void display()
  {
    color(255,0,0);
    line(a.x,a.y,b.x,b.y);
    line(b.x,b.y,c.x,c.y);
    line(c.x,c.y,d.x,d.y);
    line(d.x,d.y,a.x,a.y);
    
  }
  private Point a, b, c, d;
}
class PyramidalPattern extends DeviceFeatures
{
  PyramidalPattern(int w,int h, int rW, int rH)
  {
    super(w,h,rW,rH);
    areas = new PyramidFace[4];
    areas[0] = new PyramidFace(  new Point(center.x-quadShift,center.y-quadShift),
                                 new Point(center.x-pyramidBase,center.y-pyramidShift),
                                 new Point(center.x+pyramidBase,center.y-pyramidShift),
                                 new Point(center.x+quadShift,center.y-quadShift));
    
    areas[1] = new PyramidFace(new Point(center.x+quadShift,center.y-quadShift),
                               new Point(center.x+pyramidShift,center.y-pyramidBase),
                               new Point(center.x+pyramidShift,center.y+pyramidBase),
                               new Point(center.x+quadShift,center.y+quadShift));
    
    areas[2] = new PyramidFace(  new Point(center.x-quadShift,center.y+quadShift),
                                 new Point(center.x-pyramidBase,center.y+pyramidShift),
                                 new Point(center.x+pyramidBase,center.y+pyramidShift),
                                 new Point(center.x+quadShift,center.y+quadShift));
    
    areas[3] = new PyramidFace(new Point(center.x-quadShift,center.y-quadShift),
                               new Point(center.x-pyramidShift,center.y-pyramidBase),
                               new Point(center.x-pyramidShift,center.y+pyramidBase),
                               new Point(center.x-quadShift,center.y+quadShift));
    println("DONE");
  }
  void display()
  {
    for(int i=0;i<4;++i)
      areas[i].display();
  }
  void display(PImage bitmap,boolean enablePattern)
  {
    //if(enablePattern)
      
    //show texture
  }
  private PyramidFace[] areas;
}