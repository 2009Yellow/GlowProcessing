class Pressure{ // Analyzes
  
  int mat_h; //number of rows of sensors in the mat
  int mat_w; // number of coumns of sensors in the mat
  float[] diff; // after the normalized pressure values have been sumed for each matArea, diff is the difference between these values and the ref values

  MatIn matIn;
  float[][] poseAreas = {{0,0,0,0},{0,1,0,1}};  // Row defined two points that define rectangles on the mat, in which the hands/feet are placed. 
                                            //This will eventually be part of a .txt file containing all nessecary info about a given pose
  Pose pose;


  //for testing purposes
  MatGraphics matGraphics;

  Pressure(int mat_h, int mat_w, MatIn matIn, Pose pose) { 
    //initialize variables
     this.pose = pose;
     this.matIn = matIn;    //lets Pressure talk to the arduino
     this.mat_h = mat_h;
     this.mat_w = mat_w;
     setAreas(pose.getAreas());
     
     //just for testing
     matGraphics = new MatGraphics(mat_h, mat_w);
  }

  void setAreas(float[][] poseAreas){
    this.poseAreas = poseAreas;
  }

  void updateAreas(){
    setAreas(pose.getAreas());
  }

  //gives total normalized pressure in each area
  float[] getNormPressDist(){  
    float[][] rawData = matIn.getPressureDataMatrix();
    
    //for testing
    matGraphics.drawDisplay(rawData);
    
    float[] areaSums = sumAreas(rawData);
    return normAreas(areaSums);
  }

  float[] multMat(float[] input, float factor) {
      float[]output = new float[input.length];
      for (int i = 0; i < input.length; ++i) {
          output[i] = input[i]*factor;
        }
      return output;
  }

  //receives poseAreas (each row contains data about one point of contact with mat)
  float[] sumAreas(float [][] rawData){
    float[] areaSums = new float[poseAreas.length];
  
    //loop through the different contact areas listed defined by poseAreas
    for (int areaNum = 0; areaNum < poseAreas.length; areaNum++)
    {
      int sum = 0;
      for (int i = (int)poseAreas[areaNum][0]; i <= (int)poseAreas[areaNum][2]; ++i) {
        for (int j = (int)poseAreas[areaNum][1]; j <= (int)poseAreas[areaNum][3]; ++j) {
          sum+=rawData[i][j];
        }
      }
    
      areaSums[areaNum] = sum;
    }
  
    return areaSums;
  
  }

  //normalizes the data
  float[] normAreas(float[] input) {
      //float[][] output = new float[HEIGHT][WIDTH];
      float mass = 0;
      for (int i = 0; i < input.length; ++i) {
          mass += input[i];
      }
      float[] output = multMat(input,1/mass);
      return output;
  }

}
