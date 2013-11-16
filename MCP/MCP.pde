import processing.serial.*;


Balance balance;
Serial myPort;
MatController matControl;

int heightBinNo = 2;
int poseNumber = 2;
Pose pose;
long lastTime;
long currentTime;

void setup() { 
  pose = new Pose();
  pose.loadPoseData(2, heightBinNo); //load data for pose #1
  matControl = new MatController(this, pose);

  //time in milliseconds
  lastTime = 0;
  currentTime = 0;
}

void draw() {

  currentTime = System.currentTimeMillis();
  /*if( UI tells us to get the user's weight){
    pose.loadPoseData(1, heightBinNo);
    //delay to let user get on mat or something
    matControl.getWeight();
  }*/
  if (currentTime - lastTime >= 250) { //update pressure date every 0.25 seconds
    lastTime = currentTime;
    matControl.loadAndProcessData();
  }

  //  checkUI();
  // if UI says it's time for a new pose;
  //matControl.poseEvent(int pose);


  // pose.loadPoseData(poseNumber);
  //  LEDFB();
  //  AudioFB();
  //  UIFB();
}

