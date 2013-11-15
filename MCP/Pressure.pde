class Pressure{ // Analyzes
  
  int mat_h; //number of rows of sensors in the mat
  int mat_w; // number of coumns of sensors in the mat
  float[] diff; // after the normalized pressure values have been sumed for each matArea, diff is the difference between these values and the ref values

  MatIn matIn;
  float[][] poseAreas;// = {{0,0,0,0},{0,1,0,1}};  // Row defined two points that define rectangles on the mat, in which the hands/feet are placed. 
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
    
    float[] areaSums = sumAndAvgAreas(rawData,2);
    return normAreas(areaSums);
  }

 public float[] multMat(float[] input, float factor) {
      float[]output = new float[input.length];
      for (int i = 0; i < input.length; ++i) {
          output[i] = input[i]*factor;
        }
      return output;
  }

  //receives poseAreas (each row contains data about one point of contact with mat)
  float[] sumAndAvgAreas(float [][] rawData, int nAvg){
    float[] areaSums = new float[poseAreas.length];
  
    //loop through the different contact areas listed defined by poseAreas
    for (int areaNum = 0; areaNum < poseAreas.length; areaNum++)
    {
      int sum = 0;
      for (int i = (int)poseAreas[0][areaNum]; i <= (int)poseAreas[2][areaNum]; ++i) {
        for (int j = (int)poseAreas[1][areaNum]; j <= (int)poseAreas[3][areaNum]; ++j) {
          float temp = rawData[i][j];
          sum+=rawData[i][j];
        }
      }
    
      areaSums[areaNum] = sum;
    }
    
    float[] averagedAreaSums = averageData(areaSums,nAvg); //average data over nAvg historical data sets
  
    return averagedAreaSums;
  
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

float[] averageData(float[] dataNew,int n) { //dataNew is array of summed pressures from sensing areas on the mat and n is the number of time steps to average over
  float[][] dataRecord = new float[n][dataNew.length]; //intialize an array to hold n historical data sets
  
    for (int i = 0; i < n-1; ++i) {
      dataRecord[i] = dataRecord[i+1]; //delete oldest data, shift to make room for new data
    }
  dataRecord[n-1] = dataNew; //add new data
  
  float[] dataOut = new float[dataNew.length];
    
    for (int i = 0; i < n; ++i) {
      for(int j = 0; j < dataNew.length; ++j){
      dataOut[j] = +dataRecord[i][j]; //painstakingly with java code sum a 2d array of historical data
      }
    }
  return multMat(dataOut,1/n); //normalize (i.e. find average) of historical data
}








}
