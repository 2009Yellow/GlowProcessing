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
  ActionCallback measureYourWeightCallback;
  ActionCallback mountainPoseCallback;
  ActionCallback mountainPoseCallbackALL;
  ActionCallback halfMoonPoseCallback;
  ActionCallback warrior2PoseCallback;
  ActionCallback warrior1PoseCallback;
  ActionCallback trianglePoseCallback;
  ActionCallback standingYogaMudraCallback;
  ActionCallback dogPoseCallback;
  ActionCallback summaryCallback;
  ActionCallback sessionsdoCallback;
  ActionCallback fullSession1Callback;
  Boolean inAllPosesView;
  ProfManager manager;
  final ProfManager p = new ProfManager();
  final String[] videos = {
    "posvid/Mountain.mov",

    "posvid/HalfMoon.mov",

    "posvid/Warrior2Right.mov",

    "posvid/Warrior1Right.mov",

    "posvid/TrianglePoseRight.mov",

    "posvid/StandingBend.mov",
  
    "posvid/DownwardDog.mov",

    "posvid/FullSession.mov"
  };
  public GlowViews()
  {
    this.inAllPosesView = false;
    this.manager = new ProfManager();
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
        //glowViews.inAllPosesMenu = false;
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
      
     this.measureYourWeightCallback = new ActionCallback()
      {
        public void doAction(UIElement e)
        {
          ViewManager viewManager = e.getView().getViewManager();
          GlowViews glowViews = new GlowViews();
          viewManager.setView(glowViews.MeasureYourWeight());
        }
      };
      
    this.mountainPoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.mountainPoseView());
      }
    };
    this.mountainPoseCallbackALL = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.mountainPoseView());
      }
    };
    
    
    this.halfMoonPoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.halfmoonPoseView());
      }
    };
    this.warrior2PoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.warrior2PoseView());
      }
    };
    this.warrior1PoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.warrior1PoseView());
      }
    };
    this.trianglePoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.trianglePoseView());
      }
    };
    this.standingYogaMudraCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.standingYogaPoseView());
      }
    };
    this.dogPoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.dogPoseView());
      }
    };    
    
    this.summaryCallback = new ActionCallback()
    {
     public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.summaryView());
      }
    };
     this.sessionsdoCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.SessionsDo());
      }
    };
     this.fullSession1Callback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view GO TO SESSIONS
        viewManager.setView(glowViews.fullSession1());
      }
    };
  }
  
  

