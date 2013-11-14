import de.bezier.guido.ActiveElement;

public abstract class UIElement {
  public UIElement() {
    // register it with the manager
    Interactive.add(this );
  }
  
  public void destroy() {
    Interactive.remove(this);
  }
  
}
