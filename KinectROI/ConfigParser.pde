class ConfigParser
{
  ConfigParser(){}
  boolean loadROI(String fileName,Vector<ROI> ROIContainer)
  {
    XML xml;
    try
    {
      xml = loadXML(fileName);
    }catch(NullPointerException e)
    {
      return false;
    }
    
    XML[] children = xml.getChildren("roi");

    for (int i = 0; i < children.length; ++i)
    {
      int id = children[i].getInt("id");
      ROIContainer.addElement(new ROI(children[i].getInt("x"),
                                      children[i].getInt("y"),
                                      children[i].getInt("w"),
                                      children[i].getInt("h")
                                      ));
    }
    return true;
  }
}