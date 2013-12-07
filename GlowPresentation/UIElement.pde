import de.bezier.guido.*;

public abstract class UIElement{
  protected int x, y, elementWidth, elementHeight;
  protected View view;
  protected boolean checked;
  protected ActionCallback actionCallback;  
  
  public UIElement(int xx, int yy, int w, int h) {
    //Interactive.remove((UIElement)this);
    x = xx;
    y = yy;
    checked = false;
    elementWidth = w;
    elementHeight = h;
    // register it with the manager
    //Interactive.add(this );
  }
  
  public void destroy() {
    //view.remove(this);
    //Interactive.remove(this);
  }
  
  public void setView(View v) {
    view = v;
  }
  
  public View getView() {
    return view;
  }
  
  public void setActionCallback(ActionCallback c) {
    actionCallback = c;
  }
  
  public void activateActionCallback() {
    if (actionCallback != null) {
      actionCallback.doAction(this);
    }
  }
  
  // Implemented for AbstractActiveElement
  /*
  public abstract void mousePressed ( );
  //public void mousePressed ( float mx, float my ) {};
  public void mouseDoubleClicked ( ){};
  public void mouseDoubleClicked ( float mx, float my ){};
  public void mouseDragged ( float mx, float my ){};
  public void mouseDragged ( float mx, float my, float dx, float dy ){};
  public void mouseReleased ( ){};
  public void mouseReleased ( float mx, float my ){};
  */

}
