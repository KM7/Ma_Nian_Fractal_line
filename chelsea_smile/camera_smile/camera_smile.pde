import processing.video.*;

Capture cam;

ArrayList<PImage> buffer=new ArrayList<PImage>();
int n=0;
int upper_bound=12;
int switch_num=0;

void setup() {
  size(1280, 360);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }
     buffer.add(get());

}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  PImage tempimg=cam.get(cam.width/2,0,5,height);
  
  image(tempimg, 0, 0,5,cam.height/2);
  image(buffer.get(buffer.size()-1), 1, 0,width,height);
   loadPixels();
   update_time();
   buffer.add(get());
   pastFusion();
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}

void update_time(){
if (n<upper_bound){
n=n+1;
}else{
 buffer.remove(0); 
}
}


void pastFusion(){
background(255);
//DARKEST DIFFERENCE EXCLUSION MULTIPLY HARD_LIGHT SOFT_LIGHT
  for (int k=0;k<buffer.size();k++){
  switch(switch_num){
      case 0:
  blend(buffer.get(k), 0, 0, width, height, 0, 0, width, height, DARKEST);
  break;
  
      case 1:
  blend(buffer.get(k), 0, 0, width, height, 0, 0, width, height, DIFFERENCE);
  break;
      case 2:
  blend(buffer.get(k), 0, 0, width, height, 0, 0, width, height, EXCLUSION);
  break;
      case 3:
  blend(buffer.get(k), 0, 0, width, height, 0, 0, width, height, MULTIPLY);
  break;
      case 4:
  blend(buffer.get(k), 0, 0, width, height, 0, 0, width, height, HARD_LIGHT);
  break;
      case 5:
  blend(buffer.get(k), 0, 0, width, height, 0, 0, width, height, SOFT_LIGHT);
  break;  
}
  }
}

void keyPressed() {
  if (key == 'k'||key=='K') {
    switch_num =switch_num+1;
    if (switch_num>5){
      switch_num=0;
    }
  } 
  
}