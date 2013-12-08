static class Poses {

  final static String[] POSE_NAMES = {
    "Mountain", 

    "Half Moon", 

    "Warrior 2", 

    "Warrior 1", 

    "Triangle", 

    "Standing Bend", 

    "Downward Dog.mov"
  };

};

class Pose { //will return the reference (i.e. correct, based on yoga expert) LED positions for limb placement, pressure sensing areas, and normalized reference pressure

  float[][] allPoseData; // contains all of the data in the Pose#Data.txt file
  int PRESSUREROW = 2; // row in the .csv file that contains reference pressures for each area
  int LEDROW = 1; // row in the .csv file that contains LEDs associated with each area
  int ONMATROW = 0;
  int heightBin;

  Pose() {
  }

  void loadPoseData(int poseNumber, int heightBin) { //call this once when a new pose begins to load in all of the new pose refernce data. pose = the number of the new pose
    this.heightBin = heightBin;
    String fileName = "Pose"+poseNumber+"Data.csv"; // sets the pose data file for poseNumber
    String lines[] = loadStrings(fileName); //loads data from .csv as strings
    int csvWidth=0; //intialize the width of the data matrix

    for (int i=0; i < lines.length; i++) { //splits up data based on comma delimting
      String [] chars=split(lines[i], ',');
      if (chars.length>csvWidth) {
        csvWidth=chars.length;
      }
    }

    allPoseData = new float [lines.length][csvWidth]; //intializes allPoseData with final size
    for (int i=0; i < lines.length; i++) {
      String [] temp = new String [lines.length];
      temp= split(lines[i], ',');
      for (int j=0; j < temp.length; j++) {  
        allPoseData[i][j]=float(temp[j]); //populates allPoseData with sata from .csv
      }
    }
  }
  
  void stopPose() {
    loadPoseData(100, 1); //posenumber 100 is a blank csv file
  }

  float[] onPressureMat() {
    float[] onMat = allPoseData[ONMATROW+heightBin*7];
    return onMat;
  }

  float[][] getAreas() { //returns columns formated as: [i1 j1 i2 j2] where i1 & j1 define two corners of a rectangle on the mat encompassing a pressure sensing area relevant to the pose 
    float[][] areaData = {
      allPoseData[3+heightBin*7], allPoseData[4+heightBin*7], allPoseData[5+heightBin*7], allPoseData[6+heightBin*7]
    };
    return areaData;
  }


  float[] getPressures() { //returns an array where element n is the normalized reference pressure for sensing area n
    float[] pressure = allPoseData[PRESSUREROW+heightBin*7];
    return pressure;
  }


  float[] getLeds() { // returns an array where element n is the the LED number that is associated with the sensing area n
    float[] leds = allPoseData[LEDROW+heightBin*7];
    return leds;
  }
  
    int getTimes() {
    //array of times for video to pause
    float[] times = allPoseData[29];
    //currently, only the first value in this array is relevant
    return (int)times[0];   
  }
  
  float[] getDirections() {
   float[] direction = allPoseData[28];
   return direction;
  }
  
  
}

