import processing.serial.*;

class Balance {

  Pressure pressure;
  Pose pose;

  //MatGraphics matGraphics; //for testing purposes

  float[] stanDist;
  float threshold;


  Balance(int mat_h, int mat_w, MatIn matIn, Pose pose) {

    //matGraphics = new matGraphics(mat_h, mat_w);

    pressure = new Pressure(mat_h, mat_w, matIn, pose);
    this.pose = pose;
    stanDist = pose.getPressures();
    setThreshold();
  }
  
  
  
  //called whenever the pose changes
  void poseEvent() {
    //update pressure distribution
    stanDist = pose.getPressures(); //the global Pose instance has already been updated
    pressure.updateAreas();
    setThreshold();
  }
  
  void setThreshold(){
    if ( stanDist.length == 4){
      threshold = 0.03;
    }
    
    else{
      threshold = 0.1;
    }
  }

  //returns a vector of binary pressure differences
  //-1.0 if pressure in an area is too little
  //1.0 if too much pressure in an area
  //0.0 if the pressure is as expected
  float[] getBinaryFeedback() {
    
    float[] diff = getDiff();
    float binary[] = new float[diff.length];
    
    //method that tells whether or not a significant amount of weight is on the mat
    if(!pressure.isWeightSignificant()){
      println("weight is not significant");
      for(int i = 0; i<binary.length; i++){
        binary[i] = -1;
      }
      return binary;
    }
   

    for (int i = 0; i<diff.length; i++) {
      //arbitrary tolerance value
      if (abs(diff[i]) > threshold ){ 
        binary[i] = abs(diff[i])/diff[i];
      }
    }
    //println(binary);
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
    println("differences");
    println(differences);
    return differences;
  }

}

