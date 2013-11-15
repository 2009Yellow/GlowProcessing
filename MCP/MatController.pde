public class MatController {

  MatIn matIn;
  Balance balance;
  Pose pose;
  LED led;

  int HEIGHT = 4; //Do we still need HEIGHT and WIDTH here? It looks like we don't/it could be replaced with matWidth and matHeight, defined in MatIN
  int WIDTH = 4;  

  float[] lastPressure;

  MatController(PApplet papplet, Pose pose) {
    matIn = new MatIn(HEIGHT, WIDTH, papplet);
    this.pose  = pose;
    balance = new Balance(HEIGHT, WIDTH, matIn, pose);
    led = new LED(matIn, pose);

    //initialize lastPressure to all zeroes
    lastPressure = new float[balance.getBinaryFeedback().length];
  }

  void loadAndProcessData() {
    matIn.update();
    float[] currentPressure = balance.getBinaryFeedback();
    
    //detect possible change in pressure state
    boolean pressureSame = true;
    
    for (int i = 0; i<currentPressure.length; i++) {
      if (currentPressure[i] != lastPressure[i]) {
        pressureSame = false;
      }
    }
    
    //only talk to LEDs if there was a pressure change
    if (!pressureSame) {
      led.pressureEvent(currentPressure);
      lastPressure = currentPressure;
      println("it changed!");
    }
  }

  void poseEvent() {
    balance.poseEvent();
    //led.poseEvent();
  }
}

