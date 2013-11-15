public class SimpleButton extends UIElement {
  protected boolean on;
  protected boolean enabled;
  protected boolean hover = false;

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
  
  public void mouseReleased() {
    if (enabled) {
       // Activate button callback
      activateActionCallback();
    }
  }

  public boolean isInside ( float mx, float my ) {
    hover = Interactive.insideRect( x, y, elementWidth, elementHeight, mx, my );
    return hover;
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

