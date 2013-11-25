class WorkoutManager {

  MatController matControl;
  long POSETIMEOUT = 20000; //20 second timeout? this can be changed
  long LENGTH_OF_PAUSE = 10000; //length of pause and pressure feedback (in milliseconds)

  int heightBinNo = 2;//aribtrarily set for now
  int poseNumber = 0;//don't light up anything
  
  
  Pose pose;
  long lastTime;
  long currentTime;
  long pauseStartTime;
  boolean isMoviePlaying;


  WorkoutManager(PApplet papplet) { 
    pose = new Pose();
    pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
    matControl = new MatController(papplet, pose);
    setHeightBin(profileManager.currentProfile.profileHeight);

    //time in milliseconds
    lastTime = 0;
    currentTime = 0;
    pauseStartTime = 0;
    isMoviePlaying = false;
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {
    this.poseNumber = poseNumber;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    pauseStartTime = System.currentTimeMillis();
    
    isMoviePlaying = true;
    
  }

  void advancePose() {
    poseNumber = (poseNumber+1) % 7;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    pauseStartTime = System.currentTimeMillis();
    isMoviePlaying = true;
  }

  void getWeight() {
    pose.loadPoseData(0, heightBinNo);
    matControl.getWeight();
  }

  void stopPose() {
    matControl.stopPose();
  }



  void draw() {
  
    matControl.loadData();
    currentTime = System.currentTimeMillis();
    
    if(GlobalPApplet.videoElement == null){return;}
    
    //allow video to continue playing if it hasn't reached the pause time yet
    if ( isMoviePlaying && GlobalPApplet.videoElement.getTime() > pose.getTimes() ){
      println("pause time " + pose.getTimes());
      GlobalPApplet.videoElement.pause();
      isMoviePlaying = false;
      pauseStartTime = currentTime;
    }
    
    //if the movie is paused, give pressure feedback
    else if( !isMoviePlaying && (currentTime - pauseStartTime < LENGTH_OF_PAUSE )){
      matControl.processBalanceData();
    }
    
    //if the movie has been paused for a certain amount of time, resume playing
    else if( !isMoviePlaying && (currentTime - pauseStartTime >= LENGTH_OF_PAUSE )){
        GlobalPApplet.videoElement.play();
    }
    
  }
}

