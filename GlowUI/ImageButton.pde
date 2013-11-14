public class ImageButton extends SimpleButton {
  Protected PImage img;
  
  public ImageButton( int xx, int yy, int w, int h, PImage i) {
    super(  xx,  yy,  w,  h );
    img = i;
  }
  
  public ImageButton( int xx, int yy, int w, int h, PImage i) {
    super(  xx,  yy, i.width, i.height);
    img = i;
  }
  
  public draw() {
    pushStyle();
    if (on) { 
      tint(0, 153, 204);
    }
    popStyle();
  }
}
