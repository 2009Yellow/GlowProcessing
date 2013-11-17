//import quicktime.app.ui.UIElement;

public class GlowViews
{
  ActionCallback glowHomeCallback;
  ActionCallback selectProfileCallback;
  ActionCallback createProfileCallback;
  ActionCallback sessionsCallback;
  ActionCallback goToSession1;
  ActionCallback learnPosesCallback;
  ActionCallback pose1Callback;
  ActionCallback pose2Callback;
  ActionCallback pose3Callback;
  ActionCallback pose4Callback;
  ActionCallback pose5Callback;
  
  PImage logo;
  public GlowViews()
  {
    this.logo = loadImage("logo.jpg");
    logo.resize(210, 140);
    this.glowHomeCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.GlowHome());
      }
    };

    this.selectProfileCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.SelectProfile());
      }
    };

    this.createProfileCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view when button is pressed
        viewManager.setView(glowViews.CreateProfile());
      }
    };
    this.sessionsCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view GO TO SESSIONS
        viewManager.setView(glowViews.Sessions());
      }
    };

    this.goToSession1 = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view GO TO SESSIONS
        viewManager.setView(glowViews.Session1());
      }
    };

    this.learnPosesCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.learnNewPoses());
      }
    };
    this.pose1Callback = new ActionCallback()
      {
        public void doAction(UIElement e)
        {
          ViewManager viewManager = e.getView().getViewManager();
          GlowViews glowViews = new GlowViews();
          viewManager.setView(glowViews.learnNewPoses());
          workoutManager.newPose(1);
        }
      };
      this.pose3Callback = new ActionCallback()
      {
        public void doAction(UIElement e)
        {
          ViewManager viewManager = e.getView().getViewManager();
          GlowViews glowViews = new GlowViews();
          viewManager.setView(glowViews.learnNewPoses());
          workoutManager.newPose(3);
        }
      };
      this.pose4Callback = new ActionCallback()
      {
        public void doAction(UIElement e)
        {
          ViewManager viewManager = e.getView().getViewManager();
          GlowViews glowViews = new GlowViews();
          viewManager.setView(glowViews.learnNewPoses());
          workoutManager.newPose(4);
        }
      };
      this.pose5Callback = new ActionCallback()
      {
        public void doAction(UIElement e)
        {
          ViewManager viewManager = e.getView().getViewManager();
          GlowViews glowViews = new GlowViews();
          viewManager.setView(glowViews.learnNewPoses());
          workoutManager.newPose(5);
        }
      };
      
  }

  public View HelloView()
  {
    PImage img = loadImage("yellow-background.jpg");
    View view = new View(width, height, color(255, 255, 0), img);
    
    
    // Add buttons to view
    UIElement dogButton = new ImageButton(200, 200, loadImage("dog.jpg"),
        loadImage("cat.jpg"));
    view.addUIElement(dogButton);
    UIElement dogElement = new ImageElement(400, 200, loadImage("dog.jpg"));
    view.addUIElement(dogElement);
    UIElement textButton = new TextButton(100, 200, 100, 100, color(255, 0,
        0), color(255, 255, 255), 32, "Hi");
    view.addUIElement(textButton);
    UIElement textInput = new TextInputBox(300, 200, 300, 80, 32, "Hi");
    view.addUIElement(textInput);
    view.addKeyEventListener((KeyEventListener) textInput);
    UIElement simpleButton = new SimpleButton(400, 400, 40, 40);
    view.addUIElement(simpleButton);

    // Set Button1 callback
    textButton.setActionCallback(this.glowHomeCallback);

    // Return
    return view;
  }

  public View GlowHome()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("GlowHomeView/home_bg.jpg"));
    drawLogo(view);
    
    // Create elements
    UIElement selectProfileButton = new ImageButton(200, 600,
        loadImage("GlowHomeView/select_profile.png"),
        loadImage("GlowHomeView/select_profile_hover.png"));
    view.addUIElement(selectProfileButton);
    UIElement createProfileButton = new ImageButton(600, 600,
        loadImage("GlowHomeView/create_profile.png"),
        loadImage("GlowHomeView/create_profile_hover.png"));
    view.addUIElement(createProfileButton);

    selectProfileButton.setActionCallback(this.selectProfileCallback);
    createProfileButton.setActionCallback(this.createProfileCallback);

    // Review new view
    return view;
  }

  public View CreateProfile()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("GlowHomeView/home_bg.jpg"));

    drawLogo(view);
    makeTitle("Create a Profile", 350, view);
    // name title
    UIElement nameTag = new TextButton(50, 300, 140, 40, color(255, 0, 0, 0), color(255, 255, 255), 24, "Name");
    view.addUIElement(nameTag);
    // name input
    int inputNameWidth = 300;
    UIElement inputName = new TextInputBox((width-inputNameWidth)/2, 300, 300, 40, 32, "");
    view.addUIElement(inputName);
    view.addKeyEventListener((KeyEventListener) inputName);

    // height range title
    UIElement heightRange = new TextButton(50, 400, 220, 40, color(255, 0, 0, 0), color(255, 255, 255), 24, "Height Range");
    view.addUIElement(heightRange);
    // height range checkboxes
    int checkboxEdge = 20;
    int ckbFontSize = 22;
    String ckbFontType = "papyrus.vlw";
    UIElement checkbox1 = new CheckBox( 350, 400, checkboxEdge, checkboxEdge, "5'0 - 5'4");
    view.addUIElement(checkbox1);
    UIElement checkbox2 = new CheckBox( 350, 450, checkboxEdge, checkboxEdge, "5'4 - 5'8");
    view.addUIElement(checkbox2);
    UIElement checkbox3 = new CheckBox( 350, 500, checkboxEdge, checkboxEdge, "5'8 - 6'0");
    view.addUIElement(checkbox3);
    UIElement checkbox4 = new CheckBox( 350, 550, checkboxEdge, checkboxEdge, "6'0 - 6'4");
    view.addUIElement(checkbox4);
    
    
    // submit button
    PImage submit = loadImage("GlowCreateProfileView/submit.png");
    submit.resize(100, 50);
    int offSet = 20;
    UIElement buttonSubmit = new ImageButton(width - submit.width - offSet, height - submit.height - offSet, submit, submit);
    view.addUIElement(buttonSubmit);

    buttonSubmit.setActionCallback(this.selectProfileCallback);

    drawBackButton(view);

    // Review new view
    return view;
  }

  public View SelectProfile()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("GlowHomeView/home_bg.jpg"));

    drawLogo(view);
    makeTitle("Select a Profile", 350, view);

    int tmpWidth = 220;
    int tmpHeight = 40;
    UIElement userNameButton = new TextButton((width-tmpWidth)/2, (height-tmpHeight)/2, tmpWidth, tmpHeight, color(255, 0, 0, 0), color(255, 255, 255), 24, "User Name");
    view.addUIElement(userNameButton);

    userNameButton.setActionCallback(this.sessionsCallback);

    drawBackButton(view);

    // Review new view
    return view;
  }

  public View Sessions()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("GlowHomeView/home_bg.jpg"));

    drawLogo(view);
    makeTitle("SESSIONS", 200, view);
    
    int tmpWidth = 300;
    UIElement selectSubTitle = new TextButton((width-tmpWidth)/2, 300, tmpWidth, 40, color(255, 0, 0, 0), color(255, 255, 255), 24, "Select a Session");
    view.addUIElement(selectSubTitle);

    // Session 1
    // Session 1 BUTTON
    UIElement ses1Button = new TextButton(50, 300, 150, 40, color(255, 0, 0, 0), color(255, 255, 255), 24, "Session 1");
    view.addUIElement(ses1Button);
    UIElement ses2Button = new TextButton(50, 350, 150, 40, color(255, 0, 0, 0), color(137, 132, 255), 24, "Session 2");
    view.addUIElement(ses2Button);
    UIElement ses3Button = new TextButton(50, 400, 150, 40, color(255, 0, 0, 0), color(137, 132, 255), 24, "Session 3");
    view.addUIElement(ses3Button);
    
    ses1Button.setActionCallback(this.goToSession1);

    // Pose pics
    int x = 300;
    int y = 180;
    UIElement pose01 = new ImageElement(x, 400, loadImage("GlowSessions/pose1.png"));
    view.addUIElement(pose01);
    UIElement pose02 = new ImageElement(x + y, 400, loadImage("GlowSessions/pose2.png"));
    view.addUIElement(pose02);
    UIElement pose03 = new ImageElement(x + 2 * y, 400, loadImage("GlowSessions/pose3.png"));
    view.addUIElement(pose03);
    UIElement pose04 = new ImageElement(x, 600, loadImage("GlowSessions/pose4.png"));
    view.addUIElement(pose04);
    UIElement pose05 = new ImageElement(x + y, 600, loadImage("GlowSessions/pose5.png"));
    view.addUIElement(pose05);
    UIElement pose06 = new ImageElement(x + 2 * y, 600, loadImage("GlowSessions/pose6.png"));
    view.addUIElement(pose06);
    // Review new view

    drawBackButton(view);
    return view;
  }

  public View Session1()
  {
    View view = new View(width, height, color(128, 128, 128), loadImage("GlowHomeView/home_bg.jpg"));
    drawLogo(view);
    makeTitle("SESSION 1", 200, view);

    UIElement learnPosesButton = new TextButton(150, 400, 200, 200, color(255, 0, 0, 0), color(255, 255, 255), 32, "Learn new Poses");
    view.addUIElement(learnPosesButton);

    // Set Button1 callback
    learnPosesButton.setActionCallback(this.learnPosesCallback);

    UIElement doFullSession = new TextButton(650, 400, 200, 200, color(137,
        132, 132), color(255, 255, 255), 32, "Do a full Session");
    view.addUIElement(doFullSession);
    drawBackButton(view);

    return view;
  }

  public View learnNewPoses()
  {
    View view = new View(width, height, color(128, 128, 128),
        loadImage("GlowHomeView/home_bg.jpg"));
    drawLogo(view);

    makeTitle("Session 1, learn", 400, view);

    int x = 200;
    int tmpWidth = 200;
    UIElement posesTitle = new TextInputBox(20, x, tmpWidth, 40, 32,
        "The Poses");
    view.addUIElement(posesTitle);

    
      // drawPoseButton('Pose ' + 1, 20, x+1*50, 250, 40, view);
      UIElement pose01Button = new TextButton(20, x + 1 * 50, tmpWidth,
          40, color(255, 0, 0), color(255, 255, 255), 32, "Pose " + 1);
      view.addUIElement(pose01Button);
      pose01Button.setActionCallback(this.pose1Callback);
      
      // drawPoseButton('Pose ' + 2, 20, x+1*50, 250, 40, view);
      UIElement pose02Button = new TextButton(20, x + 2 * 50, tmpWidth,
          40, color(255, 0, 0), color(255, 255, 255), 32, "Pose " + 2);
      view.addUIElement(pose02Button);
      pose02Button.setActionCallback(this.pose2Callback);
      
      // drawPoseButton('Pose ' + 2, 20, x+1*50, 250, 40, view);
      UIElement pose03Button = new TextButton(20, x + 3 * 50, tmpWidth,
          40, color(255, 0, 0), color(255, 255, 255), 32, "Pose " + 3);
      view.addUIElement(pose03Button);
      pose03Button.setActionCallback(this.pose3Callback);
      
      // drawPoseButton('Pose ' + 2, 20, x+1*50, 250, 40, view);
      UIElement pose04Button = new TextButton(20, x + 4 * 50, tmpWidth,
          40, color(255, 0, 0), color(255, 255, 255), 32, "Pose " + 4);
      view.addUIElement(pose04Button);
      pose04Button.setActionCallback(this.pose4Callback);
      
      // drawPoseButton('Pose ' + 2, 20, x+1*50, 250, 40, view);
      UIElement pose02Button = new TextButton(20, x + 5 * 50, tmpWidth,
          40, color(255, 0, 0), color(255, 255, 255), 32, "Pose " + 5);
      view.addUIElement(pose05Button);
      pose01Button.setActionCallback(this.pose5Callback);
      

    drawBackButton(view);

    return view;
  }


  // Private Functions
  private void drawBackButton(View view)
  {
    PImage back = loadImage("GlowCreateProfileView/back.png");
    back.resize(50, 50);
    UIElement buttonBack = new ImageButton(20, height - 70, back, back);
    view.addUIElement(buttonBack);

    // Create and set Select Profile Callback
    ActionCallback backCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.GlowHome());
      }
    };
    buttonBack.setActionCallback(backCallback);
  }

  private void drawLogo(View view){
    // page logo
    UIElement logo = new ImageElement(20, 20, this.logo);
    view.addUIElement(logo);
  }
  
  private void makeTitle(String title, int titleWidth, View view){
    UIElement titleText = new TextButton((width-titleWidth)/2, 200, titleWidth, 40,color(255, 0, 0, 0),color(255, 255, 0), 32,
        title);
    view.addUIElement(titleText);
  }
  
  
  public View GlowHomeTest() {
    // Create view
    View view =  new View(width, height,color(255,255,0)); 
    // Create Views
    UIElement textButton1 = new TextButton(100, 100, 100, 80, color(0, 100, 255), color(200, 200, 200), 32, "Pose 1");
    view.addUIElement(textButton1);
    UIElement textButton2 = new TextButton(100, 200, 100, 80, color(0, 100, 255), color(128, 128, 128), 32, "Pose 2");
    view.addUIElement(textButton2);
    
    VideoElement videoElement = new VideoElement(200, 200, 400, 400, GlobalPApplet.papplet, "totoro.mov");
    // Set the globalv video element so that other buttons can control the video
    GlobalPApplet.videoElement = videoElement;
    videoElement.play();
    videoElement.setTime(80.0);
    view.addUIElement(videoElement);
    
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
    
    // Create Button1 callback
    ActionCallback videoCallback = new ActionCallback() {
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
    videoElement.setActionCallback(videoCallback);
    
    // Review new view
    return view;
  }
}
