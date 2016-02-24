class DeviceFeatures
{
  public DeviceFeatures(int w,int h, int rW, int rH )
  {
    this.w = w;
    this.h = h;
    this.rW = rW;
    this.rH = rH;
    center =new Point(rW/2,rH/2);
    quadShift = metric2Pixel(new Point(10,10)).x/2;
    pyramidBase = metric2Pixel(new Point(60,60)).x/2;
    pyramidShift = metric2Pixel(new Point(35,35)).x+quadShift;
    
  }
  Point getCenter()
  {
    return center;
  }
  Point pixel2Metric( Point pxPoint )
  {
    return new Point( pxPoint.x*w/rW,
                      pxPoint.y*h/rH);
  }
  Point metric2Pixel(Point metricPoint)
  {
    return new Point( metricPoint.x*rW/w,
                      metricPoint.y*rH/h);
  }
  public int w,h,rW,rH,quadShift,pyramidShift,pyramidBase,pyramidHeight;//mm
  protected Point center;
}