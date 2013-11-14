import de.bezier.guido.AbstractActiveElement;

public abstract class UIElement extends AbstractActiveElement {
  protected int x, y, elementWidth, elementHeight;
  
  protected View view;
  
  public UIElement(int xx, int yy, int w, int h) {
    //super();
    //rInteractive.remove((UIElement)this);
    x = xx;
    y = yy;
    elementWidth = w;
    elementHeight = h;
    // register it with the manager
    //Interactive.add(this );
  }
  
  public void destroy() {
    //Interactive.remove(this);
  }
  
  public void setView(View v) {
    view = v;
  }
  
  public View getView() {
    return view;
  }
  
  // Implemented for AbstractActiveElement
  public void mousePressed ( ){};
  public void mousePressed ( float mx, float my ){};
  public void mouseDoubleClicked ( ){};
  public void mouseDoubleClicked ( float mx, float my ){};
  public void mouseDragged ( float mx, float my ){};
  public void mouseDragged ( float mx, float my, float dx, float dy ){};
  public void mouseReleased ( ){};
  public void mouseReleased ( float mx, float my ){};

}
