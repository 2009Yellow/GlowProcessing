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
  ActionCallback halfMoonPoseCallback;
  ActionCallback warrior2PoseCallback;
  ActionCallback warrior1PoseCallback;
  ActionCallback trianglePoseCallback;
  ActionCallback standingYogaMudraCallback;
  ActionCallback dogPoseCallback;
  ActionCallback sessionsdoCallback;
  ActionCallback fullSession1Callback;
  Boolean inAllPosesView;
  ProfManager manager;
  final ProfManager p = new ProfManager();

  public GlowViews()
  {
    this.inAllPosesView = false;
    this.manager = new ProfManager();

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

    this.mountainPoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        /*ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());*/
        workoutManager.newPose(1);
      }
    };

    this.halfMoonPoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());
        workoutManager.newPose(2);
      }
    };
    this.warrior2PoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());
       workoutManager.newPose(3);
      }
    };
    this.warrior1PoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());
        workoutManager.newPose(4);
      }
    };
    this.trianglePoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());
        workoutManager.newPose(5);
      }
    };
    this.standingYogaMudraCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());
        workoutManager.newPose(6);
      }
    };
    this.dogPoseCallback = new ActionCallback()
    {
      public void doAction(UIElement e)
      {
        ViewManager viewManager = e.getView().getViewManager();
        GlowViews glowViews = new GlowViews();
        viewManager.setView(glowViews.learnNewPoses());
        workoutManager.newPose(7);
      }
    };
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

    UIElement startup_button = new ImageButton(x + pose_mountain.width + offSet/2, y + 3 * offSet, allposes, allposes_hover);
    startup_button.setActionCallback(new ActionCallback()
    {
      public void doAction(UIElement e)
      {
         workoutManager.startupSequence();
      }
    }
    );
    view.addUIElement(startup_button);
    // submit button
    PImage endSession = loadImage("newbuttons/end_session.png");
    PImage endSessionHover = loadImage("newbuttons/end_session_hover.png");

    int offSetY = 20;
    // Instead of continue it will be pose menu button
    UIElement endSessionButton = new ImageButton((width - endSession.width)/2 + 200, height - endSession.height - 3 * offSetY, endSession, endSessionHover);
    view.addUIElement(endSessionButton);



    return view;
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

  private void makeTitle(String title, int titleWidth, View view) {
    UIElement titleText = new TextButton((width-titleWidth)/2, 200, titleWidth, 40, color(255, 0, 0, 0), color(255, 255, 0), 32, 
    title);
    view.addUIElement(titleText);
  }
}

