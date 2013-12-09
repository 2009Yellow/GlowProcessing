public class MatController {

  MatIn matIn;
  Helpers help;
  Balance balance;
  Pose pose;
  LED led;

  int HEIGHT = 16; //Do we still need HEIGHT and WIDTH here? It looks like we don't/it could be replaced with matWidth and matHeight, defined in MatIN
  int WIDTH = 16;  
  int TIMEOUT = 200;

  float[] lastPressure;
  long lastTime;


  MatController(PApplet papplet, Pose pose) {
    matIn = new MatIn(HEIGHT, WIDTH, papplet);
    help = new Helpers();
    this.pose  = pose;
    balance = new Balance(HEIGHT, WIDTH, matIn, pose);
    led = new LED(matIn, pose);
    lastTime = System.currentTimeMillis();

    //initialize lastPressure to all zeroes
    resetLastPressure();
  }

  
  //returns the percentage of the pose time the user had the correct balance distribution
  int getPercentTimeCorrect(){
    return balance.getPercentTimeCorrect();
  }
  
  // so that if we reset to a pose, initially all positions are purple,
  // and then allows lighting update to change when balance distribution is even 
  void resetLastPressure() {
    lastPressure = new float[balance.getBinaryFeedback().length];
    for (int i = 0; i<lastPressure.length; i++) {
      lastPressure[i] = -1;
    }
  }

  // this gets called continuously
  void loadData() {
    matIn.update();
    matIn.getPressureDataMatrix();
  }

  void processBalanceData() {

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
      //println("it changed!");
      led.pressureEvent(currentPressure);
      lastPressure = currentPressure;
    }
  }

  void poseEvent() {
    //println("MatController::poseEvent()");
    balance.poseEvent(); //pose already updated to new pose by WorkoutManager
    resetLastPressure();
    led.poseEvent();
    //println("MatController::poseEvent() finihsed");
  }

  void stopPose() {
    pose.stopPose();
    balance.poseEvent();
    led.poseEvent();
  }
}

