public class GlowViews {
  PApplet papplet;
  
  public GlowViews(PApplet papplet) {
    this.papplet = papplet;
  }
  
  public View HelloView() {
    PImage img = papplet.loadImage("yellow-background.jpg");
    View view =  new View(papplet.width, papplet.height,color(255,255,0), img); 
    // Add buttons to view
    //UIElement dogButton = new ImageButton(200, 200, loadImage("dog.jpg"));
    //view.addUIElement(dogButton);
    UIElement simpleButton = new SimpleButton(400, 400, 40, 40);
    view.addUIElement(simpleButton);

    // Return
    return view;
  }
}



    
