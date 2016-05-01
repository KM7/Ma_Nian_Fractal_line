import themidibus.*; //Import the library
import org.openkinect.freenect.*;
import org.openkinect.processing.*;

ArrayList<Particle> pts;
boolean onPressed, showInstruction;
PFont f;
NoiseMom nmom=new NoiseMom(8);
MidiBus myBus;
float a=0;
float depth=-500;
float grid_size=50;
float factor = 500;


KinectTracker tracker;
Kinect kinect;

float[] depthLookUp = new float[2048];


void setup() {
    size(800, 600, P3D);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
    // Lookup table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  smooth();
  frameRate(30);
  colorMode(HSB);
  rectMode(CENTER);
  myBus = new MidiBus(this, -1, "IAC Bus 2"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  pts = new ArrayList<Particle>();
 
  background(0);
}
 
void draw() {
background(0);
beginCamera();
camera();
rotateX(a);
endCamera();
draw_training_room();
tracker.track();
translate(width/2, height/2, -50);
draw_cloud();

  if (onPressed) {
     Particle newP = new Particle(mouseX, mouseY, 0,pts.size(), pts.size());
      pts.add(newP);
  }
 
  for (int i=0; i<pts.size(); i++) {
    Particle p = pts.get(i);
    p.update();
    p.display();
  }
 
  for (int i=pts.size()-1; i>-1; i--) {
    Particle p = pts.get(i);
    if (p.dead) {
      pts.remove(i);
    }
  }
  
    if (key=='n'){
    a=a+0.015f;
  }
   if (key=='m'){
    a=a-0.015f;
  }
}
 
void mousePressed() {
  onPressed = true;
}
 
void mouseReleased() {
  onPressed = false;
}
 
void keyPressed() {
  if (key == 'c') {
    for (int i=pts.size()-1; i>-1; i--) {
      Particle p = pts.get(i);
      pts.remove(i);
    }
    background(255);
  }
}

void draw_training_room(){
 fill(0);
 stroke(255);
draw_grid(new PVector(width/2,height/2,depth),new PVector(0,0,0));
draw_grid(new PVector(width/2,height,depth),new PVector(PI/2,0,0));
draw_grid(new PVector(width/2,height,depth/2),new PVector(PI/2,0,0));
draw_grid(new PVector(width/2,0,depth),new PVector(-PI/2,0,0));
draw_grid(new PVector(width/2,0,depth/2),new PVector(-PI/2,0,0));
draw_grid(new PVector(0,height/2,depth),new PVector(0,-PI/2,0));
draw_grid(new PVector(width,height/2,depth),new PVector(0,PI/2,0));  
}

void draw_grid(PVector vector,PVector Ori){
  pushMatrix();

  translate(vector.x,vector.y,vector.z);
  rotateX(Ori.x);
  rotateY(Ori.y);
  rotateZ(Ori.z);
    translate(-width/2,-height/2,0);
    for (int i = 0; i <width; i+=grid_size) {
    for (int j = 0; j < height; j+=grid_size) {
      rect(i,j,grid_size,grid_size);
    }
  }
  popMatrix();
  
}


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

void draw_cloud(){
  pushMatrix();
    int[] depth = tracker.depth;

  // We're just going to calculate and draw every 4th pixel (equivalent of 160x120)
  int skip = 4;

  // Translate and rotate
  for (int x = 0; x < kinect.width; x += skip) {
    for (int y = 0; y < kinect.height; y += skip) {
      int offset = x + y*kinect.width;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      PVector v = depthToWorld(x, y, rawDepth);
      if (rawDepth<800){

      stroke(255);
      pushMatrix();
      // Scale up by 200
      translate(v.x*factor, v.y*factor, factor-v.z*factor);
      // Draw a point
      fill(255);
      box(3);
     
      //point(0, 0);
      popMatrix();
    }
    }
  }
  popMatrix();
  draw_tracker(tracker.getLerpedPos(),depth);
  
}

void draw_tracker(PVector input,int[] depth){
     int x=int(input.x);
     int y=int(input.y);
     int offset = x + y*kinect.width;
      int rawDepth = depth[offset];
      PVector v = depthToWorld(x, y, rawDepth);

      stroke(255);
      pushMatrix();
      // Scale up by 200
      translate(v.x*factor, v.y*factor, factor-v.z*factor);
      // Draw a point
      fill(255,0,0);
        if (true) {
     Particle newP = new Particle(v.x*factor, v.y*factor,factor-v.z*factor, pts.size(), pts.size());
     pts.add(newP);
  }
      //sphere(25);
      popMatrix();
  
}