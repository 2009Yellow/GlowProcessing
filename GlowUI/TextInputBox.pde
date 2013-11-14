public class TextInputBox extends UIElement implements  KeyEventListener {
  // TextButton members
  protected color backgroundColor;
  protected color textColor;
  protected String typing, saved;
  protected int messageSize;
  protected int messageBorder;
  
  public TextInputBox(int xx, int yy, int w, int h, int ts, String initialTyping) {
    super(  xx,  yy,  w,  h );
    backgroundColor = color(255,255,255);
    textColor = color(0,0,0);
    typing = initialTyping;
    messageSize = ts;
    // Sets the text border to 1 pixel by default
    messageBorder = 1;  
  }
  
  public void mousePressed () {
    println("text input hi");
  }
 
  public void keyEvent(KeyEvent e) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      saved = typing;
      // A String can be cleared by setting it equal to ""
      typing = "";
    }  else if (key == BACKSPACE) {
      if (typing.length() != 0) {
        typing = typing.substring(0, typing.length()-1);
      }
    } else {
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      typing = typing + key;
    }
  }
  
  public void draw() {
    pushStyle();
    textAlign(LEFT, CENTER);
    fill(backgroundColor);
    rect(x, y, elementWidth, elementHeight);
    fill(textColor);
    textSize(messageSize);
    text(typing, x + messageBorder, y + messageBorder, elementWidth - messageBorder, elementHeight - messageBorder);
    popStyle();
  }
  
  
  public String getSavedMessage() {
    return saved;
  }
}
