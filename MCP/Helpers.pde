class Helpers {
  //yay.
  
  final public int SINGLE_VALUE_THRESHOLD = 60;
  
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
  
}

