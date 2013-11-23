import processing.serial.*;


Balance balance;
Serial myPort;
MatController matControl;
Helpers help;

int heightBinNo = 2;
int poseNumber = 1;
Pose pose;
long lastTime;
long currentTime;

int numLoops = 0;

void setup() { 
  pose = new Pose();
  help = new Helpers();
  pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
  matControl = new MatController(this, pose);
 

  //time in milliseconds
  lastTime = 0;
  currentTime = 0;
}

/*void setHeightBin(int heightBinNo){
  this.heightBinNo = heightbinNo;
}

void newPose(int poseNumber){
  this.poseNumber = poseNumber;
  pose.loadPoseData(poseNumber, heightBinNo);
  matControl.poseEvent();
}

void advancePose(){
  poseNumber = (poseNumber+1) % 6;
  pose.loadPoseData(poseNumber);
  matControl.poseEvent();
}*/



void draw() {
  
  matControl.loadAndProcessData();
  /*
  if(numLoops == 10){
    pose.loadPoseData(0, heightBinNo);
    matControl.getWeight();
    numLoops ++;
  }
  
  if(numLoops == 11){
    pose.loadPoseData(3, heightBinNo);
    matControl.poseEvent();
    numLoops ++;
  }*/
  

  //  checkUI();
  // if UI says it's time for a new pose;
  //matControl.poseEvent(int pose);


  //  pose.loadPoseData(poseNumber);
  //  LEDFB();
  //  AudioFB();
  //  UIFB();
}

