import de.bezier.guido.Interactive;

ViewManager viewManager;
GlowViews glowViews;
ProfileManager profileManager;
WorkoutManager workoutManager;

void setup () {
  size(1100, 800);

  // Make the manager
  Interactive.make( this );
  
  // Set the global papplet
  GlobalPApplet.papplet = this;
  
  // Create and set the profile manager
  profileManager = new ProfileManager();
  GlobalPApplet.profileManager = profileManager;
  
  Profile p = profileManager.createNewProfile();
  p.profileName = "Jane";
  profileManager.setCurrentProfileWeight(200.5);
  profileManager.saveProfiles();
  println(profileManager.listProfiles());
  
  // Make the workout manager
  workoutManager = new WorkoutManager(this);
  
  // Create ViewManage and views
  glowViews = new GlowViews();
  viewManager = new ViewManager(0,0, this);
  //viewManager.setView(glowViews.GlowHome());
  //viewManager.setView(glowViews.GlowHomeTest());
  viewManager.setView(glowViews.learnNewPoses());
}

void draw () {
  //background( 0 );
  // Draw the views
  viewManager.draw();
  workoutManager.draw();
}

// This class is a hack to allow PApplet and certain variables to be accessed
// anywhere in the program without restrictoin.
// This is bad programing practice, please don't replicate this...
public static class GlobalPApplet {
  public static PApplet papplet;
  public static ProfileManager profileManager; 
  public static VideoElement videoElement;
  public static WorkoutManager workoutManager;
}


