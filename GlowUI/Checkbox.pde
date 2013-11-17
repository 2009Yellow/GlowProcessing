public class CheckBox extends UIElement
{
    boolean checked;
    int x, y, width, height;
    String label;
    float padx = 7;

    //PFont font;
    PFont font;
    PImage checkedImage;
    PImage uncheckedImage;
    PImage hoverImage;
    public boolean hover = false;
    public boolean active;
    int imageSize;
    public CheckBox (int xx, int yy, int ww, int hh, String l)
    {
        super(xx, yy, ww, hh);
        label = l;
        this.active = true;
        this.imageSize = 37;
        checkedImage = loadImage("buttons/radio_selected.png");
        uncheckedImage = loadImage("buttons/radio_not_selected.png");
        hoverImage = loadImage("buttons/radio_not_selected_hover.png");
        x = xx; y = yy; width = ww; height = hh;
    }
    
    public boolean isChecked() {
        return checked; 
    }
    
    void mouseReleased ()
    {
        checked = !checked;
    }
    
    public boolean isInside ( float mx, float my ) {
      hover = Interactive.insideRect( x, y, elementWidth, elementHeight, mx, my );
      return hover;
    }
    
    void draw ()
    {
        noStroke();
        image(uncheckedImage, x, y, this.imageSize, this.imageSize);
        if ( checked && this.active)
        {
          image(checkedImage, x, y, this.imageSize, this.imageSize);
        }
        if ( hover && !checked) 
        {
          image(hoverImage, x, y, this.imageSize, this.imageSize);
        }
        fill( 55 );
        //font = loadFont("papyrus.vlw");
        //textFont(font, 28);
        textAlign( LEFT );
        textSize(26); 
        text( label, x + this.imageSize + padx, y + this.imageSize - 10 );
    }
}
