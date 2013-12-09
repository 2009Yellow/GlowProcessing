class Helpers {
  //yay.
  
  final public int SINGLE_VALUE_THRESHOLD = 50;
  
  
  Helpers() {
  }

  public float[] multMat(float[] input, float factor) {
    float[]output = new float[input.length];
    for (int i = 0; i < input.length; ++i) {
      output[i] = input[i]*factor;
    }
    return output;
  }

  public float[] multMat(int[] input, float factor) {
    float[]output = new float[input.length];
    for (int i = 0; i < input.length; ++i) {
      output[i] = ((float)input[i])*factor;
    }
    return output;
  }

  public float sumVector(float[] vector) {
    float sum = 0;
    for (int i = 0; i<vector.length; i++) {
      sum+=vector[i];
    }  

    return sum;
  }

  public float sumArray(float[][] array) {
    float sum = 0;

    for (int i = 0; i<array.length; i++) {
      sum+=sumVector(array[i]);
    }

    return sum;
  }

  public float[][] thresholdMatrix(float[][] matrix) {
    float[][] thresholdedMatrix = new float[matrix.length][matrix[0].length];
    for (int i = 0; i<matrix.length; i++) {
      for (int j = 0; j<matrix[0].length; j++) {
        if (matrix[i][j] > SINGLE_VALUE_THRESHOLD) {
          thresholdedMatrix[i][j] = matrix[i][j];
        }
      }
    }
    return thresholdedMatrix;
  }


  public float[] thresholdArray(float[] array) {
    float[] thresholdArray = new float[array.length];

    for (int j = 0; j<array.length; j++) {
      if (array[j] > SINGLE_VALUE_THRESHOLD) {
        thresholdArray[j] = array[j];
      }
    }
    
    return thresholdArray;
  }
  
  //receives poseAreas (each row contains data about one point of contact with mat)
  //TODO: for final product, delete the onMat array; won't be needed because all poses will be on mat
  // also delete weight
  float[] sumAreas(float [][] rawData, float[][] poseAreas, float[] onMat, float weight) {
    float[][] thresholdData = this.thresholdMatrix(rawData);
    float[] areaSums = new float[poseAreas[0].length];
    //loop through the different contact areas listed defined by poseAreas
    for (int areaNum = 0; areaNum < poseAreas[0].length; areaNum++)
    {
      float sum = 0;
      
      if(onMat[areaNum] == 0) {
       // println("imaginary area!");
        
        if(areaSums.length == 2){
          sum = weight-areaSums[areaNum-1];
          areaSums[areaNum] = sum;
        }
        
        else{ //assuming there are 4 contact points for now
          sum = (weight-(areaSums[0]+areaSums[1]))/2;
          areaSums[areaNum] = sum;
          areaSums[areaNum+1] = sum;
        }
        break;
      }
      for (int i = (int)poseAreas[0][areaNum]; i <= (int)poseAreas[2][areaNum]; ++i) {
        for (int j = (int)poseAreas[1][areaNum]; j <= (int)poseAreas[3][areaNum]; ++j) {
          float temp = thresholdData[i][j];
            sum+=temp;
        }
      }
    
      areaSums[areaNum] = sum;
    }

    return areaSums;
  }
  
  float[] sumAreas(float [][] rawData, float[][] poseAreas) {
    float[][] thresholdData = this.thresholdMatrix(rawData);
    float[] areaSums = new float[poseAreas[0].length];
    
    for (int areaNum = 0; areaNum < poseAreas[0].length; areaNum++){ 
      
      int sum = 0; 
      for (int i = (int)poseAreas[0][areaNum]; i <= (int)poseAreas[2][areaNum]; ++i) {
        for (int j = (int)poseAreas[1][areaNum]; j <= (int)poseAreas[3][areaNum]; ++j) {
          float temp = thresholdData[i][j];
            sum+=temp;
        }
      }
      
      areaSums[areaNum] = sum;
    }
    
    //println("Area Sums ");
    //println(areaSums);
    return areaSums;
  }
  
}

