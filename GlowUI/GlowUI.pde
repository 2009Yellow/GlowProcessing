import de.bezier.guido.Interactive;

ViewManager viewManager;
GlowViews glowViews;

void setup () {
  size(800, 800);

  // Make the manager
  Interactive.make( this );
  
  // Create ViewManage and views
  glowViews = new GlowViews(this);
  //viewManager = new ViewManager(0,0, this,  glowViews.HelloView());
  //viewManager = new ViewManager(0,0, this);
  viewManager = newViewManager(this);
}

void draw () {
  //background( 0 );
  // Draw the views
  viewManager.draw();
}


