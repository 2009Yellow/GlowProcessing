import papaya.*;

int HEIGHT = 2; //number of rows of sensors in the mat
int WIDTH = 1; // number of coumns of sensors in the mat
float[][] ref = {{0.5},{0.5}};
float[][] matData = new float[HEIGHT][WIDTH];
float[][] diff = new float[HEIGHT][WIDTH];

int[][] poseArea = {{0,0,0,0},{1,0,1,0}};



void setup() {
   matData = getData();
}

void draw() {
  diff = getDiff(ref,matData);
  feedback(diff);
}

void feedback(float input[][]) {
  if (input[0][0]<0) {
    println("put less weight on left");
  }
  if (input[1][0] <0) {
    println("put less weight on right");
  }
}



float[][] getDiff(float[][] input1, float[][] input2) {
    float[][] output = new float[HEIGHT][WIDTH];
    for (int i = 0; i < HEIGHT; ++i) {
    for (int j = 0; j < WIDTH; ++j) {
        output[i][j] = input1[i][j]-input2[i][j];
      }
    }
    return output;
}

float[][] multMat(float[][] input, float factor) {
    float[][] output = new float[HEIGHT][WIDTH];
    for (int i = 0; i < HEIGHT; ++i) {
    for (int j = 0; j < WIDTH; ++j) {
        output[i][j] = input[i][j]*factor;
      }
    }
    return output;
}

float[][] normMat(float[][] input) {
    //float[][] output = new float[HEIGHT][WIDTH];
    float mass = 0;
    for (int i = 0; i < HEIGHT; ++i) {
    for (int j = 0; j < WIDTH; ++j) {
        mass = mass+input[i][j];
      }
    }
    float [][] output = multMat(input,1/mass);
    return output;
}

float[][] getData() {
  float[][] newData = {{3}, {2}}; //get data from erin's code
    newData = sumAreas(normMat(newData));
    
    
  return newData;
  
}

float[][] sumAreas(float [][] input){
  float[][] output = new float[2][1];
    for (int i = poseArea[0][0]; i <= poseArea[0][2]; ++i) {
    for (int j = poseArea[0][1]; j <= poseArea[0][3]; ++j) {
        output[0][0] = output[0][0]+input[i][j];
      }
    }
  
    for (int i = poseArea[1][0]; i <= poseArea[1][2]; ++i) {
    for (int j = poseArea[1][0]; j <= poseArea[1][3]; ++j) {
      println(i);
        output[1][0] = output[1][0]+input[i][j];
      }
    }
  
  return output;
  
}


