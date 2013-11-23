class Pressure { // Analyzes

  int mat_h; //number of rows of sensors in the mat
  int mat_w; // number of coumns of sensors in the mat
  float[] diff; // after the normalized pressure values have been sumed for each matArea, diff is the difference between these values and the ref values
  float weight = 1000;
  
  MatIn matIn;
  float[][] poseAreas;
  //This is part of a .csv file containing all nessecary info about a given pose
  Pose pose;
  float[][] dataRecord;//intialize an array to hold n historical data sets
  int N = 3;  //number of data points to average over
  //for testing purposes
  MatGraphics matGraphics;

  Pressure(int mat_h, int mat_w, MatIn matIn, Pose pose) { 
    //initialize variables
    this.pose = pose;
    this.matIn = matIn;    //lets Pressure talk to the arduino
    this.mat_h = mat_h;
    this.mat_w = mat_w;
    setAreas(pose.getAreas());
    dataRecord = new float[N][poseAreas.length];

    //just for testing
    //matGraphics = new MatGraphics(mat_h, mat_w);
  }

  void setAreas(float[][] poseAreas) {
    this.poseAreas = poseAreas;
  }

  void updateAreas() {
    setAreas(pose.getAreas());
  }

  void updateRecord() {
    dataRecord = new float[N][poseAreas.length];
  }
  
  void getWeight(){
    float[] areaWeights = new float[poseAreas.length];
    for(int i =0; i<N; i++) {
      areaWeights = sumAndAvgAreas(matIn.getPressureDataMatrix());
      //implementing a 250ms delay so we can fill the buffer in a time-averaging function
      long lastTime = System.currentTimeMillis();
      long currentTime = System.currentTimeMillis();
      while(currentTime-lastTime <250){
        currentTime = System.currentTimeMillis();
      }
    }
    
    float sumWeight = 0;
    
    for(int i = 0; i<areaWeights.length; i++){
      sumWeight+= areaWeights[i];
    }
    
    weight = sumWeight;
    println("Your weight is " + weight);
  }
  
  //gives total normalized pressure in each area
  float[] getNormPressDist() {  
    float[][] rawData = matIn.getPressureDataMatrix();

    //for testing
    //matGraphics.drawDisplay(rawData);

    float[] areaSums = sumAndAvgAreas(rawData);
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
  float[] sumAndAvgAreas(float [][] rawData) {
    float[] areaSums = new float[poseAreas[0].length];
    float[] onMat = pose.onPressureMat();
    //loop through the different contact areas listed defined by poseAreas
    for (int areaNum = 0; areaNum < poseAreas[0].length; areaNum++)
    {
      float sum = 0;
      
      if(onMat[areaNum] == 0) {
        println("imaginary area!");
        
        if(areaSums.length == 2){
          sum = weight-areaSums[areaNum-1];
          areaSums[areaNum] = sum;
        }
        
        else{ //assuming there are 4 contact points for now
          sum = (weight-(areaSums[0]+areaSums[1]))/2;
          areaSums[areaNum] = sum;
          areaSums[areaNum+1] = sum;
        }
        break;
      }
      for (int i = (int)poseAreas[0][areaNum]; i <= (int)poseAreas[2][areaNum]; ++i) {
        for (int j = (int)poseAreas[1][areaNum]; j <= (int)poseAreas[3][areaNum]; ++j) {
          float temp = rawData[i][j];
          //if( temp >=100){  //added a threshold value to get rid of noise
            sum+=temp;
          //} 
        }
      }
    
      areaSums[areaNum] = sum;
    }

    float[] averagedAreaSums = averageData(areaSums); //average data over N historical data sets
    //println(averagedAreaSums[0]);
    
    println("Avg area sums");
    println(averagedAreaSums);
    return averagedAreaSums;
  }
  
  
  
  

  //normalizes the data
  float[] normAreas(float[] input) {
    //float[][] output = new float[HEIGHT][WIDTH];
    float mass = 0;
    for (int i = 0; i < input.length; ++i) {
      mass += input[i];
    }
    float[] output = multMat(input, 1.0/mass);
    return output;
  }
  
  
  

  float[] averageData(float[] dataNew) { //dataNew is array of summed pressures from sensing areas on the mat and n is the number of time steps to average over

    for (int i = 0; i < N-1; ++i) {
      dataRecord[i] = dataRecord[i+1]; //delete oldest data, shift to make room for new data
    }
    dataRecord[N-1] = dataNew; //add new data

    float[] dataOut = new float[dataNew.length];

    for (int i = 0; i < N; ++i) {
      for (int j = 0; j < dataNew.length; ++j) {
        dataOut[j] += dataRecord[i][j]; //painstakingly with java code sum a 2d array of historical data
      }
    }

    return multMat(dataOut, 1.0/N); //normalize (i.e. find average) of historical data
  }
  
  
}

