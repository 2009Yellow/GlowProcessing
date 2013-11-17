import processing.serial.*;


Balance balance;
Serial myPort;
MatController matControl;

int heightBinNo = 2;
int poseNumber = 1;
Pose pose;
long lastTime;
long currentTime;

int numLoops = 0;

void setup() { 
  pose = new Pose();
  pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
  matControl = new MatController(this, pose);

  //time in milliseconds
  lastTime = 0;
  currentTime = 0;
}

void draw() {

  currentTime = System.currentTimeMillis();
  /*if( UI tells us to get the user's weight){
    pose.loadPoseData(0, heightBinNo);
    //delay to let user get on mat or something
    matControl.getWeight();
  }*/
  if (numLoops==0){
    pose.loadPoseData(1, heightBinNo);
    matControl.poseEvent();
    numLoops++;
  }
  
  if (currentTime - lastTime > 250) { //update pressure data every 0.25 seconds
    lastTime = currentTime;
    matControl.loadAndProcessData();
    numLoops++;
  }
  
  if(numLoops == 10){
    pose.loadPoseData(0, heightBinNo);
    matControl.getWeight();
    numLoops ++;
  }
  
  if(numLoops == 11){
    pose.loadPoseData(3, heightBinNo);
    matControl.poseEvent();
    numLoops ++;
  }
  

  //  checkUI();
  // if UI says it's time for a new pose;
  //matControl.poseEvent(int pose);


  //  pose.loadPoseData(poseNumber);
  //  LEDFB();
  //  AudioFB();
  //  UIFB();
}