//  public View HelloView()
//  {
//    PImage img = loadImage("yellow-background.jpg");
//    View view = new View(width, height, color(255, 255, 0), img);
//    
//    
//    // Add buttons to view
//    UIElement dogButton = new ImageButton(200, 200, loadImage("dog.jpg"),
//        loadImage("cat.jpg"));
//    view.addUIElement(dogButton);
//    UIElement dogElement = new ImageElement(400, 200, loadImage("dog.jpg"));
//    view.addUIElement(dogElement);
//    UIElement textButton = new TextButton(100, 200, 100, 100, color(255, 0,
//        0), color(0, 0, 0), 32, "Hi");
//    view.addUIElement(textButton);
//    UIElement textInput = new TextInputBox(300, 200, 300, 80, 32, "Hi");
//    view.addUIElement(textInput);
//    view.addKeyEventListener((KeyEventListener) textInput);
//    UIElement simpleButton = new SimpleButton(400, 400, 40, 40);
//    view.addUIElement(simpleButton);
//
//    // Set Button1 callback
//    textButton.setActionCallback(this.glowHomeCallback);
//
//    // Return
//    return view;
//  }

  public View GlowHome()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/home_bg.jpg"));
    
    PImage learn = loadImage("selections/learn_mode.png");
    PImage learnHover = loadImage("selections/learn_mode_hover.png");
    PImage _do = loadImage("selections/do_mode.png");
    PImage _doHover = loadImage("selections/do_mode_hover.png");
    // name title
    UIElement nameTag = new TextElement((width-200)/2, (height-60)/2, 200, 60, color(255, 0, 0, 0), color(0, 0, 0), 24, this.manager.getUserProfile(0).profileName);
    view.addUIElement(nameTag);
    
    // Create elements
    UIElement learnPosesButton = new ImageButton(200, 470,
        learn,learnHover);
    view.addUIElement(learnPosesButton);
    UIElement doFullSession = new ImageButton(600, 470,_do, _doHover);
    view.addUIElement(doFullSession);

    learnPosesButton.setActionCallback(this.sessionsCallback);
   
    
     PImage logout = loadImage("newbuttons/logout.png");
     PImage logoutHover = loadImage("newbuttons/logout_hover.png");
     UIElement logoutButton = new ImageButton(950, logout.height +130, logout, logoutHover);
     view.addUIElement(logoutButton);
     
     logoutButton.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        p.json.setBoolean("logged_in", false);
        saveJSONObject(p.json, "profiles.json");
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.SelectProfile());
      }
    });
     doFullSession.setActionCallback(this.sessionsdoCallback); 
    
  //add logout button 
    // Review new view
     return view;
  }
  
  public View GlowHomeSplash() {
    PImage logo = loadImage("logo.png");
    ActionCallback nextViewCallback = new ActionCallback() {
      public void doAction(UIElement e) {
        // Create glow views
        glowViews = new GlowViews();
        // Get the ile manager
        ProfManager p = new ProfManager();
        // if there is a profile, loging, else go to create profile screen
        println(p.getUserProfile(0).isLoggedIn);
        if (p.getUserProfile(0).isLoggedIn) {
          viewManager.setView(glowViews.GlowHome());
        } else {
          viewManager.setView(glowViews.SelectProfile());
        }
        // Set new view
      }
    };
    // Create view
    View view = new SplashView(width, height, color(128, 128, 128), loadImage("background/bg_blank.jpg"), logo, nextViewCallback );

    // Review new view
    return view;
  }

  public View CreateProfile()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/create_profile_bg.jpg"));

    // name title
    UIElement nameTag = new TextElement(280, 310, 150, 40, color(255, 0, 0, 0), color(0, 0, 0), 24, "USERNAME:");
    view.addUIElement(nameTag);
    
    
    // name input
    int inputNameWidth = 300;
    UIElement inputName = new TextInputBox(500, 310, 250, 40, 24, "enter user name", p);
    // callback getsave string
    view.addUIElement(inputName);
    //String cas = inputName.getTypingMessage();
    view.addKeyEventListener((KeyEventListener) inputName);
    
    //println(cas);
    // height range title
    UIElement heightRange = new TextElement(345, 390, 100, 40, color(255, 0, 0, 0), color(0, 0, 0), 24, "HEIGHT:");
    view.addUIElement(heightRange);
    // height range checkboxes
    int checkboxEdge = 20;
    int ckbFontSize = 22;
    String ckbFontType = "papyrus.vlw";
    final UIElement checkbox1 = new CheckBox( 480, 405, checkboxEdge, checkboxEdge, "Below 5'4");
    view.addUIElement(checkbox1);
    final UIElement checkbox2 = new CheckBox( 480, 450, checkboxEdge, checkboxEdge, "5'4 - 5'8");
    view.addUIElement(checkbox2);
    final UIElement checkbox3 = new CheckBox( 480, 495, checkboxEdge, checkboxEdge, "5'8 - 6'0");
    view.addUIElement(checkbox3);
    final UIElement checkbox4 = new CheckBox( 480, 540, checkboxEdge, checkboxEdge, "Above 6'0");
    view.addUIElement(checkbox4);
    checkbox1.setActionCallback(new ActionCallback() {
      public void doAction(UIElement e) {
        checkbox2.checked = false;
        checkbox3.checked = false;
        checkbox4.checked = false;
        //profileManager.setCurrentProfileHeight();
        p.json.setString("height", "Below 5'4");
        saveJSONObject(p.json, "profiles.json");
      }
    });
    checkbox2.setActionCallback(new ActionCallback() {
      public void doAction(UIElement e) {
        checkbox1.checked = false;
        checkbox3.checked = false;
        checkbox4.checked = false;
        p.json.setString("height", "5'4 - 5'8");
        saveJSONObject(p.json, "profiles.json");
      }
    });
    checkbox3.setActionCallback(new ActionCallback() {
      public void doAction(UIElement e) {
        checkbox2.checked = false;
        checkbox1.checked = false;
        checkbox4.checked = false;
        p.json.setString("height", "5'8 - 6'0");
        saveJSONObject(p.json, "profiles.json");
      }
    });
    checkbox4.setActionCallback(new ActionCallback() {
      public void doAction(UIElement e) {
        checkbox2.checked = false;
        checkbox3.checked = false;
        checkbox1.checked = false;
        p.json.setString("height", "Above 6'0");
        saveJSONObject(p.json, "profiles.json");
      }
    });
    
    
    // submit button
    PImage submit = loadImage("buttons/continue.png");
    PImage submitHover = loadImage("buttons/continue_hover.png");

    int offSet = 20;
    UIElement buttonSubmit = new ImageButton(480, height - submit.height - 6 * offSet, submit, submitHover);
    view.addUIElement(buttonSubmit);

    buttonSubmit.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        p.json.setBoolean("logged_in", true);
        saveJSONObject(p.json, "profiles.json");
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        // Set new view
        viewManager.setView(glowViews.GlowHome());
      }
    });
    View GlowHome = new View(width, height, color(128, 128, 128),
        loadImage("background/create_profile_bg.jpg"));
    
    drawBackButton(view).setActionCallback(this.selectProfileCallback);
    
    
    drawGlowHomeButton(view);

    // Review new view
    return view;
  }

  public View SelectProfile()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/select_profile_bg.jpg"));
    
    PImage user_1 = loadImage("tmp/user_1.png");
    //PImage user_1Hover = loadImage("tmp/user_1hover.png");
    //PImage user_2 = loadImage("tmp/user_2.png");
    //PImage user_3 = loadImage("tmp/user_3.png");
    //UIElement userName1Button = new ImageButton(offSetX, offSetY + user_1.height + 20, user_1, user_1Hover);
    //view.addUIElement(userName1Button);
    
    int offSetX = (width-user_1.width)/2;
    int offSetY = 200;

    // Get profile manager
    ProfileManager p = GlobalPApplet.profileManager;

    // Load the first 3 profiles available
    String[] profileNames = p.listProfiles();
    //if (profileNames.length >3) {
    //}
    
    for ( int i = 0; i < profileNames.length; ++i) {
      final int ii = i;
      String profileName = profileNames[i];
      // Create the button
      UIElement userNameButton = new GlowBlueTextButton(offSetX, offSetY + (i + 1) * (user_1.height + 20), 461, 65,  48, profileName);
      view.addUIElement(userNameButton);
      userNameButton.setActionCallback( new ActionCallback() {
        public void doAction(UIElement e) {
          GlobalPApplet.profileManager.setCurrentProfile(ii);
          // Get the view manger
          ViewManager viewManager = e.getView().getViewManager();
          // Create glow views object
          GlowViews glowViews = new GlowViews();
          // Set new view GO TO SESSIONS
          viewManager.setView(glowViews.Sessions());
        }
      });
      
      // Don't do more than 3 profiles
      if (i == 2) {
        break;
      }
    }
    
    /*
    UIElement userName1Button = new GlowBlueTextButton(offSetX, offSetY + user_1.height + 20, 461, 65,  48, "Demetra");
    view.addUIElement(userName1Button);

    UIElement userName2Button = new GlowBlueTextButton(offSetX, offSetY + 2 * (user_1.height + 20), 461, 65,  48, "Kojo");
    view.addUIElement(userName2Button);
    */
    UIElement userName3Button = new GlowBlueTextButton(offSetX, offSetY + 4 * (user_1.height + 20), 461, 65,  48, "<New User>");
    view.addUIElement(userName3Button);
    userName3Button.setActionCallback(this.createProfileCallback); 
    
    //userName1Button.setActionCallback(this.sessionsCallback);
    //userName2Button.setActionCallback(this.sessionsCallback);
    //drawBackButton(view).setActionCallback(this.sessionsCallback); 
   // drawGlowHomeButton(view);

    // Review new view
    return view;
  }

  public View Sessions()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/select_session_bg.jpg"));

    PImage session_1 = loadImage("selections/session1.png");
    PImage session_1Hover = loadImage("selections/session1_hover.png");
    PImage session_1HoverPoses = loadImage("buttons/session1_poses.png");
    PImage session_2 = loadImage("selections/session2_inactive.png");
    PImage session_3 = loadImage("selections/session3_inactive.png");
    PImage continueImg = loadImage("buttons/continue.png");
    PImage continueImgHover = loadImage("buttons/continue_hover.png");
    int offSetX = 130;
    int offSetY = 240;
    UIElement ses1Button = new ImageButton(offSetX, offSetY + session_1.height + 20, session_1, session_1Hover);
    view.addUIElement(ses1Button);
    UIElement ses1ButtonPoses = new ImageButton(offSetX + session_1.width, offSetY + session_1.height/2 +20, session_1HoverPoses, session_1HoverPoses);
    view.addUIElement(ses1ButtonPoses);
    UIElement ses2Button = new ImageButton(offSetX, offSetY + 2 *(session_1.height + 20), session_2, session_2);
    view.addUIElement(ses2Button);
    UIElement ses3Button = new ImageButton(offSetX, offSetY + 3 * (session_1.height + 20), session_3, session_3);
    view.addUIElement(ses3Button);
    
    
    
    ses1Button.setActionCallback(this.learnPosesCallback);

