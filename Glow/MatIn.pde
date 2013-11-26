import processing.core.*;
import processing.serial.*;

public class MatIn {  
  // Serial Communcation Constants
  private final int SERIAL_ESTABLISH_CONTACT_CHAR = 'A';
  
  private final int SERIAL_PRESSURE_START_CHAR = 'B';
  private final int SERIAL_PRESSURE_FIRST_RECEIVE_CHAR = 'C'; 
  private final int SERIAL_PRESSURE_FINAL_RECEIVE_CHAR = 'D';
  
  private final int SERIAL_LIGHT_START_CHAR = 'E';
  private final int SERIAL_LIGHT_FIRST_RECEIVE_CHAR = 'F'; 
  private final int SERIAL_LIGHT_FINAL_RECEIVE_CHAR = 'G';
  private final int SERIAL_LIGHT_ERROR_CHAR = 'H';
  private final int SERIAL_LIGHT_FINISHED_RECEIVING_CHAR = 'I';
  
  // Member Variables
  private int matWidth;
  private int matHeight;
  
  private Serial myPort;   
  private int[] serialInArray;  // Input bytes from the serial
  
  // Time update members
  private long lastTime;
  private final long TIMEOUT = 200; // In mills, update at most 4 times a second
  
  //a record of previous pressure states
  int[][] dataRecord;
  int N = 5; //number of data sets to store and time-average
  
  // Helper class for arithmetic and such
  Helpers help;
  //To show the data visually
  MatGraphics matGraphics;
  
  // ========================== Constructor ==========================
  public MatIn(int mat_w, int mat_h, PApplet papplet ){
    matWidth = mat_w;
    matHeight = mat_h;
    help = new Helpers();
    
    // for debugging
    //matGraphics = new MatGraphics(matWidth, matHeight);
    
    serialInArray = new int[matWidth * matHeight];
    dataRecord = new int[N][serialInArray.length];
    String portName;
    System.out.println(System.getProperty("os.name"));
    if ( System.getProperty("os.name").startsWith("Mac OS X")) {
      portName = Serial.list()[8];
    } else {
      portName = Serial.list()[0];
    }

    myPort = new Serial(papplet, portName, 115200);
    // Number of bytes to buffer before calling serialEvent()
    establishContact();
    println(serialInArray);
   
    // Update time counters
    lastTime = System.currentTimeMillis()-250;
    update();
  }
   
  // ========================== Private Methods ==========================
  private void establishContact() {
    // Triple clear the port. This is a hack to deal with buggy arduinos
    while (myPort.available() ==0) {
    }
    myPort.clear();
    while (myPort.available() ==0) {
    }
    myPort.clear();
    while (myPort.available() ==0) {
    }
    println("Established contact!");
    myPort.write(SERIAL_ESTABLISH_CONTACT_CHAR); // send a capital A
    myPort.clear();
  }
  
  private int waitToRead() {
    while(myPort.available() == 0){
    }
    return myPort.read();
  }

  private void processSerial() {
    // Read first byte from the serial port
    int inByte = myPort.read();
   // println("first " + inByte);
    // If the first byte received is not the start of the data, 
    // flush the serial buffer and return
    if (inByte != SERIAL_PRESSURE_FIRST_RECEIVE_CHAR) {
      String trash = myPort.readStringUntil(SERIAL_PRESSURE_FINAL_RECEIVE_CHAR);
      //println("Trash: " + trash);
      //println("Error receiving first char");
      return;
    }
    //println("Received start char!");
  
    // Read the payload from the serial
    for (int i = 0; i < serialInArray.length; ++i) {
       serialInArray[i] =  waitToRead();
      // println("Data char " + serialInArray[i] + " at index " + i);
    }
    // Ensure final char is correct
    inByte = waitToRead();
    //println("final " + inByte);
    if (inByte != SERIAL_PRESSURE_FINAL_RECEIVE_CHAR) {
     // println("Error receiving final char");
      return;
    }
    
    updateDataRecord(serialInArray);
  }
  
  private void updateDataRecord(int[] dataNew) {
    
    for (int i = 0; i < N-1; ++i) {
      dataRecord[i] = dataRecord[i+1]; //delete oldest data, shift to make room for new data
    }
    dataRecord[N-1] = dataNew; //add new data
  }
  
  // ========================== Public Methods ==========================
  /*
   * Call this method regularly to update the serial interface.
   */
  public void update() {
    // We only update if we've passed the timeout
    long currentTime = System.currentTimeMillis();
    if (currentTime - lastTime < TIMEOUT) {
      return;
    }
    lastTime = currentTime;
    // Tell Arduino to start communicating pressure values
    myPort.write(SERIAL_PRESSURE_START_CHAR);
    // Receive serial payload and update display values
    processSerial();
  }

  public void setLights(float[] positions, float[] colors) {
    println("Positions");
    println(positions);
    println("Colors");
    println(colors);
    
    int[] positionsToWrite = {0, 0, 0, 0};
    int[] colorsToWrite = {0, 0, 0, 0};
    
    for ( int i = 0; i<positions.length; i++){
      positionsToWrite[i] = (int)positions[i];
      colorsToWrite[i] = (int)colors[i];
    }
    myPort.clear(); //Clear old pressure data from buffer
    // Tell Arduino to begin receiving light info 
    myPort.write(SERIAL_LIGHT_START_CHAR);
    
    // First value char
    myPort.write(SERIAL_LIGHT_FIRST_RECEIVE_CHAR);
    
    // Send each position value first in the form of two bytes
    for (int pos : positionsToWrite) {
      //println(pos);
      // Send high byte
      /*int high_byte = pos >> 8;
      println("high byte " + high_byte);
      myPort.write(high_byte);
      // Send low bytes
      int low_byte = pos & 256;
      println("low byte " + low_byte);
      myPort.write(low_byte); */
      
      int low_byte = pos % 128;
     // println("Low byte " + low_byte);
      int multiplesOf128 = (pos-low_byte)/128;
      //println("Multiplier " + multiplesOf128);
      myPort.write(multiplesOf128);
      myPort.write(low_byte);
      
      
    }
   
    
    // Send each color value as a single byte
    for(int c : colorsToWrite) {
      myPort.write(c);
    }
    
    // Ending char
    myPort.write(SERIAL_LIGHT_FINAL_RECEIVE_CHAR);
    
    int arduinoIsFinished = waitToRead();
    println("Finished theoretically"+arduinoIsFinished);
    
  }
  
  public float[] getTimeAveragedData() {
    float[] timeAveragedData = new float[serialInArray.length];
    for(int j = 0; j<serialInArray.length; j++){
      float sum = 0;
      for(int i = 0; i< N; i++){
        sum+=dataRecord[i][j];
      }
      timeAveragedData[j] = sum/N;
    }
    //matGraphics.drawDisplay(help.thresholdArray(timeAveragedData));
    return timeAveragedData;
  }
  
  public float[][] getPressureDataMatrix() {
    float [][] outputMatrix = new float[matHeight][matWidth];
    float[] timeAveragedData = getTimeAveragedData();
    
     for (int j = 0; j<matWidth; ++j){
       for (int i = 0; i <matHeight; ++i){
         outputMatrix[i][j] = timeAveragedData[(matHeight-1-i) * matWidth + j];
      }
    }
   // matGraphics.drawDisplay(outputMatrix);
    return outputMatrix;
  }  

}

