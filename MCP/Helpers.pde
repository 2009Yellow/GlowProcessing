class Helpers{
  //yay.
  
  Helpers(){}
  
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
  
  public float sumVector(float[] vector){
    float sum = 0;
    for(int i = 0; i<vector.length; i++){
      sum+=vector[i];
    }  
    
    return sum;
  }
  
  public float sumArray(float[][] array){
    float sum = 0;
    
    for(int i = 0; i<array.length; i++){
      sum+=sumVector(array[i]);
    }
    
    return sum;
  }
  
}
