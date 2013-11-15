public class ViewManager{
  
  // View member variables
  private View currentView;
  private int offset_x;
  private int offset_y;
  private PApplet papplet;
  
  // ========================== Constructor ==========================
  
 public ViewManager(PApplet p) {
    offset_x = 0;
    offset_y = 0;
    papplet = p;
    // Register key events
    papplet.registerMethod("keyEvent", this);
    // Create default view
    initDefaultView();
  }
  public ViewManager(int off_x, int off_y, PApplet p) {
    offset_x = off_x;
    offset_y = off_y;
    papplet = p;
    // Register key events
    papplet.registerMethod("keyEvent", this);
    // Create default view
    initDefaultView();
  }
  
  public ViewManager(int off_x, int off_y, PApplet p,  View view) {
    papplet = p;
    offset_x = off_x;
    offset_y = off_y;
    currentView = view;
    // Register key events
    papplet.registerMethod("keyEvent", this);
  }
  
  
  // ========================== Private Methods ==========================
  private void initDefaultView() {
    currentView = new View(width, height, color(255, 255, 0), null);
    initButtons();
  }
  
  private void initButtons() {
    // create some buttons
    int w = (width-20)/20;
    for ( int ix = 20, k = width-w; ix <= k; ix += 2*w )
    {
      for ( int iy = 20, n = height-w; iy <= n; iy += 2*w )
      {
        currentView.addUIElement(new SimpleButton( ix, iy, w, w ));
      }
    }
  }
  
  // ========================== Public Methods ==========================
  public void draw() {
    if (currentView != null) {
      pushMatrix();
      translate(offset_x, offset_y);
      currentView.draw();
      popMatrix();
    }
  }
  
  public void keyEvent (KeyEvent e ) {
    if(e.getAction() == e.PRESS) {
      currentView.keyEvent(e);
    }
  }
  
  public void destroyCurrentView() {
    currentView.destroy();
  }
  
  public void setView(View newView) {
    // Destroy the old view
    if (currentView != null) {
      currentView.destroy();
    }
    // Set the new view
    if (newView != null) {
      currentView = newView;
      newView.setViewManager(this);
    } else {
      currentView = null;
    }
  }
  
}
