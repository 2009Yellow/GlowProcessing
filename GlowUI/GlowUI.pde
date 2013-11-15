import de.bezier.guido.Interactive;

ViewManager viewManager;
GlowViews glowViews;

void setup () {
  size(1000, 800);

  // Make the manager
  Interactive.make( this );
  
  // Create ViewManage and views
  glowViews = new GlowViews();
  viewManager = new ViewManager(0,0, this);
  viewManager.setView(glowViews.GlowHome());
}

void draw () {
  //background( 0 );
  // Draw the views
  viewManager.draw();
}