//    int offSet = 20;
//    UIElement buttonContinue = new ImageButton((width - continueImg.width)/2 , height - continueImg.height - 3 * offSet, continueImg, continueImgHover);
//    view.addUIElement(buttonContinue);
//    buttonContinue.setActionCallback(this.learnPosesCallback);
    drawBackButton(view).setActionCallback(this.glowHomeCallback); 
    drawGlowHomeButton(view);
    return view;
  }
  
  
  public View SessionsDo()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/select_session_bg.jpg"));

    PImage session_1 = loadImage("selections/session1.png");
    PImage session_1Hover = loadImage("selections/session1_hover.png");
    PImage session_1HoverPoses = loadImage("buttons/session1_poses.png");
    PImage session_2 = loadImage("selections/session2_inactive.png");
    PImage session_3 = loadImage("selections/session3_inactive.png");
    PImage continueImg = loadImage("buttons/continue.png");
    PImage continueImgHover = loadImage("buttons/continue_hover.png");
    int offSetX = 130;
    int offSetY = 240;
    UIElement ses1Button = new ImageButton(offSetX, offSetY + session_1.height + 20, session_1, session_1Hover);
    view.addUIElement(ses1Button);
    UIElement ses1ButtonPoses = new ImageButton(offSetX + session_1.width, offSetY + session_1.height/2 +20, session_1HoverPoses, session_1HoverPoses);
    view.addUIElement(ses1ButtonPoses);
    UIElement ses2Button = new ImageButton(offSetX, offSetY + 2 *(session_1.height + 20), session_2, session_2);
    view.addUIElement(ses2Button);
    UIElement ses3Button = new ImageButton(offSetX, offSetY + 3 * (session_1.height + 20), session_3, session_3);
    view.addUIElement(ses3Button);
    
    ses1Button.setActionCallback(this.fullSession1Callback);

