class Pressure { // Analyzes

  int mat_h; //number of rows of sensors in the mat
  int mat_w; // number of coumns of sensors in the mat
  float[] diff; // after the normalized pressure values have been sumed for each matArea, diff is the difference between these values and the ref values
  float weight = 1000;
  
  MatIn matIn;
  float[][] poseAreas;
  //This is part of a .csv file containing all nessecary info about a given pose
  Pose pose;
  Helpers help;
  int N = 3;  //number of data points to average over
  //for testing purposes
  MatGraphics matGraphics;

  Pressure(int mat_h, int mat_w, MatIn matIn, Pose pose) { 
    //initialize variables
    this.pose = pose;
    this.matIn = matIn;    //lets Pressure talk to the arduino
    this.mat_h = mat_h;
    this.mat_w = mat_w;
    help = new Helpers();
    setAreas(pose.getAreas());

    //just for testing
    //matGraphics = new MatGraphics(mat_h, mat_w);
  }

  void setAreas(float[][] poseAreas) {
    this.poseAreas = poseAreas;
  }

  void updateAreas() {
    setAreas(pose.getAreas());
  }
  
  void getWeight(){
    float[] areaWeights = new float[poseAreas.length];
    areaWeights = help.sumAreas(matIn.getPressureDataMatrix(), poseAreas);
    
    weight = help.sumVector(areaWeights);
    //println("Your weight is " + weight);
  }
  
  //gives total normalized pressure in each area
  float[] getNormPressDist() {  
    float[][] rawData = matIn.getPressureDataMatrix();

    //for testing
    //matGraphics.drawDisplay(rawData);
    
    //TODO: delete the necessity for onPressureMat() and weight
    float[] areaSums = help.sumAreas(rawData, poseAreas, pose.onPressureMat(), weight);
    return normAreas(areaSums);
  }

  //normalizes the data
  float[] normAreas(float[] input) {
    //float[][] output = new float[HEIGHT][WIDTH];
    float mass = 0;
    for (int i = 0; i < input.length; ++i) {
      mass += input[i];
    }
    float[] output = help.multMat(input, 1.0/mass);
    return output;
  }
  
  boolean isWeightSignificant(){
    float[] areaSums = help.sumAreas(matIn.getPressureDataMatrix(),poseAreas);
    float currentPressureTotal = help.sumVector(areaSums);
    
    return currentPressureTotal > help.SINGLE_VALUE_THRESHOLD*10;
  }
  
}

