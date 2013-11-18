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
  
  // Member Variables
  private int matWidth;
  private int matHeight;
  
  private Serial myPort;   
  private int[] serialInArray;  // Input bytes from the serial
  
  // Time update members
  private long lastTime;
  private final long TIMEOUT = 250; // In mills, update at most 4 times a second
  
  // ========================== Constructor ==========================
  public MatIn(int mat_w, int mat_h, PApplet papplet ){
    matWidth = mat_w;
    matHeight = mat_h;
    serialInArray = new int[matWidth * matHeight];
    // Print a list of the serial ports, for debugging purposes:
    println(Serial.list());
    String portName = Serial.list()[8];
    myPort = new Serial(papplet, portName, 115200);
    // Number of bytes to buffer before calling serialEvent()
    establishContact();
    // Update time counters
    lastTime = System.currentTimeMillis();
  }
  
  
  // ========================== Private Methods ==========================
  private void establishContact() {
    // Tripple clear the port. This is a hack to deal with buggy arduinos
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
    //println("first " + inByte);
    // If the first byte received is not the start of the data, 
    // flush the serial buffer and return
    if (inByte != SERIAL_PRESSURE_FIRST_RECEIVE_CHAR) {
      String trash = myPort.readStringUntil(SERIAL_PRESSURE_FINAL_RECEIVE_CHAR);
      println("Trash: " + trash);
      println("Error receiving first char");
      return;
    }
    //println("Received start char!");
  
    // Read the payload from the serial
    for (int i = 0; i < serialInArray.length; ++i) {
       serialInArray[i] =  waitToRead();
       //println("Data char " + serialInArray[i] + " at index " + i);
    }
    // Ensure final char is correct
    inByte = waitToRead();
    //println("final " + inByte);
    if (inByte != SERIAL_PRESSURE_FINAL_RECEIVE_CHAR) {
      println("Error receiving final char");
      return;
    }
    // Update display array
    println("Data success!");
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

  public void setLights(int[] positions, int[] colors) {
    // Tell Arduino to begin receiving light info 
    myPort.write(SERIAL_LIGHT_START_CHAR);
    
    // First value char
    myPort.write(SERIAL_LIGHT_FIRST_RECEIVE_CHAR);
    
    // Send each position value first in the form of two bytes
    for (int pos : positions) {
      // Send high byte
      int high_byte = pos >> 8;
      myPort.write(high_byte);
      // Send low bytes
      int low_byte = pos & 256;
      myPort.write(low_byte); 
    }
    
    // Send each color value as a single byte
    for(int c : colors) {
      myPort.write(c);
    }
    
    // Ending char
    myPort.write(SERIAL_LIGHT_FINAL_RECEIVE_CHAR);
    
  }
  
  public int[] getPressureDataRaw() {
    int[] ans = new int[serialInArray.length];
    System.arraycopy(serialInArray, 0, ans, 0, serialInArray.length);
    return ans;
  }
  
  public float[][] getPressureDataMatrix() {
    float [][] outputMatrix = new float[matHeight][matWidth];
        for (int j = 0; j<matWidth; ++j){
      for (int i = 0; i <matHeight; ++i){

        outputMatrix[i][j] = serialInArray[j * WIDTH + i];
      }
    }
    return outputMatrix;
  }  
  
}

