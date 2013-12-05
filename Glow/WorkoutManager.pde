class WorkoutManager {

  MatController matControl;
  long POSETIMEOUT = 20000; //20 second timeout? this can be changed
  long LENGTH_OF_PAUSE = 10000; //length of pause and pressure feedback (in milliseconds)

  int heightBinNo = 2;//aribtrarily set for now
  
  long lastTime;
  long currentTime;
  long pauseStartTime;
  
  
  //pose-specific info
  Pose pose;
  int timeToStartPause;
  int startPoseTransitionTime;
  int endPoseTransitionTime;
  int poseNumber = 100; //don't light up anything
  
  //have we finished pressure sensing?
  boolean donePressureSensing;
  
  
  int WORKOUT_LIST[] = {1, 2, 4, 3, 5, 7, 6}; //workout sequence: mountain, halfmoon, warrior2, warrior1, triangle, forwardbend, downwarddog
  int workoutPoseNumber = 0;

  WorkoutManager(PApplet papplet) { 
    pose = new Pose();
    pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
    matControl = new MatController(papplet, pose);
    setHeightBin(profileManager.getCurrentProfileHeight());

    //time in milliseconds
    lastTime = 0;
    currentTime = 0;
    
    //arbitrarily initializing variables
    pauseStartTime = 0;
    timeToStartPause = 0;
    startPoseTransitionTime = 0;
    endPoseTransitionTime = 0;
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {
    this.poseNumber = poseNumber;
    
    // load in relevant data for mat instruction from pose data file
    pose.loadPoseData(poseNumber, heightBinNo);
    float[] poseTimes = pose.getTimes();
    timeToStartPause = (int)poseTimes[0];
    startPoseTransitionTime = (int)poseTimes[1];
    endPoseTransitionTime = (int)poseTimes[2];
    
    //switch to mountain pose for the start of each pose
    mountainPoseTransition();
    
    pauseStartTime = System.currentTimeMillis(); //this will be updated when pause actually begins
    donePressureSensing = false;
  }

  void advancePose() { //call to advance to the next pose in a set workout
    if ( workoutPoseNumber >= WORKOUT_LIST.length - 1){
      stopPose();
      //TODO figure out whether we need to say to go back to home screen here
      return;
    }
    workoutPoseNumber++;
    newPose( WORKOUT_LIST[workoutPoseNumber]); // update the pose
  }
  
  //used to transition from mountain pose to desired pose
  void startPoseTransition(){
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
  }
  
  //used to reset to mountain pose
  void mountainPoseTransition(){
    pose.loadPoseData(1, heightBinNo);
    matControl.poseEvent();
  }

  void getWeight() {
    pose.loadPoseData(0, heightBinNo);
    matControl.getWeight();
  }

  void stopPose() {
    poseNumber = 100;
    matControl.stopPose();
  }

  void startWorkout(){
    // reset array of pose data
  }

  void getWorkoutInfo(){
    // return list of workout data
  }
  
  void draw() {
    matControl.loadData();
    currentTime = System.currentTimeMillis();
    
    if(GlobalPApplet.videoElement == null) {
      return;
    }
    
    println("I play:" + GlobalPApplet.videoElement.getIsPlaying());
    
    
    
    //if the video is playing...  and we haven't pressure sensed yet 
    if ( GlobalPApplet.videoElement.getIsPlaying() && !donePressureSensing){
      float videoTime  = GlobalPApplet.videoElement.getTime();
      
      /*//transition back to mountain pose in time with the video
      if ( videoTime > endPoseTransitionTime){
        mountainPoseTransition();
      }*/
      
      //pause video if we've reached the pause time
      if( videoTime > timeToStartPause ){
         println("pause time " + pose.getTimes());
        GlobalPApplet.videoElement.pause();
        pauseStartTime = currentTime; //to keep track of when the movie paused
        println("I'm pausing the video now");
      }
      
      //transition to desired pose in time with the video
      else if ( videoTime > startPoseTransitionTime){
        startPoseTransition();
      }
    }
    
    //if the movie is paused, give pressure feedback
    else if( !GlobalPApplet.videoElement.getIsPlaying() && (currentTime - pauseStartTime < LENGTH_OF_PAUSE )){
      matControl.processBalanceData();
      println("I'm pressure sensing now");
    }
    
    //if the movie has been paused for a certain amount of time, resume playing
    else if( !GlobalPApplet.videoElement.getIsPlaying() && (currentTime - pauseStartTime >= LENGTH_OF_PAUSE )){
        GlobalPApplet.videoElement.play();
        donePressureSensing = true;
        println("I'm resuming the video now");
        stopPose();
    } 
    
    //TODO when video is done playing, what happens? (need pressure feedback, etc.)
    //TODO pressure buttons!
    
    else {
      //allow video to continue playing if it hasn't reached the pause time yet
    }
    
  }
}

