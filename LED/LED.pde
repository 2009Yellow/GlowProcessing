class LED{
  int[] pixels = new int[4];
  int[] colors = new int[4];
 MatIn mat;
  LED(MatIn mat){
    this.MatIn = mat;
  }

final int P = 1;//purple color for pose
final int R = 2;//red color for feedback
final int W = 3;// white for confirmation
final int[] allW = {W, W, W, W};//color array all white when balance is correct everywhere


void poseEvent(int[] pixelNumbers){
  println("new pose ");
  for(int i = 0; i < 4; i ++){
    if (i < pixelNumbers.length){
    pixels[i] = pixelNumbers[i];
    }
    //add 1000 in the case that we have less than 4 lights to light up
    else{
    pixels[i] = 1000;
    }
  }
  
  //all lights start out purple for a new pose
  for (int i = 0; i < 4; i ++){
    colors[i] = P;
  }
}
  
void pressureEvent(int[] pressure){
  int correct = 0;
  
  for(int i = 0; i < pressure.length; i++){
    switch(pressure[i]){
      case 0: 
        // change color to white if it is a pressure correction
        if(colors[i] == R){
          colors[i] = W;
          println("corrected pressure");
        }
        //keep color at purple otherwise
        else{
          println("no pressure change");
        }
        correct++;
        break;
      // change color to red for too much pressure
      case 1: 
        colors[i] = R;
        println("too much pressure");
        break;
      // color stays purple for not enough pressure
      case -1:
        colors[i] = P;
        println("too little pressure");
        break;
    }
  }
  // if all pressures have been corrected, change everything to white
  if (correct == pressure.length){
    colors = allW;
    println("confirmation pose!!");
  }
}
}