//    int offSet = 20;
//    UIElement buttonContinue = new ImageButton((width - continueImg.width)/2 , height - continueImg.height - 3 * offSet, continueImg, continueImgHover);
//    view.addUIElement(buttonContinue);
//    buttonContinue.setActionCallback(this.learnPosesCallback);
    drawGlowHomeButton(view);
    drawBackButton(view).setActionCallback(this.glowHomeCallback); 
    return view;
  }

  public View Session1()
  {
    View view = new View(width, height, color(128, 128, 128), loadImage("background/select_mode_bg.jpg"));
    PImage learn = loadImage("selections/learn_mode.png");
    PImage learnHover = loadImage("selections/learn_mode_hover.png");
    PImage _do = loadImage("selections/do_mode.png");
    PImage _doHover = loadImage("selections/do_mode_hover.png");
    
    UIElement learnPosesButton = new ImageButton(150, 400, learn, learnHover);
    view.addUIElement(learnPosesButton);

    // Set Button1 callback
    learnPosesButton.setActionCallback(this.measureYourWeightCallback);

    UIElement doFullSession = new ImageButton(620, 400, _do, _doHover); 
    view.addUIElement(doFullSession);
    drawBackButton(view).setActionCallback(this.sessionsCallback); 
    drawGlowHomeButton(view);
    return view;
  }
  
  public View summaryView()
  {
    View view = new View(width, height, color(128, 128, 128),
        loadImage("newbuttons/summary_bg.jpg"));
    drawGlowHomeButton(view);
    for (int i = 0; i < 7; i++)
    {    
      UIElement poseNameTag = new TextElement(450, 280 + i * 60, 100, 40, color(255, 0, 0, 0), color(0, 0, 0), 10, videos[i].substring(7, videos[i].length()-4) + " Percentage:");
      view.addUIElement(poseNameTag);
      UIElement percentage = new TextElement(855, 280 + i * 60, 100, 40, color(255, 0, 0, 0), color(0, 0, 0), 10, p.json.getString(videos[i].substring(7, videos[i].length()-3)+"pose"));
      view.addUIElement(percentage);
    } 
      drawBackButton(view).setActionCallback(this.learnPosesCallback);

    return view; 
  }

  public View learnNewPoses()
  {
    View view = new View(width, height, color(128, 128, 128),
        loadImage("background/select_pose_bg.jpg"));
    
    PImage pose_mountain = loadImage("poses/pose_mountain.png");
    PImage pose_mountainHover = loadImage("poses/pose_mountain_hover.png");

    PImage pose_halfmoon = loadImage("poses/pose_halfmoon.png");
    PImage pose_halfmoonHover = loadImage("poses/pose_halfmoon_hover.png");
    
    PImage pose_warrior2 = loadImage("poses/pose_warrior2.png");
    PImage pose_warrior2Hover = loadImage("poses/pose_warrior2_hover.png");
    
    PImage pose_warrior1 = loadImage("poses/pose_warrior1.png");
    PImage pose_warrior1Hover = loadImage("poses/pose_warrior1_hover.png");

    PImage pose_triangle = loadImage("poses/pose_triangle.png");
    PImage pose_triangleHover = loadImage("poses/pose_triangle_hover.png");
    
    PImage pose_mudra = loadImage("poses/pose_mudra.png");
    PImage pose_mudraHover = loadImage("poses/pose_mudra_hover.png");
    
    PImage pose_dog = loadImage("poses/pose_dog.png");
    PImage pose_dogHover = loadImage("poses/pose_dog_hover.png");
    
    PImage allposes = loadImage("poses/learn_all_poses.png");
    PImage allposes_hover = loadImage("poses/learn_all_poses_hover.png");
    
    int x = 200;
    int offSet = 80;
    int y = 300;

    UIElement pose_mountainButton = new ImageButton(x, y, pose_mountain, pose_mountainHover);
    view.addUIElement(pose_mountainButton);
    pose_mountainButton.setActionCallback(this.mountainPoseCallback);
    
    UIElement pose_halfmoonButton = new ImageButton(x, y + offSet, pose_halfmoon, pose_halfmoonHover);
    view.addUIElement(pose_halfmoonButton);
    pose_halfmoonButton.setActionCallback(this.halfMoonPoseCallback);
    
    UIElement pose_warrior2Button = new ImageButton(x, y + 3 * offSet, pose_warrior2, pose_warrior2Hover);
    view.addUIElement(pose_warrior2Button);
    pose_warrior2Button.setActionCallback(this.warrior2PoseCallback);
    UIElement pose_warrior1Button = new ImageButton(x, y + 2 * offSet, pose_warrior1, pose_warrior1Hover);
    view.addUIElement(pose_warrior1Button);
    pose_warrior1Button.setActionCallback(this.warrior1PoseCallback);
    
    UIElement pose_triangleButton = new ImageButton(x + pose_mountain.width + offSet/2, y, pose_triangle, pose_triangleHover);
    pose_triangleButton.setActionCallback(this.trianglePoseCallback);
    view.addUIElement(pose_triangleButton);
    
    UIElement pose_mudraButton = new ImageButton(x + pose_mountain.width + offSet/2, y + offSet, pose_mudra, pose_mudraHover);
    pose_mudraButton.setActionCallback(this.standingYogaMudraCallback);
    view.addUIElement(pose_mudraButton);
    
    UIElement pose_dogButton = new ImageButton(x + pose_mountain.width + offSet/2, y + 2 * offSet, pose_dog, pose_dogHover);
    pose_dogButton.setActionCallback(this.dogPoseCallback);
    view.addUIElement(pose_dogButton);
    
    UIElement allposes_button = new ImageButton(x + pose_mountain.width + offSet/2, y + 3 * offSet, allposes, allposes_hover);
    allposes_button.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.mountainPoseView());
      }
    });
    view.addUIElement(allposes_button);
    
    //this.workoutSummaryCallback
    drawGlowHomeButton(view);
    drawBackButton(view).setActionCallback(this.sessionsCallback); 
    // submit button
    PImage endSession = loadImage("newbuttons/end_session.png");
    PImage endSessionHover = loadImage("newbuttons/end_session_hover.png");

    int offSetY = 20;
