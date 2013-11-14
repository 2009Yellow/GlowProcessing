public class ViewManager{
  
  // View member variables
  private View currentView;
  int offset_x;
  int offset_y;
  
  // ========================== Constructor ==========================
  public ViewManager(int off_x, int off_y) {
    offset_x = off_x;
    offset_y = off_y;
    // Create default view
    initDefaultView();
  }
  
  public ViewManager(int off_x, int off_y, View view) {
    offset_x = off_x;
    offset_y = off_y;
    currentView = view;
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
  
  public void destroyCurrentView() {
    currentView.destroy();
  }
  
  public void setView(View newView) {
    // Destroy the old view
    currentView.destroy();
    // Set the new view
    currentView = newView;
  }
  
}
