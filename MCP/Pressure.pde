import processing.serial.*;

class Pressure{

MatIn mat;

Pressure(Serial myPort){
  mat = new MatIn(myPort);
}

void doeverything(int pose) {
float[][] stanDist = loadData("C:\\Users\\Erin\\Dropbox\\GlowCode\\standards\\standard",pose);
float[] standard = stanDist[0];
float[][] options = loadData("C:\\Users\\Erin\\Dropbox\\GlowCode\\standards\\Feedback4Point",pose);
String[] words = loadWords("C:\\Users\\Erin\\Dropbox\\GlowCode\\standards\\Words",pose);
int[][] points = {{0, 0, 0, 0},{0, 1, 0, 1}};
float[] MatOut = mat.getBalance(standard,points);

//float[] MatOut = {-1, 1};
int feedback = matchFeedback(MatOut, options);
println(words[feedback]);


}

int matchFeedback(float[] MatOut, float[][] options) {
  //println(MatOut);
  int output = 1;
      for (int i = 0 ; i < options.length; i++) {
        float[] temp = options[i];
        //println(temp);
        boolean isequal = true;
        for (int j = 0 ; j < temp.length; j++) {
            if(temp[j] != MatOut[j]) {
                isequal = false;

            }
          }
          if(isequal){
            output = i;
          }
        }
            //println(output);
  return output;
    }
    



  
String [] loadWords(String filePath, int pose) {
  
  filePath = filePath+pose+".txt";
  String lines[] = loadStrings(filePath);
  String[] output = new String [lines.length];
    for (int i = 0 ; i < lines.length; i++) {
      output[i] = lines[i];
    }
  return output;
}

float[][] loadData(String filePath, int pose) {
  filePath = filePath+pose+".csv";
  float csvarray[][];
  String lines[] = loadStrings(filePath);
  int csvWidth=0;

  for (int i=0; i < lines.length; i++) {
    String [] chars=split(lines[i],',');
    if (chars.length>csvWidth){
      csvWidth=chars.length;
    }
  }
  
  csvarray = new float [lines.length][csvWidth];
 
  for (int i=0; i < lines.length; i++) {
    String [] temp = new String [lines.length];
    temp= split(lines[i], ',');
    for (int j=0; j < temp.length; j++){
     csvarray[i][j]=float(temp[j]);
    }
  }
  return csvarray;
}
}
