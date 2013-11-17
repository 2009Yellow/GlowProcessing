
public class View {
  // View member variabls
  private color backgroundColor;
  private PImage backgroundImage;
  private int viewWidth, viewHeight;
  private ArrayList<UIElement> uiElements;
  private ArrayList<KeyEventListener> keyEventListeners;

  ViewManager viewManager;

  // Font for this view
  private final PFont viewFont = createFont("dosis/Dosis-Medium.ttf", 48);

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

