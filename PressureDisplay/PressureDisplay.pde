import java.lang.System;


// Display Constants
final int SQUARE_SIZE = 40;
final int WIDTH = 16;
final int HEIGHT = 16;
final int TEXT_SIZE = 30;

// Member variables
int[] displayColors = new int[HEIGHT * WIDTH];  // Values for running display

PFont myFont;

MatIn matIn;

void setup() {
  // Init display
  size(SQUARE_SIZE * WIDTH, SQUARE_SIZE * HEIGHT);  // Stage size
  
  // Init MatIn
  matIn = new MatIn(WIDTH, HEIGHT, this);
  
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
}


void draw() {
  background(0,0,0);
  // Update MatIn
  matIn.update();
  // Get pressure data
   System.arraycopy(matIn.getMat2DataRaw(), 0, displayColors, 0, displayColors.length);
  // Paint display
  drawDisplay();
}

void drawDisplay() {
  noStroke();
  for (int i = 0; i < HEIGHT; ++i) {
    for (int j = 0; j < WIDTH; ++j) {
      int brightness = displayColors[(HEIGHT-1-i) * WIDTH + j];
      fill(brightness);
      rect(j * SQUARE_SIZE, i * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
      fill(0, 102, 153);
      text("" + brightness, j * SQUARE_SIZE + SQUARE_SIZE/2, i * SQUARE_SIZE + SQUARE_SIZE/2);
    }
  }
}

void keyPressed() {
  int [] positions = {100, 200, 300, 400};
  int [] colors = {0, 1, 2, 3};
  matIn.setLights(positions, colors);
}


