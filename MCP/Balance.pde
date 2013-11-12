class Balance{ // Analyzes
  
int HEIGHT; //number of rows of sensors in the mat
int WIDTH; // number of coumns of sensors in the mat
MatGraphics graphics;
float[][] rawPres; // Raw pressure values from mat (data from all sense points)
float[] normalized; // rawPres normalized with total pressure
float[] diff; // after the normalized pressure values have been sumed for each matArea, diff is the difference between these values and the ref values


float[]ref; // will be set to the normalized pressures for each matArea
int[][] poseAreas = {{0,0,0,0},{0,1,0,1}};  // Row defined two points that define rectangles on the mat, in which the hands/feet are placed. 
                                            //This will eventually be part of a .txt file containing all nessecary info about a given pose

Balance(int HEIGHT, int WIDTH) { 
   this.HEIGHT = HEIGHT;
   this.WIDTH = WIDTH;
   rawPres = new float[HEIGHT][WIDTH];
   normalized = new float[poseAreas.length];
   graphics = new MatGraphics(HEIGHT, WIDTH);
}


void setRef(float[] ref){
  this.ref = ref;
}

void setAreas(int[][] poseAreas){
  this.poseAreas = poseAreas;
}

float[] analyzeBalance(float[][] data){
  rawPres = data;
  int[] areaSums = sumAreas(poseAreas);
  normalized = normAreas(areaSums);
  diff = getDiff(ref, normalized);
  graphics.drawDisplay(rawPres, diff);
  return makeBinary(diff);
}

float[] makeBinary(float[] diff){
  float binary[] = new float[diff.length];
  
  for (int i = 0; i<diff.length; i++){
    if(abs(diff[i]) > 0.05){
      binary[i] = abs(diff[i])/diff[i];
    }   
  }
  
  return binary;
}


float [] getDiff(){
  return diff;
}

//dimensions of input1 and input2 must be the same
float[] getDiff(float[]ref, float[]data) {
    float[] output = new float[ref.length];
    for (int i = 0; i < ref.length; ++i) {
        output[i] = data[i]-ref[i];
     }
    return output;
}

float[] multMat(int[] input, float factor) {
    float[]output = new float[input.length];
    for (int i = 0; i < input.length; ++i) {
        output[i] = input[i]*factor;
      }
    return output;
}

//receives poseAreas (each row contains data about one point of contact with mat)
int[] sumAreas(int [][] poseAreas){
  int[] areaSums = new int[poseAreas.length];
  
  //loop through the different contact areas listed defined by poseAreas
  for (int areaNum = 0; areaNum < poseAreas.length; areaNum++)
  {
    int sum = 0;
    for (int i = poseAreas[areaNum][0]; i <= poseAreas[areaNum][2]; ++i) {
      for (int j = poseAreas[areaNum][1]; j <= poseAreas[areaNum][3]; ++j) {
        sum+=rawPres[i][j];
      }
    }
    
    areaSums[areaNum] = sum;
  }
  
  return areaSums;
  
}

//normalizes the data
float[] normAreas(int[] input) {
    //float[][] output = new float[HEIGHT][WIDTH];
    float mass = 0;
    for (int i = 0; i < input.length; ++i) {
        mass += input[i];
    }
    float[] output = multMat(input,1/mass);
    return output;
}

}
