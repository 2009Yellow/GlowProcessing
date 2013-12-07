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
    //noStroke();
    rect(x, y, elementWidth, elementHeight);
    fill(textColor);
    textSize(messageSize);
    //println(getView().getFont());
    textFont(getView().getFont());
    //text(message, x + messageBorder, y + messageBorder, elementWidth - messageBorder, elementHeight - messageBorder);
    text(message, x + elementWidth/2, y + elementHeight/2);
    
    popStyle();
  }
}


public class GlowBlueTextButton extends SimpleButton {
  // TextButton members
  protected color backgroundColor = color(153,204,205);
  protected color backgroundPushColor = color(76, 102, 102);
  protected color bottomBarColor = color(51, 152, 155);
  protected color bottomBarPushColor = color(25, 76, 77);
  protected color textColor = color(255,255,255);
  protected String message;
  protected int messageSize;
  
  public GlowBlueTextButton( int xx, int yy, int w, int h, int ts,  String s) {
    super(  xx,  yy,  w,  h );
    message = s;
    messageSize = ts;
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
    noStroke();
    // Fill in button background
    if (on) {
      fill(backgroundPushColor);
    } else {
      fill(backgroundColor);
    }
    rect(x, y, elementWidth, elementHeight);
    // Fill in the botom bar
    if (hover) {
      if (on) {
        fill(bottomBarPushColor);
      } else {
        fill(bottomBarColor);
      }
      rect(x, y + elementHeight - 6, elementWidth, 6);
    }
    // Draw button text
    fill(textColor);
    textFont(getView().getFont());
    textSize(messageSize);
    text(message, x + elementWidth/2, y + elementHeight/2 - 6);
    popStyle();
  }
}
