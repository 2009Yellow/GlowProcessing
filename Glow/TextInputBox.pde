public class TextInputBox extends UIElement implements  KeyEventListener {
  // TextButton members
  protected color backgroundColor;
  protected color textColor;
  public String typing, saved;
  protected int messageSize;
  protected int messageBorder;
  public String tmp = "";
  public ProfManager profileManager;
  
  public TextInputBox(int xx, int yy, int w, int h, int ts, String initialTyping) {
    super(  xx,  yy,  w,  h );
    backgroundColor = color(255,255,255);
    textColor = color(0,0,0);
    typing = initialTyping;
    saved = typing;
    messageSize = ts;
    // Sets the text border to 1 pixel by default
    messageBorder = 1;  
  }

  public TextInputBox(int xx, int yy, int w, int h, int ts, String initialTyping, ProfManager p) {
    super(  xx,  yy,  w,  h );
    backgroundColor = color(255,255,255);
    textColor = color(0,0,0);
    typing = initialTyping;
    profileManager = p; 
    saved = typing;
    messageSize = ts;
    // Sets the text border to 1 pixel by default
    messageBorder = 1;  
  }
  
  public void mousePressed () {
    println("text input hi");
  }
  
  public boolean isInside ( float mx, float my ) {
    return  Interactive.insideRect( x, y, elementWidth, elementHeight, mx, my );
  }
  
  public void keyEvent(KeyEvent e) {
    // If the return key is pressed, save the String and clear it
    if (key == '\n' ) {
      saved = typing;      
      if (profileManager != null){
        profileManager.json.setString("name", saved);
        saveJSONObject(profileManager.json, "profiles.json");
      }
      // A String can be cleared by setting it equal to ""
      typing = "";
      tmp = "";
    }  else if (key == BACKSPACE) {
      if (typing.length() != 0) {
        typing = typing.substring(0, typing.length()-1);
        tmp = tmp.substring(0, tmp.length()-1);
      }
    } else {
      String s = "" + key;
      if (!s.matches("[a-zA-Z0-9]")) {
        return;
      }
      // Otherwise, concatenate the String
      // Each character typed by the user is added to the end of the String variable.
      tmp += "" + key;
      typing = tmp;
      if (profileManager != null){
        profileManager.json.setString("name", typing);
        saveJSONObject(profileManager.json, "profiles.json");
      }
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
  
  public String getTypingMessage() {
    return typing;
  }
  
  
  public String getSavedMessage() {
    return saved;
  }
}
