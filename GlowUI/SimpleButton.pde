public class SimpleButton {
  float x, y, width, height;
  boolean on;

  SimpleButton ( float xx, float yy, float w, float h ) {
    x = xx; 
    y = yy; 
    width = w; 
    height = h;

    Interactive.add( this ); // register it with the manager
  }

  // called by manager

  void mousePressed () {
    on = !on;
  }

  void draw () {
    if ( on ) fill( 200 );
    else fill( 100 );

    rect(x, y, width, height);
  }
}

