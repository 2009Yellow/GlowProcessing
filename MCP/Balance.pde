import processing.serial.*;

class Balance {

  Pressure pressure;
  Pose pose;

  //MatGraphics matGraphics; //for testing purposes

  float[] stanDist;


  Balance(int mat_h, int mat_w, MatIn matIn, Pose pose) {

    //matGraphics = new matGraphics(mat_h, mat_w);

    pressure = new Pressure(mat_h, mat_w, matIn, pose);
    this.pose = pose;
    stanDist = pose.getPressures();
  }
  
  void getWeight(){
    this.poseEvent();      //basically just to reset pressure
    pressure.getWeight();
  }
  
  
  //called whenever the pose changes
  void poseEvent() {
    //update pressure distribution
    stanDist = pose.getPressures(); //the global Pose instance has already been updated
    pressure.updateRecord();
    pressure.updateAreas();
  }

  //returns a vector of binary pressure differences
  //-1.0 if pressure in an area is too little
  //1.0 if too much pressure in an area
  //0.0 if the pressure is as expected
  float[] getBinaryFeedback() {
    float[] diff = getDiff();
    float binary[] = new float[diff.length];

    for (int i = 0; i<diff.length; i++) {
      //arbitrary tolerance value
      if (abs(diff[i]) > 0.04) { 
        binary[i] = abs(diff[i])/diff[i];
      }
    }
    println(binary);
    return binary;
  }

  //gets difference between expected and current (normalized) pressure distributions
  float[] getDiff() {
    //get current normalized pressure distribution
    float[] currentPressure = pressure.getNormPressDist(); 

    //compare terms in normalized pressure distribution with expected distribution
    float[] differences = new float[currentPressure.length];
    for (int i = 0; i < differences.length; ++i) {
      differences[i] = currentPressure[i]-stanDist[i];
    }
    return differences;
  }

  /*
int matchFeedback(float[] MatOut, float[][] options) {
   //println(MatOut);
   int output = 1;
   for (int i = 0 ; i < options.length; i++) {
   float[] temp = options[i];
   //println(temp);
   boolean isequal = true;
   for (int j = 0 ; j < temp.length; j++) {
   if(temp[j] != MatOut[j]) {
   isequal = false;
   
   }
   }
   if(isequal){
   output = i;
   }
   }
   //println(output);
   return output;
   }*/
}

