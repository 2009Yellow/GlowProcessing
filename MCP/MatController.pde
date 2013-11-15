public class MatController {
   
  MatIn matIn;
  Balance balance;
  Pose pose;
  //LED led;
    
  int HEIGHT = 4; //Do we still need HEIGHT and WIDTH here? It looks like we don't/it could be replaced with matWidth and matHeight, defined in MatIN
  int WIDTH = 4;  

  
  MatController(PApplet papplet, Pose pose) {
    matIn = new MatIn(HEIGHT, WIDTH, papplet);
    this.pose  = pose;
    balance = new Balance(HEIGHT, WIDTH, matIn, pose);
    //led = new LED(matIn);
  }
    
  void loadAndProcessData(){
    matIn.update();
    float[] currentPressure = balance.getBinaryFeedback();
    
    //if current pressure is different from previous pressure
    //led.pressureEvent(currentPressure);
  }
    
  void poseEvent(){
    balance.poseEvent();
    //led.poseEvent();
  }
}
    
