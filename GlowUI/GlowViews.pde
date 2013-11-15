public class GlowViews {
  
  public GlowViews() {
  }
  
  public View HelloView() {
    PImage img = loadImage("yellow-background.jpg");
    View view =  new View(width, height,color(255,255,0), img); 
    // Add buttons to view
    UIElement dogButton = new ImageButton(200, 200, loadImage("dog.jpg"), loadImage("cat.jpg"));
    view.addUIElement(dogButton);
    UIElement dogElement = new ImageElement(400, 200, loadImage("dog.jpg"));
    view.addUIElement(dogElement);
    UIElement textButton = new TextButton(100, 200, 100, 100, color(255, 0, 0), color(255, 255, 255), 32, "Hi");
    view.addUIElement(textButton);
    UIElement textInput = new TextInputBox(300, 200, 300, 80, 32, "Hi");
    view.addUIElement(textInput);
    view.addKeyEventListener((KeyEventListener)textInput);
    UIElement simpleButton = new SimpleButton(400, 400, 40, 40);
    view.addUIElement(simpleButton);
    
    // Create Button1 callback
    ActionCallback b1Callback = new ActionCallback() {
      public void doAction(UIElement e) {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.GlowHome());
      }
    };
    // Set Button1 callback
    textButton.setActionCallback(b1Callback);
    
    // Return
    return view;
  }
  
  public View GlowHomeTest() {
    // Create view
    View view =  new View(width, height,color(255,255,0)); 
    // Create Views
    UIElement textButton1 = new TextButton(100, 100, 100, 80, color(0, 100, 255), color(200, 200, 200), 32, "Pose 1");
    view.addUIElement(textButton1);
    UIElement textButton2 = new TextButton(100, 200, 100, 80, color(0, 100, 255), color(128, 128, 128), 32, "Pose 2");
    view.addUIElement(textButton2);
    
    // Create Button1 callback
    ActionCallback b1Callback = new ActionCallback() {
      public void doAction(UIElement e) {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.HelloView());
      }
    };
    // Set Button1 callback
    textButton1.setActionCallback(b1Callback);
    
    // Review new view
    return view;
  }
  
  public View GlowHome() {
    // Create view
    View view =  new View(width, height,color(128,128,128), loadImage("GlowHomeView/home_bg.jpg")); 
    
    // Create elements
    UIElement selectProfileButton = new ImageButton(200, 600, loadImage("GlowHomeView/select_profile.png"), loadImage("GlowHomeView/select_profile_hover.png"));
    view.addUIElement(selectProfileButton);
    UIElement createProfileButton = new ImageButton(600, 600, loadImage("GlowHomeView/create_profile.png"), loadImage("GlowHomeView/create_profile_hover.png"));
    view.addUIElement(createProfileButton);
    
    // Create and set Select Profile Callback
    ActionCallback selectCallback = new ActionCallback() {
      public void doAction(UIElement e) {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.HelloView());
      }
    };
    selectProfileButton.setActionCallback(selectCallback);

    // Create and set Select Profile Callback
    ActionCallback createCallback = new ActionCallback() {
      public void doAction(UIElement e) {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view when button is pressed
        viewManager.setView(glowViews.HelloView());
      }
    };
    createProfileButton.setActionCallback(createCallback);
    
    
    // Review new view
    return view;
  }
}



    
