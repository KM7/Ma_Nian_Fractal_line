// Daniel Shiffman //<>// //<>//
// Thomas Sanchez Lengeling
// Kinect Point Cloud example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import java.nio.*;
import org.openkinect.processing.*;

// Kinect Library object
Kinect2 kinect2;

// Angle for rotation

//change render mode between openGL and CPU
int renderMode = 1;

//openGL object and shader
PShader sh;

//VBO buffer location in the GPU
int vertexVboId;

int skip = 4;
ArrayList<int[]>buffer=new ArrayList<int[]>();
boolean start=false;
boolean fixed=true;
int n=0;
int up_limit=120;
float a=0;


void setup() {

  // Rendering in P3D
  size(800, 600, P3D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();


  //load shaders
  sh = loadShader("frag.glsl", "vert.glsl");

  PGL pgl = beginPGL();

  IntBuffer intBuffer = IntBuffer.allocate(1);
  pgl.genBuffers(1, intBuffer);

  //memory location of the VBO
  vertexVboId = intBuffer.get(0);

  endPGL();

  smooth(16);
}


void draw() {
  background(0);
  set_camera();
  // Translate and rotate
  pushMatrix();
  translate(width/2, height/2, -50);
    // We're just going to calculate and draw every 2nd pixel
    // Get the raw depth as array of integers
    int[] depth = kinect2.getRawDepth();
    add_coco(create_dup(depth));
      depth_circle(16);
      rotateY(a);
      box(50);
    //display_one(depth,new PVector(0,0,-100),0);
    
    
    
  popMatrix();

  fill(255, 0, 0);
  text(frameRate, 50, 50);

  // Rotate
  a += 0.15f;
}

//calculte the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}



void display_one(int[] depth ,PVector p,float rotation){
    for (int x = 0; x < kinect2.depthWidth; x += skip) {
    for (int y = 0; y < kinect2.depthHeight; y += skip*2) {
      int offset = x + y*kinect2.depthWidth;
      int rawDepth = depth[offset];
      if (rawDepth<1400){
      PVector v = depthToPointCloudPos(x, y, rawDepth);
      // Convert kinect data to world xyz coordinate
      stroke(255);
      pushMatrix();
      // Scale up by 200
      rotateY(rotation);
      float factor = 0.2;
      translate(-(v.x)*factor+p.x, (v.y)*factor+p.y, (v.z)*factor+p.z);
      // Draw a point
      point(0, 0);
      popMatrix();
    }
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
      //println(true);
        buffer.remove(0);
    //crazy swapping start
  }
}

void depth_circle(int number){
      float angle_unit=2*PI/(number);
      int frame_stepper=floor(up_limit/float(number));
      
       PVector p=new PVector(300,0,0);
       for (int i=0;i<number;i++){
         if (start==false||fixed==true){
         display_one(buffer.get(buffer.size()-1),p,angle_unit*i);
         }else{
         display_one(buffer.get(frame_stepper*i),p,angle_unit*i);
         }
       }
}

int[] create_dup(int [] input){
  int[] temp_return=new int[input.length];
  for (int i=0;i<input.length;i++){
    temp_return[i]=input[i];
  }
  
  return temp_return;
}

void set_camera(){
beginCamera();
camera();
rotateX(-PI/6);
endCamera(); 
}

void keyPressed(){
  if (keyPressed && key=='1'){
    fixed=!fixed;
  }
  
  
}