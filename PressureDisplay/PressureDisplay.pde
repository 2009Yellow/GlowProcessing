import java.lang.System;

import processing.serial.*;

// Display Constants
final int SQUARE_SIZE = 80;
final int HEIGHT = 4;
final int WIDTH = 4;

// Serial Communcation Constants
final int SERIAL_START_CHAR = 0xFF;
final int FIRST_SERIAL_RECEIVE_CHAR = 0xFF;
final int FINAL_SERIAL_RECEIVE_CHAR = 10;  // LInefeed in ASCII

// Member variables
Serial myPort;                       
int[] serialInArray = new int[HEIGHT * WIDTH];  // Input bytes from the serial
int[] displayColors = new int[HEIGHT * WIDTH];  // Values for running display


void setup() {
  // Init display
  size(SQUARE_SIZE * WIDTH, SQUARE_SIZE * HEIGHT);  // Stage size
  
  // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  // Number of bytes to buffer before calling serialEvent()
  //myport.buffer(1);
  
  // Drawing setup
  rectMode(CORNER);
  for (int i = 0;i < displayColors.length; ++i) {
    displayColors[i] = int(random(255));
  }
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


void processSerial() {
  // Read first byte from the serial port
  int inByte = myPort.read();
  // If the first byte received is not the start of the data, 
  // flush the serial buffer and return
  if (inByte != FIRST_SERIAL_RECEIVE_CHAR) {
    String trash = myPort.readStringUntil(FINAL_SERIAL_RECEIVE_CHAR);
    println("Error receiving first char");
    return;
  }
  // Read the payload from the serial
  for (int i = 0; i < serialInArray.length; ++i) {
    while(myPort.available() == 0){
      // spin till data arrives
    }
     serialInArray[i] =  myPort.read();
  }
  // Ensure final char is correct
  while(myPort.available() == 0){
    // spin till data arrives
  }
  inByte = myPort.read();
  if (inByte != FINAL_SERIAL_RECEIVE_CHAR) {
    println("Error receiving final char");
    return;
  }
  // Update display array
  System.arraycopy(serialInArray, 0, displayColors, 0, serialInArray.length);
}


void drawDisplay() {
  noStroke();
  for (int i = 0; i < HEIGHT; ++i) {
    for (int j = 0; j < WIDTH; ++j) {
      int brightness = displayColors[i * WIDTH + j];
      fill(brightness);
      rect(i * SQUARE_SIZE, j * SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE);
    }
  }
}

