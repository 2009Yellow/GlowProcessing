public class TextElement extends TextButton {
  
  public TextElement( int xx, int yy, int w, int h, color bc, color tc, int ts, String s) {
   super(xx,  yy,  w,  h,  bc,  tc,  ts, s); 
   enabled = false;
  }
  
  public TextElement( int xx, int yy, int w, int h, color bc, color tc, int ts, int tb,  String s) {
   super(xx,  yy,  w,  h,  bc,  tc,  ts, tb, s); 
   enabled = false;
  }
}

