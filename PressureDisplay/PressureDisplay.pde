import java.lang.System;

import processing.serial.*;

// Display Constants
final int SQUARE_SIZE = 150;
final int HEIGHT = 5;
final int WIDTH = 7;

// Serial Communcation Constants
final int SERIAL_START_CHAR = 'A';
final int FIRST_SERIAL_RECEIVE_CHAR = 'B';
final int FINAL_SERIAL_RECEIVE_CHAR = 10;  // LIinefeed in ASCII

// Member variables
Serial myPort;                       
int[] serialInArray = new int[HEIGHT * WIDTH];  // Input bytes from the serial
int[] displayColors = new int[HEIGHT * WIDTH];  // Values for running display

PFont myFont;

void setup() {
  // Init display
  size(SQUARE_SIZE * WIDTH, SQUARE_SIZE * HEIGHT);  // Stage size
  
  // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());
  String portName = Serial.list()[8];
  myPort = new Serial(this, portName, 9600);
  // Number of bytes to buffer before calling serialEvent()
  //myport.buffer(1);
  
  // Drawing setup
  rectMode(CORNER);
  for (int i = 0;i < displayColors.length; ++i) {
    displayColors[i] = int(random(255));
  }
  frameRate(5);
  
  // Font setup
  //String[] fontList = PFont.list();
  //println(fontList);
  myFont = createFont("Georgia", 72);
  textAlign(CENTER, CENTER); 
  textSize(50);
}


void draw() {
  background(0,0,0);
  // Tell PSoc to start communicating
  myPort.write(SERIAL_START_CHAR);
  // Receive serial payload and update display values
  processSerial();
  // Paint display
  drawDisplay();
}


int waitToRead(Serial myPort) {
  while(myPort.available() == 0){
  }
  return myPort.read();
}


void processSerial() {
  // Read first byte from the serial port
  int inByte = myPort.read();
  //int inByte = waitToRead(myPort);
  println("first" + inByte);
  // If the first byte received is not the start of the data, 
  // flush the serial buffer and return
  if (inByte != FIRST_SERIAL_RECEIVE_CHAR) {
    String trash = myPort.readStringUntil(FINAL_SERIAL_RECEIVE_CHAR);
    println("Error receiving first char");
    return;
  }
  println("Received start char!");

  // Read the payload from the serial
  for (int i = 0; i < serialInArray.length; ++i) {
     serialInArray[i] =  waitToRead(myPort);
     println("Data char " + serialInArray[i] + " at index " + i);
  }
  // Ensure final char is correct
  inByte = waitToRead(myPort);
  if (inByte != FINAL_SERIAL_RECEIVE_CHAR) {
    println("Error receiving final char");
    return;
  }
  // Update display array
  System.arraycopy(serialInArray, 0, displayColors, 0, serialInArray.length);
  println("Data success!");
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

