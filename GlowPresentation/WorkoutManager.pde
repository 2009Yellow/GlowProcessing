class WorkoutData {
  public String poseName;
  public int percentTimeCorrect;

  WorkoutData(int poseNumber, int percentTimeCorrect) {
    poseName = Poses.POSE_NAMES[poseNumber-1];
    this. percentTimeCorrect = percentTimeCorrect;
  }
}

class WorkoutManager {

  MatController matControl;
  long LENGTH_OF_PAUSE = 10000; //length of pause and pressure feedback (in milliseconds)

  int heightBinNo = 2;//aribtrarily set for now

  long lastTime;
  long currentTime;
  long pauseStartTime;


  //pose-specific info
  Pose pose;
  int timeToStartPause;

  int poseNumber = 100; //don't light up anything

  //have we finished pressure sensing?
  boolean donePressureSensing = false;

  WorkoutManager(PApplet papplet) { 
    setHeightBin(1);
    pose = new Pose();
    pose.loadPoseData(poseNumber, heightBinNo); //pose 100 keeps everything off
    matControl = new MatController(papplet, pose);
  }

  void setHeightBin(int heightBinNo) {
    this.heightBinNo = heightBinNo;
  }

  void newPose(int poseNumber) {

    this.poseNumber = poseNumber;
    pose.loadPoseData(poseNumber, heightBinNo);
    matControl.poseEvent();
    donePressureSensing = false;
  }
  
  void startupSequence(){
    matControl.startupSequence();
  }

  void stopPose() {
    poseNumber = 100;
    matControl.stopPose();
  }

  void draw() {
    matControl.loadData();
    currentTime = System.currentTimeMillis();

    matControl.processBalanceData();
  }
}

