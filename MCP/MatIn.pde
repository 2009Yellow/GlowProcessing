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
  private int[] mat1Array;  // Input bytes from the serial
  private int[] mat2Array;  // Input bytes from the serial
  private int[] mat3Array;  // Input bytes from the serial

  // Time update members
  private long lastTime;
  private final long TIMEOUT = 200; // In mills, update at most 4 times a second

  //a record of previous pressure states
  int[][] dataRecord1;
  int[][] dataRecord2;
  int[][] dataRecord3;
  
  int N = 5; //number of data sets to store and time-average

  // Helper class for arithmetic and such
  Helpers help;
  //To show the data visually
  MatGraphics matGraphics;

  // ========================== Constructor ==========================
  public MatIn(int mat_w, int mat_h, PApplet papplet ) {
    matWidth = mat_w;
    matHeight = mat_h;
    help = new Helpers();
    matGraphics = new MatGraphics(matWidth, matHeight);
    
    // INit all mat arrays
    mat1Array = new int[matWidth * matHeight];
    mat2Array = new int[matWidth * matHeight];
    mat3Array = new int[matWidth * matHeight];
    // Init data records
    dataRecord1 = new int[N][mat1Array.length];
    dataRecord2 = new int[N][mat2Array.length];
    dataRecord3 = new int[N][mat3Array.length];
    String portName = Serial.list()[0];
    myPort = new Serial(papplet, portName, 115200);
    // Number of bytes to buffer before calling serialEvent()
    establishContact();
    //println(serialInArray);

    // Update time counters
    lastTime = System.currentTimeMillis()-250;
    update();
  }

  // ========================== Private Methods ==========================
  private void establishContact() {
    // Triple clear the port. This is a hack to deal with buggy arduinos
    while (myPort.available () ==0) {
    }
    myPort.clear();
    while (myPort.available () ==0) {
    }
    myPort.clear();
    while (myPort.available () ==0) {
    }
    println("Established contact!");
    myPort.write(SERIAL_ESTABLISH_CONTACT_CHAR); // send a capital A
    myPort.clear();
  }

  private int waitToRead() {
    while (myPort.available () == 0) {
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
    for (int i = 0; i < mat1Array.length; ++i) {
      mat1Array[i] =  waitToRead();
      //println("Data char " + serialInArray[i] + " at index " + i);
    }
    for (int i = 0; i < mat2Array.length; ++i) {
      mat2Array[i] =  waitToRead();
      //println("Data char " + serialInArray[i] + " at index " + i);
    }
    for (int i = 0; i < mat3Array.length; ++i) {
      mat3Array[i] =  waitToRead();
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
    updateDataRecord();
  }


  private void updateDataRecord() {

    for (int i = 0; i < N-1; ++i) {
      dataRecord1[i] = dataRecord1[i+1]; //delete oldest data, shift to make room for new data
      dataRecord2[i] = dataRecord2[i+1];
      dataRecord3[i] = dataRecord3[i+1];
    }
    dataRecord1[N-1] = getMat1DataRaw(); //add new data
    dataRecord2[N-1] = getMat2DataRaw();
    dataRecord3[N-1] = getMat3DataRaw();
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
    /*
    println("Positions");
     println(positions);
     println("Colors");
     println(colors);
     */

    int[] positionsToWrite = {
      0, 0, 0, 0
    };
    int[] colorsToWrite = {
      0, 0, 0, 0
    };


    for ( int i = 0; i<positions.length; i++) {
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
    for (int c : colorsToWrite) {
      myPort.write(c);
    }

    // Ending char
    myPort.write(SERIAL_LIGHT_FINAL_RECEIVE_CHAR);

    int arduinoIsFinished = waitToRead();
    //println("Finished theoretically"+arduinoIsFinished);
  }

  public int[] getMat1DataRaw() {
    int[] ans = new int[mat1Array.length];
    System.arraycopy(mat1Array, 0, ans, 0, mat1Array.length);
    return ans;
  }

  public int[] getMat2DataRaw() {
    int[] ans = new int[mat1Array.length];
    System.arraycopy(mat2Array, 0, ans, 0, mat2Array.length);
    return ans;
  }

  public int[] getMat3DataRaw() {
    int[] ans = new int[mat1Array.length];
    System.arraycopy(mat3Array, 0, ans, 0, mat3Array.length);
    return ans;
  }

  public float[] getTimeAveragedData(int[][] dataRecord ) {
    float[] timeAveragedData = new float[mat1Array.length];
    for (int j = 0; j<timeAveragedData.length; j++) {
      float sum = 0;
      for (int i = 0; i< N; i++) {
        sum+=dataRecord[i][j];
        
      }
      timeAveragedData[j] = sum/N;
    }
    
    return timeAveragedData;
  }

  public float[][] getPressureDataMatrix() {
    float [][] outputMatrix = new float[matHeight][matWidth*3];
    float[] timeAveragedData1 = getTimeAveragedData(dataRecord1);
    float[] timeAveragedData2 = getTimeAveragedData(dataRecord2);
    float[] timeAveragedData3 = getTimeAveragedData(dataRecord3);

    for (int j = 0; j<matWidth; ++j) {
      for (int i = 0; i <matHeight; ++i) {
        outputMatrix[i][j] = timeAveragedData3[(matHeight-1-i) * matWidth + j];
        outputMatrix[i][16+j] = timeAveragedData2[(matHeight-1-i) * matWidth + j];
        outputMatrix[i][32+j] = timeAveragedData1[(matHeight-1-i) * matWidth + j];
      }
    }
    
    matGraphics.drawDisplay(help.thresholdMatrix(outputMatrix));
    // matGraphics.drawDisplay(outputMatrix);
    return outputMatrix;
  }
}

