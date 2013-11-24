class MatGraphics {


  // Display Constants
  final int SQUARE_SIZE = 40;
  final int TEXT_SIZE = 20;

  PFont myFont;
  int[] displayColors;
  
  int matHeight;
  int matWidth;

  MatGraphics(int HEIGHT, int WIDTH) {

    // Init display
    size(SQUARE_SIZE * WIDTH, 3*SQUARE_SIZE * HEIGHT);  // Stage size

    // Drawing setup
    rectMode(CORNER);
    // Font setup
    myFont = createFont("Georgia", 72);
    textAlign(CENTER, CENTER); 
    textSize(TEXT_SIZE);

    background(0, 0, 0);
    
    matHeight = HEIGHT;
    matWidth = WIDTH;
  }

  void drawDisplay(float[] matData) {
    noStroke();
    for (int i = 0; i < matHeight; ++i) {
      for (int j = 0; j < matWidth; ++j) {
        int brightness = (int)matData[(matHeight-1-i) * matWidth + j];
        fill(brightness);
        rect(j * SQUARE_SIZE, i * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
        fill(0, 102, 153);
        text("" + brightness, j * SQUARE_SIZE + SQUARE_SIZE/2, i * SQUARE_SIZE + SQUARE_SIZE/2);
      }
    }
    
    /*for (int i = 0; i < matHeight; ++i) {
      for (int j = 0; j < matWidth; ++j) {
        int brightness = (int)matData[i][j];
        fill(brightness);
        rect(j * SQUARE_SIZE, i * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
        fill(0, 102, 153);
        text("" + brightness, j * SQUARE_SIZE + SQUARE_SIZE/2, i * SQUARE_SIZE + SQUARE_SIZE/2);
      }
    }*/
    
   }

    //draw normalized data
    /*
    for (int j = 0; j< diff.length; j++){
     int brightness = (int)(-diff[j]*(128)+128);
     fill(brightness);
     rect(j * SQUARE_SIZE, 2 * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
     fill(0, 102, 153);
     text("" + (-brightness+128), (j+0.5)*SQUARE_SIZE,  2.5 * SQUARE_SIZE);
     }*/
  
}



