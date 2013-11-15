class LED {
  float[] pixelNumbers;
  float[] colors;
  MatIn mat;
  Pose pose;

  /*
  in colors:
   1 = purple
   2 = white
   3 = red
   */

  int[] allW;

  LED(MatIn mat, Pose pose) {
    this.mat = mat;
    this.pose = pose;
    setLeds();
    colors = new float[pixelNumbers.length];
  }


  void setLeds() {
    pixelNumbers = pose.getLeds();
  }

  void poseEvent() {
    setLeds();

    //all lights start out purple for a new pose
    int numAreas = pixelNumbers.length;
    colors = new float[numAreas];

    for (int i =0; i<numAreas; i++) {
      colors[i] = 1;  //1 = purple LEDs for start of pose
    }
  }

  void pressureEvent(float[] pressure) {

    for ( int i = 0; i<pressure.length; i++) {
      colors[i] = pressure[i]+2;
    }
  }
}