// Instead of continue it will be pose menu button
    UIElement endSessionButton = new ImageButton((width - endSession.width)/2 + 200, height - endSession.height - 3 * offSetY, endSession, endSessionHover);
    view.addUIElement(endSessionButton);
//Add Retry button
    endSessionButton.setActionCallback(this.summaryCallback);
    //buttonContinue.setActionCallback(this.measureYourWeightCallback);


    return view;
  }

  public View MeasureYourWeight()
  {
    // Create view
    View view = new View(width, height, color(128, 128, 128),
        loadImage("measure_weight_bg_new.jpg"));
    
    PImage continueIMG = loadImage("buttons/continue.png");
    PImage continueIMGHover = loadImage("buttons/continue_hover.png");
    int offSetY = 20;
    UIElement buttonContinue = new ImageButton((width - continueIMG.width)/2 + 30, height - continueIMG.height - 3 * offSetY, continueIMG, continueIMGHover);
    view.addUIElement(buttonContinue);

    //    Action Callback measureCallback = new ActionCallback()
    //      {
    //        public void doAction(UIElement e)
    //        {
    //          // MEASURE WEIGHT CODE GOES HERE
    //        }
    //      };
    //    
    buttonContinue.setActionCallback(this.learnPosesCallback);


         drawBackButton(view).setActionCallback(this.sessionsCallback); 

    // Review new view
    return view;
  }
  
  private void drawGlowHomeButton(View view)
  {
    PImage home = loadImage("reonuistuff/home.png");
    PImage homeHover = loadImage("reonuistuff/home_hover.png");
  
    UIElement homeButton = new ImageButton (80, height - 110, home, homeHover);
    view.addUIElement(homeButton);
    
    ActionCallback homeCallback = new ActionCallback()
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
    homeButton.setActionCallback(homeCallback);
  }
  

  // Private Functions
  private UIElement drawBackButton(View view)
  {
    
    PImage back = loadImage("buttons/back.png");
    PImage backHover = loadImage("buttons/back_hover.png");
    backHover.resize(50, 50);
    back.resize(50, 50);
    UIElement buttonBack = new ImageButton(20, height - 90, back, backHover);
    view.addUIElement(buttonBack);
    return buttonBack;

  }
  
  private void makeTitle(String title, int titleWidth, View view){
    UIElement titleText = new TextButton((width-titleWidth)/2, 200, titleWidth, 40,color(255, 0, 0, 0),color(255, 255, 0), 32,
        title);
    view.addUIElement(titleText);
  }
  
  public View mountainPoseView(){
  
    View view = drawVideoPoseView(videos[0], this.mountainPoseCallback, true);
    
    if (this.inAllPosesView == true)
    {
      PImage back = loadImage("buttons/back.png");
      PImage backHover = loadImage("buttons/back_hover.png");
      backHover.resize(50, 50);
      back.resize(50, 50);
      UIElement buttonBack = new ImageButton((width - back.width)/2 + 300, height - back.height -100, back, backHover);
      buttonBack.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.halfmoonPoseView());
      }
    });
      view.addUIElement(buttonBack);
    }
    
    return view;
  
  }  
  public View halfmoonPoseView(){
  
    View view = drawVideoPoseView(videos[1], this.halfMoonPoseCallback, true);
    
    if (this.inAllPosesView == true)
    {
      PImage back = loadImage("buttons/back.png");
      PImage backHover = loadImage("buttons/back_hover.png");
      backHover.resize(50, 50);
      back.resize(50, 50);
      UIElement buttonBack = new ImageButton((width - back.width)/2 + 300, height - back.height -100, back, backHover);
      buttonBack.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.warrior1PoseView());
      }
    });
      view.addUIElement(buttonBack);
    }
    return view;
  }
    
  public View warrior2PoseView(){
  
    View view = drawVideoPoseView(videos[2], this.warrior2PoseCallback, true);
    
    if (this.inAllPosesView == true)
    {
      PImage back = loadImage("buttons/back.png");
      PImage backHover = loadImage("buttons/back_hover.png");
      backHover.resize(50, 50);
      back.resize(50, 50);
      UIElement buttonBack = new ImageButton((width - back.width)/2 + 300, height - back.height -100, back, backHover);
      buttonBack.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.trianglePoseView());
      }
    });
      view.addUIElement(buttonBack);
    }
    return view;  
  }
  
  public View warrior1PoseView(){
  
    View view = drawVideoPoseView(videos[3], this.warrior1PoseCallback, true);
    
     if (this.inAllPosesView == true)
    {
      PImage back = loadImage("buttons/back.png");
      PImage backHover = loadImage("buttons/back_hover.png");
      backHover.resize(50, 50);
      back.resize(50, 50);
      UIElement buttonBack = new ImageButton((width - back.width)/2 + 300, height - back.height -100, back, backHover);
      buttonBack.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.warrior2PoseView());
      }
    });
      view.addUIElement(buttonBack);
    }
    return view;
  } 
  
  public View trianglePoseView(){
  
    View view = drawVideoPoseView(videos[4], this.trianglePoseCallback, true);
    
         if (this.inAllPosesView == true)
    {
      PImage back = loadImage("buttons/back.png");
      PImage backHover = loadImage("buttons/back_hover.png");
      backHover.resize(50, 50);
      back.resize(50, 50);
      UIElement buttonBack = new ImageButton((width - back.width)/2 + 300, height - back.height -100, back, backHover);
      buttonBack.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.standingYogaPoseView());
      }
    });
      view.addUIElement(buttonBack);
    }
    return view;
  }
  public View standingYogaPoseView(){
  
    View view = drawVideoPoseView(videos[5], this.standingYogaMudraCallback, true);
     if (this.inAllPosesView == true)
    {
      PImage back = loadImage("buttons/back.png");
      PImage backHover = loadImage("buttons/back_hover.png");
      backHover.resize(50, 50);
      back.resize(50, 50);
      UIElement buttonBack = new ImageButton((width - back.width)/2 + 300, height - back.height -100, back, backHover);
       buttonBack.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        // Get the view manger
        ViewManager viewManager = e.getView().getViewManager();
        // Create glow views object
        GlowViews glowViews = new GlowViews();
        glowViews.inAllPosesView = true;
        // Set new view
        viewManager.setView(glowViews.dogPoseView());
      }
    });
    }
    return view;
  
  }
  public View dogPoseView(){
  
    View view = drawVideoPoseView(videos[6], this.dogPoseCallback, true);    
    return view;
  
  }
  
  public View fullSession1(){
    
    return drawVideoPoseView(videos[7], this.fullSession1Callback, false);
  }
  
  public View drawVideoPoseView(String posevideo, ActionCallback action, Boolean learnmode ) {
    // Create view
    
    if (learnmode){
    View view = new View(width, height, color(128, 128, 128), loadImage("background/bg.jpg"));    // Create Views
    
    int offSetX = 400;
    int offSetYY = 400;
    //println("hi i played here");
    VideoElement videoElement = new VideoElement((width)/2, (height)/2 +20, 720, 400, GlobalPApplet.papplet, posevideo);
    //Set the globalv video element so that other buttons can control the video
    GlobalPApplet.videoElement = videoElement;
    videoElement.play();
    videoElement.setTime(30.0);
    view.addUIElement(videoElement);
    /*
    videoElement.setActionCallback( new ActionCallback{
       public void doAction(UIElement e) {
         
       }
     });
     */
    // THIS CODE SAVES THE PERCENTAGES YOU WANT TO THE FILE AND NAMES THEM ACCORDING TO VIDEO CONVENTION
    // PUT THIS IN THE CALLBACK METHOD ABOVE
    String percentage= "50%";
    p.json.setString(posevideo.substring(7, posevideo.length()-3)+"pose", percentage);
    saveJSONObject(p.json, "profiles.json");
    
    
//    PImage continueIMG = loadImage("newbuttons/session_menu.png");
//    PImage continueIMGHover = loadImage("newbuttons/session_menu_hover.png");
    int offSetY = 20;
//    UIElement buttonContinue = new ImageButton((width - continueIMG.width)/2 +250, height - continueIMG.height - 3 * offSetY, continueIMG, continueIMGHover);
//    view.addUIElement(buttonContinue);
    
    PImage retryIMG = loadImage("newbuttons/retry.png");
    PImage retryIMGHover = loadImage("newbuttons/retry_hover.png");
    UIElement retryButton = new ImageButton( (width - retryIMG.width)/2 - 300, height - retryIMG.height - 5*offSetY, retryIMG, retryIMGHover);
    view.addUIElement(retryButton);
    retryButton.setActionCallback(action);

    //buttonContinue.setActionCallback(this.learnPosesCallback);
    drawBackButton(view).setActionCallback(this.learnPosesCallback);
    drawGlowHomeButton(view);
    
    // Review new view
    return view;
    }
    else {
    View view = new View(width, height, color(128, 128, 128), loadImage("background/bg.jpg"));    // Create Views
    
    int offSetX = 400;
    int offSetYY = 400;
    println("hi i played here");
    // change video element here
    VideoElement videoElement = new VideoElement((width)/2, (height)/2 + 20, 720, 400, GlobalPApplet.papplet, posevideo);
    // Set the globalv video element so that other buttons can control the video
    GlobalPApplet.videoElement = videoElement;
    videoElement.play();
    //videoElement.setTime(30.0);
    view.addUIElement(videoElement);

    PImage continueIMG = loadImage("newbuttons/session_menu.png");
    PImage continueIMGHover = loadImage("newbuttons/session_menu_hover.png");
    int offSetY = 20;
    UIElement buttonContinue = new ImageButton((width - continueIMG.width)/2 +250, height - continueIMG.height - 3 * offSetY, continueIMG, continueIMGHover);
    view.addUIElement(buttonContinue);
    
//    PImage retryIMG = loadImage("newbuttons/retry.png");
//    PImage retryIMGHover = loadImage("newbuttons/retry_hover.png");
//    UIElement retryButton = new ImageButton( (width - retryIMG.width)/2 - 300, height - retryIMG.height - 3 * offSetY, retryIMG, retryIMGHover);
//    view.addUIElement(retryButton);
//    retryButton.setActionCallback(action);

    buttonContinue.setActionCallback(this.sessionsdoCallback);
    drawBackButton(view).setActionCallback(this.sessionsdoCallback);
    // Review new view
    return view;
    }
  }
}

