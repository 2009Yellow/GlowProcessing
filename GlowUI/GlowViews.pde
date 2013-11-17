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
  public GlowViews()
  {
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
        0), color(0, 0, 0), 32, "Hi");
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
        loadImage("background/home_bg.jpg"));
    
    // Create elements
    UIElement selectProfileButton = new ImageButton(200, 470,
        loadImage("buttons/select_profile.png"),
        loadImage("buttons/select_profile_hover.png"));
    view.addUIElement(selectProfileButton);
    UIElement createProfileButton = new ImageButton(600, 470,
        loadImage("buttons/create_profile.png"),
        loadImage("buttons/create_profile_hover.png"));
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
        loadImage("background/create_profile_bg.jpg"));

    // name title
    UIElement nameTag = new TextButton(320, 290, 150, 40, color(255, 0, 0, 0), color(0, 0, 0), 24, "USERNAME:");
    view.addUIElement(nameTag);
    UIElement passTag = new TextButton(318, 350, 150, 40, color(255, 0, 0, 0), color(0, 0, 0), 24, "PASSWORD:");
    view.addUIElement(passTag);
    UIElement weightTag = new TextButton(360, 410, 105, 40, color(255, 0, 0, 0), color(0, 0, 0), 24, "WEIGHT:");
    view.addUIElement(weightTag);
    // name input
    int inputNameWidth = 300;
    UIElement inputName = new TextInputBox(600, 300, 200, 40, 32, "name");
    view.addUIElement(inputName);
    view.addKeyEventListener((KeyEventListener) inputName);

    // height range title
    UIElement heightRange = new TextButton(365, 470, 100, 40, color(255, 0, 0, 0), color(0, 0, 0), 24, "HEIGHT:");
    view.addUIElement(heightRange);
    // height range checkboxes
    int checkboxEdge = 20;
    int ckbFontSize = 22;
    String ckbFontType = "papyrus.vlw";
    UIElement checkbox1 = new CheckBox( 480, 475, checkboxEdge, checkboxEdge, "Below 5'4");
    view.addUIElement(checkbox1);
    UIElement checkbox2 = new CheckBox( 480, 520, checkboxEdge, checkboxEdge, "5'4 - 5'8");
    view.addUIElement(checkbox2);
    UIElement checkbox3 = new CheckBox( 480, 565, checkboxEdge, checkboxEdge, "5'8 - 6'0");
    view.addUIElement(checkbox3);
    UIElement checkbox4 = new CheckBox( 480, 610, checkboxEdge, checkboxEdge, "Above 6'0");
    view.addUIElement(checkbox4);
    
    
    // submit button
    PImage submit = loadImage("buttons/submit.png");
    PImage submitHover = loadImage("buttons/submit_hover.png");

    int offSet = 20;
    UIElement buttonSubmit = new ImageButton(480, height - submit.height - 3 * offSet, submit, submitHover);
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
        loadImage("background/select_profile_bg.jpg"));
    
    PImage user_1 = loadImage("tmp/user_1.png");
    PImage user_1Hover = loadImage("tmp/user_1hover.png");
    PImage user_2 = loadImage("tmp/user_2.png");
    PImage user_3 = loadImage("tmp/user_3.png");
    
    int offSetX = (width-user_1.width)/2;
    int offSetY = 250;
    UIElement userName1Button = new ImageButton(offSetX, offSetY + user_1.height + 20, user_1, user_1Hover);
    view.addUIElement(userName1Button);

    UIElement userName2Button = new ImageButton(offSetX, offSetY + 2 *(user_1.height + 20), user_2, user_2);
    view.addUIElement(userName2Button);
    UIElement userName3Button = new ImageButton(offSetX, offSetY + 3 * (user_1.height + 20), user_3, user_3);
    view.addUIElement(userName3Button);
    
    userName1Button.setActionCallback(this.sessionsCallback);

    drawBackButton(view);

    // Review new view
    return view;
  }

  public View Sessions()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/select_session_bg.jpg"));

    PImage session_1 = loadImage("tmp/session_1.png");
    PImage session_1Hover = loadImage("tmp/session_1hover.png");
    PImage session_2 = loadImage("tmp/session_2.png");
    PImage session_3 = loadImage("tmp/session_3.png");

    int offSetX = 170;
    int offSetY = 250;
    UIElement ses1Button = new ImageButton(offSetX, offSetY + session_1.height + 20, session_1, session_1Hover);
    view.addUIElement(ses1Button);

    UIElement ses2Button = new ImageButton(offSetX, offSetY + 2 *(session_1.height + 20), session_2, session_2);
    view.addUIElement(ses2Button);
    UIElement ses3Button = new ImageButton(offSetX, offSetY + 3 * (session_1.height + 20), session_3, session_3);
    view.addUIElement(ses3Button);
    
    ses1Button.setActionCallback(this.goToSession1);

    drawBackButton(view);
    return view;
  }

  public View Session1()
  {
    View view = new View(width, height, color(128, 128, 128), loadImage("background/bg.jpg"));
    makeTitle("SESSION 1", 200, view);

    UIElement learnPosesButton = new TextButton(150, 400, 200, 200, color(255, 0, 0, 0), color(0, 0, 0), 32, "Learn new Poses");
    view.addUIElement(learnPosesButton);

    // Set Button1 callback
    learnPosesButton.setActionCallback(this.learnPosesCallback);

    UIElement doFullSession = new TextButton(650, 400, 200, 200, color(137,
        132, 132), color(0, 0, 0), 32, "Do a full Session");
    view.addUIElement(doFullSession);
    drawBackButton(view);

    return view;
  }

  public View learnNewPoses()
  {
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/bg.jpg"));

    makeTitle("Session 1, learn", 400, view);

    int x = 200;
    int tmpWidth = 200;
    UIElement posesTitle = new TextInputBox(20, x, tmpWidth, 40, 32,
        "The Poses");
    view.addUIElement(posesTitle);

    for (int i = 1; i < 7; i++)
    {
      // drawPoseButton('Pose ' + i, 20, x+i*50, 250, 40, view);
      UIElement pose01Button = new TextButton(20, x + i * 50, tmpWidth,
          40, color(255, 0, 0), color(0, 0, 0), 32, "Pose " + i);
      view.addUIElement(pose01Button);
      pose01Button.setActionCallback(this.pose1Callback);
    }

    drawBackButton(view);

    return view;
  }


  // Private Functions
  private void drawBackButton(View view)
  {
    PImage back = loadImage("buttons/back.png");
    PImage backHover = loadImage("buttons/back_hover.png");
    backHover.resize(50, 50);
    back.resize(50, 50);
    UIElement buttonBack = new ImageButton(20, height - 90, back, backHover);
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

