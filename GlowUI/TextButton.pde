public class TextButton extends SimpleButton {
  // TextButton members
  protected color backgroundColor;
  protected color textColor;
  protected String message;
  protected int messageSize;
  protected int messageBorder;
  
  public TextButton( int xx, int yy, int w, int h, color bc, color tc, int ts, String s) {
    super(  xx,  yy,  w,  h );
    backgroundColor = bc;
    textColor = tc;
    message = s;
    messageSize = ts;
    // Sets the text border to 0 by default
    messageBorder = 0;  
  }
  
  public TextButton( int xx, int yy, int w, int h, color bc, color tc, int ts, int tb,  String s) {
    super(  xx,  yy,  w,  h );
    backgroundColor = bc;
    textColor = tc;
    message = s;
    messageSize = ts;
    messageBorder = tb;
  }
  
  public void setText(String s) {
    message = s;
  }
  
  // called by manager
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
    textAlign(CENTER, CENTER);
    if (on) {
      fill(128);
    } else {
      fill(backgroundColor);
    }
    rect(x, y, elementWidth, elementHeight);
    fill(textColor);
    textSize(messageSize);
    text(message, x + messageBorder, y + messageBorder, elementWidth - messageBorder, elementHeight - messageBorder);
    
    popStyle();
  }
}
