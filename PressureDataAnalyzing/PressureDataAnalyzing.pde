import java.lang.System;

//import processing.serial.*;

// Display Constants
final int SQUARE_SIZE = 70;
final int HEIGHT = 10;
final int WIDTH = 12;
final int TEXT_SIZE = 35;

// Serial Communcation Constants
final int SERIAL_START_CHAR = 'A';
final int FIRST_SERIAL_RECEIVE_CHAR = 'B';
final int FINAL_SERIAL_RECEIVE_CHAR = 10;  // LIinefeed in ASCII

// Member variables
//Serial myPort;                       
int[] serialInArray = new int[HEIGHT * WIDTH];  // Input bytes from the serial
int[] displayColors = new int[HEIGHT * WIDTH];  // Values for running display

PFont myFont;

//for centroid-finding
int[] testData;
float[] centroid; 
float[] centUp;
float[] centDown;
float[] centLeft;
float[] centRight;
// for determination of pressure distribution accuracy
float ratioAboveToBelow;
float ratioLeftToRight;


void setup() {
  // Init display
  size(SQUARE_SIZE * WIDTH, SQUARE_SIZE * HEIGHT);  // Stage size
  
  // Drawing setup
  rectMode(CORNER);
  for (int i = 0;i < displayColors.length; ++i) {
    displayColors[i] = int(random(255));
  }
  
  frameRate(4);
  
  // Font setup
  myFont = createFont("Georgia", 72);
  textAlign(CENTER, CENTER); 
  textSize(TEXT_SIZE);
  
  //arbitrary values as test info
  testData = new int[HEIGHT*WIDTH];
  //centroid[0] = x loc, centroid[1] = y loc
  centroid = new float[2];
  //1st row is  left area centroid, 2nd is  right, third upper, 4th lower
  centUp = new float[2];
  centDown = new float[2];
  centLeft= new float[2];
  centRight= new float[2];
  
  //set variables describing desired pressure distribution 
  ratioAboveToBelow = 1.0;
  ratioLeftToRight = 1.0;
  
}


void draw() {
  background(0,0,0);
  // Tell Arduino to start communicating
  //myPort.write(SERIAL_START_CHAR);
  // Receive serial payload and update display values
  //processSerial();
  // Paint display
  simulateData();
  analyzeData();
  //drawDisplay();
  delay(1000);
}


void drawDisplay() {
  noStroke();
  for (int i = 0; i < HEIGHT; ++i) {
    for (int j = 0; j < WIDTH; ++j) {
      int brightness = displayColors[i * WIDTH + j];
      fill(brightness);
      rect(j * SQUARE_SIZE, i * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
      fill(0, 102, 153);
      text("" + brightness, j * SQUARE_SIZE + SQUARE_SIZE/2, i * SQUARE_SIZE + SQUARE_SIZE/2);
    }
  }
}
  
void simulateData() {
  for (int i = 0; i< HEIGHT; ++i){
    for (int j = 0; j<WIDTH; ++j){
      //"Triangular" data
      testData[i * WIDTH + j] = 10*i + j;
    }
  }
  displayColors = testData;
}

void normalizeData() {
  int sum = 0;
  //find sum of pressures
  for (int i = 0; i < WIDTH * HEIGHT; ++i){
    sum+=testData[i];
  }
  // normalize the pressures
  for (int i = 0; i< WIDTH * HEIGHT; ++i){
    testData[i] = testData[i]*10000/sum;
  }
}

float[] findCentroid(int left, int right, int top, int bottom) {
  int sum = 0;
  float j_moment = 0;
  float i_moment = 0;
  // loop through input area of testData
  for (int j = left; j < right; ++j){
    for(int i = top; i < bottom; ++i){
      int p_val = testData[i*(right-left) +j];
      sum+=p_val;
      j_moment+=p_val*j;
      i_moment+=p_val*i;
    }
  }
  
  float[] cent = {i_moment/ sum, j_moment/sum};
  return cent;
}

void drawCentroid(float[] cent){
  fill(color(255, 0, 0));
  rect((cent[1]+0.5) * SQUARE_SIZE, (cent[0]+0.5) * SQUARE_SIZE, 5, 5);
}

// finds centroids for areas above, below, left, and right of the centroid
void findSurroundingCentroids(float[] cent){
    int left = 0;
    int right = WIDTH;
    int top = 0;
    int bottom = HEIGHT;
    float cent_i = cent[0];
    float cent_j = cent[1];
    
    //locations of the centroids of upper, lower, left, and right areas surrounding the actual centroid
    centLeft = findCentroid(left, ceil(cent_j), top, bottom);
    centLeft[0] = centroid[0];
    
    centRight = findCentroid(ceil(cent_j), right, top, bottom);
    centRight[0] = centroid[0];
    
    centUp = findCentroid(left, right, top, ceil(cent_i));
    centUp[1] = centroid[1];
    
    centDown = findCentroid(left, right, ceil(cent_i), bottom);
    centDown[1] = centroid[1];
    
    drawCentroid(centLeft);
    drawCentroid(centRight);
    drawCentroid(centUp);
    drawCentroid(centDown);
    
}

void analyzePressureDistribution(){

  //find ratio of sub-centroid distances to main centroid
  float currentAboveToBelow = abs((centUp[0] - centroid[0])/(centDown[0] - centroid[0]));
  println("AboveToBelow: " + currentAboveToBelow);
  float currentLeftToRight = abs((centLeft[1] - centroid[1])/(centRight[1] - centroid[1]));
  println("LeftToRight: " + currentLeftToRight);
  
  //compare to desired ratios
  //if subsection centroid is too far away, there's less total pressure on that side
  float differenceVertical = currentAboveToBelow - ratioAboveToBelow;
  float differenceHorizontal = currentLeftToRight - ratioAboveToBelow;
  
  if (differenceVertical > 0.01){
    println("Need more pressure above.");
  }
  else if (differenceVertical < -0.01){
    println("Need more pressure below.");
  }
  else{
    println("Vertical pressure distribution equal!");
  }
  
  if (differenceHorizontal > 0.01){
    println("Need more pressure to the left.");
  }
  else if (differenceHorizontal < -0.01){
    println("Need more pressure to the right.");
  }
  else{
    println("Horizontal pressure distribution equal!");
  }
    
}

  
void analyzeData() {
  normalizeData();
  drawDisplay();
  
  centroid = findCentroid(0, WIDTH, 0, HEIGHT);
  drawCentroid(centroid);
  findSurroundingCentroids(centroid);
  analyzePressureDistribution();
  // print out all values
  /*println("Centroid Position: ( " + centroid[0] + " , " + centroid[1] + " )");
  println("CentLeft Position: ( " + centLeft[0] + " , " + centLeft[1] + " )");
  println("CentRight Position: ( " + centRight[0] + " , " + centRight[1] + " )");
  println("CentUp Position: ( " + centUp[0] + " , " + centUp[1] + " )");
  println("CentDown Position: ( " + centDown[0] + " , " + centDown[1] + " )");
  */
}
  
  
  

