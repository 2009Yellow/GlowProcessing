


float[] averageData(float[] dataNew,int n) { //dataNew is array form of rawData from the mat, not in a matrix yet, and n is the number of time steps to average over
  float[][] dataRecord = new float[n][dataNew.length];
  
    for (int i = 0; i < n-1; ++i) {
      dataRecord[i] = dataRecord[i+1];
    }
  dataRecord[n] = dataNew;
  
  float[] dataOut = new float[dataNew.length];
    
    for (int i = 0; i < n; ++i) {
      for(int j = 0; j < dataNew.length; ++j){
      dataOut[j] = +dataRecord[i][j];
      }
    }
  return multMat(dataOut,1/n);
}
