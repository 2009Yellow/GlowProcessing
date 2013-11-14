public class SimpleButton extends UIElement {
  protected int x, y, elementWidth, elementHeight;
  protected boolean on;

  public SimpleButton ( int xx, int yy, int w, int h ) {
    super();
    x = xx; 
    y = yy; 
    elementWidth = w; 
    elementHeight = h;
    println("New button with width " + elementWidth + " and height " + elementHeight);
  }

  // called by manager
  public void mousePressed () {
    //println("pressed");
    on = !on;
  }
  
  public boolean isInside ( float mx, float my ) {
    boolean r =  Interactive.insideRect( x, y, elementWidth, elementHeight, mx, my );
    //println("called " + r);
    return r;
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

