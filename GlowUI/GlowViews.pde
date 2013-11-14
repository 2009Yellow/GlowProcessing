public class GlowViews {
  PApplet papplet;
  
  public GlowViews(PApplet papplet) {
    this.papplet = papplet;
  }
  
  public View HelloView() {
    PImage img = papplet.loadImage("yellow-background.jpg");
    View view =  new View(papplet.width, papplet.height,color(255,255,0), img); 
    // Add buttons to view
    UIElement dogButton = new ImageButton(200, 200, loadImage("dog.jpg"));
    //view.addUIElement(dogButton);
    UIElement dogElement = new ImageElement(400, 200, loadImage("dog.jpg"));
    //view.addUIElement(dogElement);
    UIElement textButton = new TextButton(100, 200, 100, 100, color(255, 0, 0), color(255, 255, 255), 32, "Hi");
    //view.addUIElement(textButton);
    UIElement textInput = new TextInputBox(300, 200, 300, 80, 32, "Hi");
    view.addUIElement(textInput);
    view.addKeyEventListener((KeyEventListener)textInput);
    //UIElement simpleButton = new SimpleButton(400, 400, 40, 40);
    //view.addUIElement(simpleButton);

    // Return
    return view;
  }
}



    
