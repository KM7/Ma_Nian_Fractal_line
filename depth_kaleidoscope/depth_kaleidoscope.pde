// Daniel Shiffman
// Kinect Point Cloud example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

// Angle for rotation
float a = 0;

// We'll use a lookup table so that we don't have to repeat the math over and over
float[] depthLookUp = new float[2048];
int skip = 6;
ArrayList<int[]>buffer=new ArrayList<int[]>();
boolean start=false;
int n=0;
int up_limit=120;


void setup() {
  // Rendering in P3D
  size(800, 600, P3D);
  kinect = new Kinect(this);
  kinect.initDepth();

  // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}

void draw() {

background(0);
beginCamera();
camera();
rotateX(-PI/3);
endCamera();

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();
  add_coco(create_dup(depth));
  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)

  // Translate and rotate
  translate(width/2, height/2, -50);
  //rotateY(a);
  depth_circle(16);
  //display_one(depth,new PVector(0,0,0),0);
 
}

// These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}

void display_one(int[] depth ,PVector p,float rotation){
    for (int x = 0; x < kinect.width; x += skip) {
    for (int y = 0; y < kinect.height; y += skip*2) {
      int offset = x + y*kinect.width;
      int rawDepth = depth[offset];
      if (rawDepth<800){
      PVector v = depthToWorld(x, y, rawDepth);
      // Convert kinect data to world xyz coordinate
      if (rawDepth<800){
      stroke(255);
      pushMatrix();
      // Scale up by 200
      rotateY(rotation);
      float factor = 200;
      translate((v.x)*factor+p.x, (v.y)*factor+p.y, factor-(v.z)*factor+p.z);
      // Draw a point
      point(0, 0);
      popMatrix();
      }
    }
}
}
}

void depth_circle(int number){
      float angle_unit=2*PI/(number);
      int frame_stepper=floor(up_limit/float(number));
      
       PVector p=new PVector(300,0,0);
       for (int i=0;i<number;i++){
         if (start==true){
       display_one(buffer.get(frame_stepper*i),p,angle_unit*i);
         }else{
       display_one(buffer.get(buffer.size()-1),p,angle_unit*i);
         }
       }
}

void add_coco(int[] depth){
  buffer.add(depth);
  if (n==up_limit+1) {
    n=0;  
    start=true;
  }
  n++;
  
    if (start==true) {
      println(true);
        buffer.remove(0);
    //crazy swapping start
  }
}
      
int[] create_dup(int [] input){
  int[] temp_return=new int[input.length];
  for (int i=0;i<input.length;i++){
    temp_return[i]=input[i];
  }
  
  return temp_return;
}