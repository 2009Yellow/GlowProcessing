public class SimpleButton extends UIElement {
  protected boolean on;
  protected boolean enabled;

  public SimpleButton ( int xx, int yy, int w, int h ) {
    super(xx, yy, w, h);
    enabled = true;
    //println("New button with width " + elementWidth + " and height " + elementHeight);
  }

  // called by manager
  public void mousePressed () {
    if (enabled) {
      on = !on;
    }
  }
  
  public boolean isInside ( float mx, float my ) {
    return  Interactive.insideRect( x, y, elementWidth, elementHeight, mx, my );
  }
  
  // called by manager
  public void draw () {
    if ( on ) fill( 200 );
    else fill( 100 );
    rect(x, y, elementWidth, elementHeight);

  }
  
  public boolean getState() {
    return on;
  }
}

