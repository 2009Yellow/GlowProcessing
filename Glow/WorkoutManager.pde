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
  int timeToStartPause;
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
    pauseStartTime = 0;
    timeToStartPause = pose.getTimes();
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {
    this.poseNumber = poseNumber;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    pauseStartTime = System.currentTimeMillis();
    timeToStartPause = pose.getTimes();
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
    // give list of workout data
  }
  
  void draw() {
    matControl.loadData();
    currentTime = System.currentTimeMillis();
    
    if(GlobalPApplet.videoElement == null) {
      return;
    }
    
    println("I play:" + GlobalPApplet.videoElement.getIsPlaying());
    
    
    
    //pause the video if we haven't pressure sensed yet and we've passed the pause time 
    if ( GlobalPApplet.videoElement.getIsPlaying() && !donePressureSensing && GlobalPApplet.videoElement.getTime() > timeToStartPause ){
      println("pause time " + pose.getTimes());
      GlobalPApplet.videoElement.pause();
      pauseStartTime = currentTime; //to keep track of when the movie paused
      println("I'm pausing the video now");
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

