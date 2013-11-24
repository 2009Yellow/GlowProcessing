class WorkoutManager {
  MatController matControl;
  
  long POSETIMEOUT = 20000; //20 second timeout? this can be changed

  int heightBinNo = 2;
  int poseNumber = 0;//don't light up anything
  Pose pose;
  long lastTime;
  long currentTime;
  long poseStartTime;

  WorkoutManager(PApplet papplet) { 
    pose = new Pose();
    pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
    matControl = new MatController(papplet, pose);
    setHeightBin(profileManager.currentProfile.profileHeight);

    //time in milliseconds
    lastTime = 0;
    currentTime = 0;
    poseStartTime = 0;
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {
    this.poseNumber = poseNumber;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    poseStartTime = System.currentTimeMillis();
  }

  void advancePose() {
    poseNumber = (poseNumber+1) % 7;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    poseStartTime = System.currentTimeMillis();
  }

  void getWeight() {
    pose.loadPoseData(0, heightBinNo);
    matControl.getWeight();
  }
  
  void stopPose() {
    matControl.stopPose();
  }
  
  void draw() {

    currentTime = System.currentTimeMillis();

    if (currentTime - lastTime > 200) { //update pressure data every 0.25 seconds
      lastTime = currentTime;
      matControl.loadAndProcessData();
    }
    
    /*if (currentTime - poseStartTime > POSETIMEOUT) {
      stopPose();
    }*/
  }
}

