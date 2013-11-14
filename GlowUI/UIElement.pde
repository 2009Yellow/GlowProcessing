import de.bezier.guido.AbstractActiveElement;

public abstract class UIElement extends AbstractActiveElement {
  public UIElement() {
    // register it with the manager
    Interactive.add(this );
  }
  
  public void destroy() {
    Interactive.remove(this);
  }
  
  public void mousePressed ( ){};
  public void mousePressed ( float mx, float my ){};
  public void mouseDoubleClicked ( ){};
  public void mouseDoubleClicked ( float mx, float my ){};
  public void mouseDragged ( float mx, float my ){};
  public void mouseDragged ( float mx, float my, float dx, float dy ){};
  public void mouseReleased ( ){};
  public void mouseReleased ( float mx, float my ){};

}
