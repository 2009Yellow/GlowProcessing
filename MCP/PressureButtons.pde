class PressureButtons {
  
  int mat_h;
  int mat_w;
  MatIn matIn;
  
  boolean leftButton = false;
  boolean rightButton = false;
 // boolean selectButton = false;
  
  float[][] BUTTON_AREAS = {{2, 0, 8, 2}, {9, 0, 15,2}};
  
  PressureButtons(int mat_h, int mat_w, MatIn matIn) {
    
    this.mat_h = mat_h;
    this.mat_w = mat_w;
    this.matIn = matIn;
    
  }
  
  
  String getButtonState() {
    
    if(leftButton) {return "left";}
    else if(rightButton) {return "right";}
    else if(selectButton) {return "select";}
    return "";
  }
  
  
  void processButtonData() {
    
    float[][] rawData = matIn.getPressureDataMatrix();
    float[] buttonPressureTotals = help.sumAreas(rawData, BUTTON_AREAS);
    
  }
  
}
