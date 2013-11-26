class PressureButtons {

  int mat_h;
  int mat_w;
  MatIn matIn;

  int BUTTON_THRESHOLD = help.SINGLE_VALUE_THRESHOLD * 5;
  // boolean selectButton = false;

  //{{right}, {left}}
  //,float[][] BUTTON_AREAS = {{2, 0, 8, 2}, {9, 0, 15, 2}};
  float[][] BUTTON_AREAS = {{4, 12}, {0,0}, {7,15}, {1,1}};
  boolean[] previousButtonStates = {false, false};

  PressureButtons(int mat_h, int mat_w, MatIn matIn) {

    this.mat_h = mat_h;
    this.mat_w = mat_w;
    this.matIn = matIn;
  }

  //this is called continuously
  String getButtonAction() {
    
    boolean[] buttonActions = debounce(processButtonData());
    if (buttonActions[1]) {
      println("left");
      return "left";
    }
    else if (buttonActions[0]) {
      println("right");
      return "right";
    }
    // else if(selectButton) {return "select";}
    return "none";
  }
  

  //returns states of buttons based on current pressures on the buttons on the mat
  boolean[] processButtonData() {

    float[][] rawData = matIn.getPressureDataMatrix();
    float[] buttonPressureTotals = help.sumAreas(rawData, BUTTON_AREAS);
    boolean[] currentButtonStates = new boolean[previousButtonStates.length];

    //do nothing if there is an insignificant amount of weight on the buttons
    if (buttonPressureTotals[0] < BUTTON_THRESHOLD && buttonPressureTotals[1] < BUTTON_THRESHOLD) { 
      return currentButtonStates; //all initialized to false
    }

    if (buttonPressureTotals[0] > buttonPressureTotals[1]) {
      currentButtonStates[0] = true;
    }

    else {
      currentButtonStates[1] = true;
    }  

    return currentButtonStates;
  }
  
  // so that we don't get multiple button actions for one button press
  boolean[] debounce(boolean[] currentButtonState) {

    boolean[] buttonActions = new boolean[previousButtonStates.length];

    for (int i = 0; i<previousButtonStates.length; i++) {
      //if the previous button state and current button state are different
      //set the previous button state to the current button state and return the current state
      if (!previousButtonStates[i] && currentButtonState[i] ||
                    previousButtonStates[i] && !currentButtonState[i]) {
        buttonActions[i] = currentButtonState[i];
        previousButtonStates[i] = currentButtonState[i];
      }
    }
    
    return buttonActions;
  }
  
  
}

