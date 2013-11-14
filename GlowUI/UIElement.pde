public class UIElement extends ActiveElement {
  public UIElement() {
    // register it with the manager
    Interactive.add(this );
  }
  
  public void destroy() {
    Interactive.remove(this);
  }
  
}
