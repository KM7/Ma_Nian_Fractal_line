float angle_normalize(float theta){
  return theta - TWO_PI * floor((theta + PI) / TWO_PI);
}