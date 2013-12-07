public class ImageButton extends SimpleButton {
  protected PImage img;
  protected PImage hoverImg;
  
  public ImageButton( int xx, int yy, int w, int h, PImage i) {
    super(  xx,  yy,  w,  h );
    img = i;
  }
  
  public ImageButton( int xx, int yy, PImage i) {
    super(  xx,  yy, i.width, i.height);
    img = i;
  }
  
  public ImageButton( int xx, int yy, int w, int h, PImage i, PImage hi) {
    super(  xx,  yy,  w,  h );
    img = i;
    hoverImg = hi;
  }
  
  public ImageButton( int xx, int yy, PImage i, PImage hi) {
    super(  xx,  yy, i.width, i.height);
    img = i;
    hoverImg = hi;
  }
  
  public void mousePressed () {
    super.mousePressed();
  }
  
  public void mouseReleased() {
    super.mouseReleased();
  }
  
  public boolean isInside ( float mx, float my ) {
    return super.isInside (  mx,  my );
  }
  
  public void draw() {
    pushStyle();
    if (on) { 
      tint(128);
    }
    if (hover && hoverImg != null ) {
      image(hoverImg, x, y, elementWidth, elementHeight);
    } else { 
      image(img, x, y, elementWidth, elementHeight);
    }
    popStyle();
  }
}
