import processing.video.*;

Movie myMovie;

ArrayList<color []> buffer=new ArrayList<color []>();
int n=0;
int upper_bound=240;
int switch_num=0;
int lines=10;
int single_height;
int[] time=new int[lines];

void setup() {
  size(480, 480);
  myMovie = new Movie(this, "movie.mov");
  myMovie.loop();
  single_height=height/lines;
  shuffle_timeline();
  
}

void draw() {
  myMovie.loadPixels();
  update_time();
  if (n==upper_bound){
        loadPixels();
        
  for (int i=0;i<lines;i++){
   //println(i*single_height);
  draw_it(i*single_height,single_height,time[i],false);
  }
      updatePixels();
  }
  shuffle_it();
  buffer.add(myMovie.pixels.clone());
}

void draw_it(int start,int theight,int frame_num,boolean vertical){
if (vertical){
   for (int i=0;i<myMovie.width;i++){
     for(int j=start;j<start+theight;j++){
       //pixels[j*width+i]=color(22,3,3);
       pixels[j*width+i]=buffer.get(frame_num)[j*myMovie.width+i];
     }
  } 
  
}else{
     for (int i=start;i<start+theight;i++){
     for(int j=0;j<myMovie.width;j++){
       //pixels[j*width+i]=color(22,3,3);
       pixels[j*width+i]=buffer.get(frame_num)[j*myMovie.width+i];
     }
  } 
}
}

void update_time(){
if (n<upper_bound){
n=n+1;
}else{
 buffer.remove(0); 
}
}

/**
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

**/
void keyPressed() {
  if (key == 'k'||key=='K') {
    shuffle_timeline();
  } 
  
}

void movieEvent(Movie m) {
  m.read();
}

void shuffle_it(){
  if (frameCount%3==0){
     shuffle_timeline();
  } 
}

void shuffle_timeline(){
  
for (int i=0;i<time.length;i++){
    time[i]=int(random(upper_bound-1));
  }
}