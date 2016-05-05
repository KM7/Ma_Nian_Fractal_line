import processing.video.*;

Movie myMovie;

ArrayList<PImage> buffer=new ArrayList<PImage>();
int n=0;
int upper_bound=12;
int switch_num=0;

void setup() {
  size(1280, 360);
  myMovie = new Movie(this, "movie.mov");
  myMovie.loop();
  buffer.add(get());

}

void draw() {
  
  PImage tempimg=myMovie.get(myMovie.width/2,0,5,myMovie.height);
  
  image(tempimg, 0, 0,5,height);
  image(buffer.get(buffer.size()-1), 1, 0,width,height);
   loadPixels();
   update_time();
   buffer.add(get());
   pastFusion();
   //image(myMovie, 0, 0);

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

void movieEvent(Movie m) {
  m.read();
}