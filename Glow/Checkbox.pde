public class CheckBox extends UIElement
{
    boolean checked;
    int x, y, width, height;
    String label;
    float padx = 7;
    PFont font;
    CheckBox (int xx, int yy, int ww, int hh, String l )
    {
        super(xx, yy, ww, hh);
        label = l;
        x = xx; y = yy; width = ww; height = hh;
    }
    
    void mouseReleased ()
    {
        checked = !checked;
    }
    
    void draw ()
    {
        noStroke();
        fill( 200 );
        rect( x, y, width, height );
        if ( checked )
        {
            fill( 80 );
            rect( x+2, y+2, width-4, height-4 );
        }
        fill( 255 );
        //font = loadFont("papyrus.vlw");
        //textFont(font, 28);
        textAlign( LEFT );
        textSize(24); 
        text( label, x+width+padx, y+height );
    }
    
    // this is a special inside test that includes the label text
    
    boolean isInside ( float mx, float my )
    {
        return Interactive.insideRect( x,y,width+padx+textWidth(label), height, mx, my );
    }
}
