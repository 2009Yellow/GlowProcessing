import java.lang.System;

import processing.serial.*;

// Display Constants
final int SQUARE_SIZE = 85;
final int WIDTH = 4;
final int HEIGHT = 4;
final int TEXT_SIZE = 35;

// Serial Communcation Constants
final int SERIAL_ESTABLISH_CONTACT_CHAR = 'A';

final int SERIAL_PRESSURE_START_CHAR = 'B';
final int SERIAL_PRESSURE_FIRST_RECEIVE_CHAR = 'C'; 
final int SERIAL_PRESSURE_FINAL_RECEIVE_CHAR = 'D';

final int SERIAL_LIGHT_START_CHAR = 'E';
final int SERIAL_LIGHT_FIRST_RECEIVE_CHAR = 'F'; 
final int SERIAL_LIGHT_FINAL_RECEIVE_CHAR = 'G';


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
  establishContact();
  
  // Drawing setup
  rectMode(CORNER);
  for (int i = 0;i < displayColors.length; ++i) {
    displayColors[i] = int(random(255));
  }
  frameRate(4);
  
  // Font setup
  //String[] fontList = PFont.list();
  //println(fontList);
  myFont = createFont("Georgia", 72);
  textAlign(CENTER, CENTER); 
  textSize(TEXT_SIZE);
}


void establishContact() {
  while (myPort.available() ==0) {
  }
  println("Established contact!");
  myPort.write(SERIAL_ESTABLISH_CONTACT_CHAR);   // send a capital A
  myPort.clear();
}


void draw() {
  background(0,0,0);
  // Tell Arduino to start communicating pressure values
  myPort.write(SERIAL_PRESSURE_START_CHAR);
  // Receive serial payload and update display values
  processSerial();
  // Paint display
  drawDisplay();
}


int waitToRead() {
  while(myPort.available() == 0){
  }
  return myPort.read();
}


void processSerial() {
  // Read first byte from the serial port
  int inByte = myPort.read();
  println("first " + inByte);
  // If the first byte received is not the start of the data, 
  // flush the serial buffer and return
  if (inByte != SERIAL_PRESSURE_FIRST_RECEIVE_CHAR) {
    String trash = myPort.readStringUntil(SERIAL_PRESSURE_FINAL_RECEIVE_CHAR);
    println("Trash: " + trash);
    println("Error receiving first char");
    return;
  }
  println("Received start char!");

  // Read the payload from the serial
  for (int i = 0; i < serialInArray.length; ++i) {
     serialInArray[i] =  waitToRead();
     println("Data char " + serialInArray[i] + " at index " + i);
  }
  // Ensure final char is correct
  inByte = waitToRead();
  println("final " + inByte);
  if (inByte != SERIAL_PRESSURE_FINAL_RECEIVE_CHAR) {
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

