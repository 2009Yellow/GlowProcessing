import processing.serial.*;


Balance balance;
Serial myPort;
MatController matControl;
//LED led;

int poseNumber = 2;
Pose pose;

void setup() { 
  pose = new Pose();
  pose.loadPoseData(1); //load data for pose #1
  matControl = new MatController(this, pose);
}

void draw() {
  
//  checkUI();
// if UI says it's time for a new pose;
//matControl.poseEvent(int pose);

// if it has been 0.2 seconds since the last time we did this...
// pose.loadPoseData(poseNumber);
   matControl.loadAndProcessData();
//  LEDFB();
//  AudioFB();
//  UIFB();
}


