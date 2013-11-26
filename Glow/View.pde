
public class View {
  // View member variabls
  protected color backgroundColor;
  protected PImage backgroundImage;
  protected int viewWidth, viewHeight;
  protected ArrayList<UIElement> uiElements;
  protected ArrayList<KeyEventListener> keyEventListeners;

  ViewManager viewManager;

  // Font for this view
  public final PFont viewFont = createFont("dosis/Dosis-Medium.ttf", 48);
  //public final PFont viewFont = createFont("helvetica/Dosis-Medium.ttf", 48);

  // ========================== Constructor ==========================
  public View(int w, int h, color background_c, PImage background_i) {
    // Add to manager
    super();
    // Init list of UI elements
    uiElements = new ArrayList<UIElement>();
    keyEventListeners = new ArrayList<KeyEventListener>();
    // Set width /height
    viewWidth = w;
    viewHeight = h;
    // Set background
    backgroundColor = background_c;
    backgroundImage = background_i; 
    // Set view font
    textFont(viewFont);
  }

  public View(int w, int h, color background_c) {
    // Add to manager
    super();
    // Init list of UI elements
    uiElements = new ArrayList<UIElement>();
    keyEventListeners = new ArrayList<KeyEventListener>();
    // Set width /height
    viewWidth = w;
    viewHeight = h;
    // Set background
    backgroundColor = background_c;
    backgroundImage = null; 
    // Set view font
    textFont(viewFont);
  }

  // ========================== Private Methods ==========================


  // ========================== Public Methods ==========================
  public void setBackgroundColor(color c) {
    backgroundColor = c;
  }

  public PFont getFont() {
    return viewFont;
  }

  public void setBackgroundImage(PImage image) {
    backgroundImage = image;
  }

  public void addUIElement(UIElement element) {
    // register it with the manager
    element.setView(this);
    Interactive.add(element);
    uiElements.add(element);
  }

  public void addKeyEventListener(KeyEventListener l) {
    keyEventListeners.add(l);
  }


  public void setViewManager(ViewManager vm) {
    viewManager = vm;
  }

  public ViewManager getViewManager() {
    return viewManager;
  }

  public void keyEvent(KeyEvent e) {
    for (KeyEventListener l: keyEventListeners) {
      l.keyEvent(e);
    }
  }

  public void destroy() {
    // Destroys all the UIElements in this view
    for (UIElement e: uiElements) {
      Interactive.remove(e);
      e.destroy();
    }
    //viewManager.setView(null);
  }
  
  public void remove(UIElement e) {
    uiElements.remove(e);
    Interactive.remove(e);
  }

  public void draw() {
    // Draw the backround image if its not null, else just draw backround color
    if (backgroundImage != null) {
      image(backgroundImage, 0, 0);
    } 
    else {
      background(backgroundColor);
    }
  }
}



public class SplashView extends View {
  private PImage logo;
  private long lastTime;
  private int fadeState;
  private long fadeInTime = 1000;
  private long fadeHoldTime = 1000;
  private long fadeOutTime = 1000;
  
  //private View nextView;
  private ActionCallback nextViewCallback;
  
  
  public SplashView(int w, int h, color background_c, PImage background_i, PImage l, ActionCallback nvc) {
    super(w,h, background_c, background_i);
    logo = l;
    lastTime = -1;
    fadeState = 0;
    nextViewCallback = nvc;
  }
  
  public void draw() {
    super.draw();
    // Set the last time if we've never been drawn
    if (lastTime == -1) {
      lastTime = System.currentTimeMillis();
    }
    // Get the current time
    long timeDiff = System.currentTimeMillis() - lastTime;
    // Fade in or fade out logo
    float weight;
    if(fadeState == 0) {
      weight = (float)timeDiff/fadeInTime;
      // Change to fade out if past time
      if (timeDiff > fadeInTime) {
        fadeState = 1;
        lastTime = System.currentTimeMillis();
      }
    } else if (fadeState == 1) {
      weight = 1.0;
      if (timeDiff > fadeHoldTime) {
        fadeState = 2;
        lastTime = System.currentTimeMillis();
      }
    } else {
      weight = 1.0 - (float)timeDiff/fadeOutTime;
      // Check to see if we should bring up next view
      checkNextView(timeDiff);
    }
    
    pushStyle();
    imageMode(CENTER);
    tint(255, 255 * weight);
    image(logo, width/2, height/2);
    popStyle();
  }
  
  public void checkNextView(long timeDiff) {
    if (fadeState == 2) {
      if (timeDiff >= fadeOutTime) {
        nextViewCallback.doAction(null);
      }
    }
  }
}

