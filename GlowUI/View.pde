
public class View {
  // View member variabls
  private color backgroundColor;
  private PImage backgroundImage;
  private int viewWidth, viewHeight;
  private ArrayList<UIElement> uiElements;
  
  // ========================== Constructor ==========================
  public View(int w, int h, color background_c, PImage background_i) {
    // Add to manager
    super();
    // Init list of UI elements
    uiElements = new ArrayList<UIElement>();
    // Set width /height
    viewWidth = w;
    viewHeight = h;
    // Set background
    backgroundColor = background_c;
    backgroundImage = background_i; 
  }
  
  // ========================== Private Methods ==========================

  
  // ========================== Public Methods ==========================
  public void setBackgroundColor(color c) {
    backgroundColor = c;
  }
  
  public void setBackgroundImage(PImage image) {
    backgroundImage = image;
  }
  
  void addUIElement(UIElement element) {
    uiElements.add(element);
  }
  
  public void destroy() {
    // Destroys all the UIElements in this view
    for (UIElement e: uiElements) {
      e.destroy();
    }
  }
  
  public void draw() {
    // Draw the backround image if its not null, else just draw backround color
    if (backgroundImage != null) {
      image(backgroundImage, 0, 0);
    } else {
      background(backgroundColor);
    }
  }
}
