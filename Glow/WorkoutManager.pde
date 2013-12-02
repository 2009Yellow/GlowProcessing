class WorkoutManager {

  MatController matControl;
  long POSETIMEOUT = 20000; //20 second timeout? this can be changed
  long LENGTH_OF_PAUSE = 10000; //length of pause and pressure feedback (in milliseconds)

  int heightBinNo = 2;//aribtrarily set for now
  int poseNumber = 100;//don't light up anything
  
  
  Pose pose;
  long lastTime;
  long currentTime;
  long pauseStartTime;
  
  
  int WORKOUT_LIST[][] = {{1, 2, 3, 4, 5},{1, 2, 3, 2, 1},{1, 3, 4, 2, 1}}; //rows are sequences of poses to form a single workout sequence
  int workout = 0; // the workout that we want to use, in the future this will be set by a UI callback
  int workoutPoseNumber = 0;

  WorkoutManager(PApplet papplet) { 
    pose = new Pose();
    pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
    matControl = new MatController(papplet, pose);
    setHeightBin(profileManager.getCurrentProfileHeight());

    //time in milliseconds
    lastTime = 0;
    currentTime = 0;
    pauseStartTime = 0;
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {
    this.poseNumber = poseNumber;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    pauseStartTime = System.currentTimeMillis();
    
  }

  void advancePose() { //call to advance to the next pose in a set workout
    workoutPoseNumber = (workoutPoseNumber+1) % 4; //todo this mod should be repalced with an if statement that takes you back to the workout selection menu when the workout is complete and call stopPose
    poseNumber = WORKOUT_LIST[workout][workoutPoseNumber]; //pulls pose from list of workouts
    pose.loadPoseData(poseNumber, heightBinNo); //loads new pose data
    matControl.poseEvent(); //updates a number of things
    pauseStartTime = System.currentTimeMillis(); //starts timer to track when to pause in video for pressure feedback
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
    if ( GlobalPApplet.videoElement.getIsPlaying() && GlobalPApplet.videoElement.getTime() > pose.getTimes() ){
      println("pause time " + pose.getTimes());
      GlobalPApplet.videoElement.pause();
      pauseStartTime = currentTime; //to keep track of when the movie paused
    }
    
    //if the movie is paused, give pressure feedback
    else if( !GlobalPApplet.videoElement.getIsPlaying() && (currentTime - pauseStartTime < LENGTH_OF_PAUSE )){
      matControl.processBalanceData();
    }
    
    //if the movie has been paused for a certain amount of time, resume playing
    else if( !GlobalPApplet.videoElement.getIsPlaying() && (currentTime - pauseStartTime >= LENGTH_OF_PAUSE )){
        GlobalPApplet.videoElement.play();
    }
    
  }
}

