import de.bezier.guido.Interactive;

ViewManager viewManager;
GlowViews glowViews;

void setup () {
  size(1000, 800);

  // Make the manager
  Interactive.make( this );
  
  // Set the global papplet
  GlobalPApplet.p = this;
  
  // Create ViewManage and views
  glowViews = new GlowViews();
  viewManager = new ViewManager(0,0, this);
  viewManager.setView(glowViews.GlowHome());
  //viewManager.setView(glowViews.GlowHomeTest());
}

void draw () {
  //background( 0 );
  // Draw the views
  viewManager.draw();
}

// This class is a hack to allow PApplet to be accessed
// Anywhere in the program without restrictoin.
// This is bad programing practice...
public static class GlobalPApplet {
  public static PApplet p;
  public static VideoElement v;
}


