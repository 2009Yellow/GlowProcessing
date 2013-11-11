import java.lang.System;
import processing.serial.*;

class MatIn{
  
final int HEIGHT = 1;
final int WIDTH = 2;

// Serial Communcation Constants
final int SERIAL_START_CHAR = 'A';
final int FIRST_SERIAL_RECEIVE_CHAR = 'B';
final int FINAL_SERIAL_RECEIVE_CHAR = 'C';  

// Member variables
Serial myPort;                       
int[] serialInArray = new int[HEIGHT * WIDTH];  // Input bytes from the serial
Balance global; //analyze global balance


MatIn(Serial myPort) {  
  this.myPort = myPort;
  
  //Data Analysis setup
  global = new Balance(HEIGHT, WIDTH);
}


void draw() {

  // Receive serial payload and update display values

}

float[] getBalance(float[] ref, int[][] poseAreas){
    global.setRef(ref);
    global.setAreas(poseAreas);
    processSerial();
    return global.analyzeBalance(vectorToMatrix(serialInArray));
}

int waitToRead(Serial myPort) {
  while(myPort.available() == 0){
  }
  return myPort.read();
}


void processSerial() {
  // Read first byte from the serial port
  // int inByte = myPort.read();
  int inByte = waitToRead(myPort);
  //println("first" + inByte);
  // If the first byte received is not the start of the data, 
  // flush the serial buffer and return
  if (inByte != FIRST_SERIAL_RECEIVE_CHAR) {
    String trash = myPort.readStringUntil(FINAL_SERIAL_RECEIVE_CHAR);
    //println("Error receiving first char");
    return;
  }
  //println("Received start char!");

  // Read the payload from the serial
  for (int i = 0; i < serialInArray.length; ++i) {
     serialInArray[i] =  waitToRead(myPort);
     //println("Data char " + serialInArray[i] + " at index " + i);
  }
  // Ensure final char is correct
  inByte = waitToRead(myPort);
  if (inByte != FINAL_SERIAL_RECEIVE_CHAR) {
    //println("Error receiving final char");
    return;
  }
  //println("Data success!"); 

}

float[][] vectorToMatrix(int[] rawData){
  float [][] outputMatrix = new float[HEIGHT][WIDTH];
  for (int i = 0; i<HEIGHT; ++i){
    for (int j = 0; j < WIDTH; ++j){
      outputMatrix[i][j] = rawData[i * WIDTH + j];
    }
  }
  return outputMatrix;
}
}
