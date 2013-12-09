class WorkoutData{
  public String poseName;
  public int percentTimeCorrect;
  
  WorkoutData(int poseNumber, int percentTimeCorrect){
    poseName = Poses.POSE_NAMES[poseNumber-1];
    this. percentTimeCorrect = percentTimeCorrect;
  }
}

class WorkoutManager {

  MatController matControl;
  private ArrayList<WorkoutData> workoutLog;
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
  boolean donePressureSensing = false;
  boolean hasTransitioned = false;
  boolean doneWithPose = false;
 


  int WORKOUT_LIST[] = {
    1, 2, 4, 3, 5, 7, 6
  }; //workout sequence: mountain, halfmoon, warrior2, warrior1, triangle, forwardbend, downwarddog
  int workoutPoseNumber = 0; //keeps track of location within workout list
  

   WorkoutManager(PApplet papplet) { 
    setHeightBin(profileManager.getCurrentProfileHeight());
    pose = new Pose();
    pose.loadPoseData(poseNumber, heightBinNo); //load data for pose #1
    matControl = new MatController(papplet, pose);
    workoutLog = new ArrayList<WorkoutData>();
    
    

    //time in milliseconds
    lastTime = 0;
    currentTime = 0;

    //initializing timing variables
    pauseStartTime = 0;
    timeToStartPause = 0;
    startPoseTransitionTime = 0;
    endPoseTransitionTime = 0;
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {
    println("WorkoutManager:: starting pose " + poseNumber);
    this.poseNumber = poseNumber;

    // load in relevant timing data for mat instruction from pose data file
    pose.loadPoseData(poseNumber, heightBinNo);
    
    float[] poseTimes = pose.getTimes();
    timeToStartPause = (int)poseTimes[0];
    startPoseTransitionTime = (int)poseTimes[1];
    endPoseTransitionTime = (int)poseTimes[2];

    //switch to basic starting position for the start of each pose
    initialPoseTransition();

    pauseStartTime = System.currentTimeMillis(); //this will be updated when pause actually begins
    donePressureSensing = false;
    doneWithPose = false;
    hasTransitioned = false;
  }

  void advancePose() { //call to advance to the next pose in a set workout
    if ( workoutPoseNumber >= WORKOUT_LIST.length - 1) {
      stopPose();
      //TODO figure out whether we need to say to go back to home screen here
      return;
    }
    workoutPoseNumber++;
    newPose( WORKOUT_LIST[workoutPoseNumber]); // update the pose
  }

  //used to transition from mountain pose to desired pose
  void startPoseTransition() {
    pose.loadPoseData(poseNumber, heightBinNo);
    println("WorkoutManager:: startPoseTransition -- poseEvent");
    matControl.poseEvent();
  }

  //used to reset to initial position
  void initialPoseTransition() {
    println("WorkoutManager::initialPoseTransition()");
    // forward bend and downward dog have a different starting position than the other poses
    
    if(poseNumber == 3 || poseNumber == 4 || poseNumber == 5){
      pose.loadPoseData(30, heightBinNo);
    }
    
    else if(poseNumber == 6){
      pose.loadPoseData(60, heightBinNo);
    }
    
    else if(poseNumber == 7){
      pose.loadPoseData(70, heightBinNo);
    }
    
    else{
      pose.loadPoseData(1, heightBinNo);
    }
    
    //update lights
    println("WorkoutManager:: initialPoseTransition -- poseEvent");
    matControl.poseEvent();
  }


  void stopPose() {
    poseNumber = 100;
    matControl.stopPose();
  }

  void startWorkout() {
    // reset array of pose data
  }

  ArrayList<WorkoutData> getWorkoutInfo() {
    return workoutLog;
  }
  
  void endWorkout(){
    workoutPoseNumber = 0;
    workoutLog = new ArrayList<WorkoutData>(); // clear the workout log
    stopPose();
  }

  void draw() {
    matControl.loadData();
    currentTime = System.currentTimeMillis();

    if (! GlobalPApplet.videoElement.isInit()) {
      stopPose();
      return;
    }

    if (GlobalPApplet.videoElement.isDone()) {
      stopPose();
      //GlobalPApplet.videoElement.destroy();
      
    }

    //println("I play:" + GlobalPApplet.videoElement.getIsPlaying());

    //if the video is playing...  
    if ( GlobalPApplet.videoElement.getIsPlaying()) {
      float videoTime  = GlobalPApplet.videoElement.getTime();
      
      //...and we haven't pressure sensed...
      if (!donePressureSensing) {
        
        //...and it's time to pressure sense, then pressure sense!
        if ( videoTime > timeToStartPause ) {
          GlobalPApplet.videoElement.pause();
          pauseStartTime = currentTime; //to keep track of when the movie paused
          //println("I'm pausing the video now");
        }

        //... and it's time to transition, then transition to desired pose in time with the video
        else if ( videoTime > startPoseTransitionTime && !hasTransitioned) {
          hasTransitioned = true;
          startPoseTransition();
        }
      }

      //if done pressure sensing, see if need to transition back to mountain pose in time with the video
      else if ( videoTime > endPoseTransitionTime && !doneWithPose) {
        initialPoseTransition();
        doneWithPose = true;
      }

      //pause video if we've reached the pause time
    }

    //if the video is paused and we haven't finished pressure sensing
    if (!GlobalPApplet.videoElement.getIsPlaying() && !donePressureSensing) {
      
      //TODO add in logic for user pausing the video
      
      //give pressure feedback if we haven't reached the end of the pause yet
      if (currentTime - pauseStartTime < LENGTH_OF_PAUSE ) {
        matControl.processBalanceData();
        println("I'm pressure sensing now");
      }

      //if the movie has been paused for a certain amount of time, resume playing
      else if ( !GlobalPApplet.videoElement.getIsPlaying() && (currentTime - pauseStartTime >= LENGTH_OF_PAUSE )) {
        donePressureSensing = true;
        
        //record pressure data from this pose (pose 100 is not a real pose; just turns off lights)
        if(poseNumber!=100){
          println("getting workout data");
          int percentTimeCorrect = matControl.getPercentTimeCorrect();
          workoutLog.add(new WorkoutData(poseNumber, percentTimeCorrect));
        }
        
        //startPoseTransition();  //turn all leds back to default purple color
        GlobalPApplet.videoElement.play();
        println("I'm resuming the video now");
      }
    }

    //TODO when video is done playing, what happens? (need pressure feedback, etc.)
    //TODO pressure buttons!

    else {
      //allow video to continue playing if it hasn't reached the pause time yet
    }
  }
}

