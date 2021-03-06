class LED {
  float[] pixelNumbers;
  float[] colors;
  MatIn matIn;
  Pose pose;

  /*
  in colors:
   1 = purple
   2 = white
   3 = red
   */

  int[] allW;

  LED(MatIn matIn, Pose pose) {
    this.matIn = matIn;
    this.pose = pose;
    setLeds();
    colors = new float[pixelNumbers.length];

    for (int i = 0; i<colors.length; i++) {
      colors[i] = 1;
    }

    matIn.setLights(pixelNumbers, colors);
  }


  void setLeds() {
    pixelNumbers = pose.getLeds();
  }

  void poseEvent() {
    setLeds();
    println("LED:: poseEvent");

    //all lights start out purple for a new pose
    int numAreas = pixelNumbers.length;
    colors = new float[numAreas];

    for (int i =0; i<numAreas; i++) {
      colors[i] = 1;  //1 = white LEDs for start of pose
    }
    println(pixelNumbers);
    matIn.setLights(pixelNumbers, colors);
  }

  void pressureEvent(float[] pressure) {
    println("LED:: pressureEvent");
    boolean allBalanceCorrect = true;

    for ( int i = 0; i<pressure.length; i++) {
      if (pressure[i] != 0 ) // if the pressure isn't correct
      {
        allBalanceCorrect = false;
      }
    }


    for ( int i = 0; i<pressure.length; i++) {
      if (allBalanceCorrect) {
        colors[i] = 4; //green for all correct
      }
      else {
        colors[i] = pressure[i]+2;
      }
    }

    //println("new colors");
    //println(colors);
    println(pixelNumbers);

    matIn.setLights(pixelNumbers, colors);
  }
}

