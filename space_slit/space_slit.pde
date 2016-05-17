import processing.video.*;

Movie myMovie;

ArrayList<color []> buffer=new ArrayList<color []>();
int n=0;
int switch_num=0;
int lines=640;
int upper_bound=320;
int single_height;
int[] time=new int[lines];
int applys;
boolean horizontal=false;
boolean debug=false;


void setup() {
  size(1280, 720);
  myMovie = new Movie(this, "720.mov");
  myMovie.loop();
  if (horizontal){
  single_height=height/lines;
  println("height "+height+" "+"lines "+lines+"single height "+single_height);
  applys=height;
  }else{
  single_height=width/lines;
  println("height "+width+" "+"lines "+lines+"single height "+single_height);
  applys=width;
  }
  generate_timeline();
  //shuffle_timeline();
}

void draw() {
  myMovie.loadPixels();
  update_time();
  if (n>upper_bound){
        loadPixels();
        
  for (int i=0;i<lines;i++){
   //println(i*single_height);
  draw_it(i*single_height,single_height,time[i],horizontal);
  }
      updatePixels();
  }
  
  //shuffle_it();
  buffer.add(myMovie.pixels.clone());
  
  if (debug){
    background(255);
      for (int i=0;i<time.length;i++){
       point(i,time[i]);
      }
  }
  
}

void draw_it(int start,int theight,int frame_num,boolean vertical){
if (vertical){
  int temp_w=start+theight;
  if (start+theight>height){
    temp_w=height;
  }
  
   for (int i=0;i<myMovie.width;i++){
     for(int j=start;j<temp_w;j++){
       //pixels[j*width+i]=color(22,3,3);
       pixels[j*width+i]=buffer.get(frame_num)[j*myMovie.width+i];
     }
  } 
  
}else{
    int temp_h=start+theight;
  if (start+theight>width){
    temp_h=width;
  }
  
     for (int i=start;i<temp_h;i++){
     for(int j=0;j<myMovie.height;j++){
       //pixels[j*width+i]=color(22,3,3);
       pixels[j*width+i]=buffer.get(frame_num)[j*myMovie.width+i];
     }
  } 
}
}

void update_time(){
if (n<=upper_bound){
n=n+1;
}else{
 buffer.remove(0); 
}
}

void keyPressed() {
  if (key == 'k'||key=='K') {
    shuffle_timeline();
  }   
  
  if (key == 's'||key=='S') {
    generate_timeline();
  } 
  
   if (key == 'g'||key=='G') {
    gaussien_timeline();
  } 
  
     if (key == 'd'||key=='D') {
    debug=!debug;
  } 
  
  
}

void movieEvent(Movie m) {
  m.read();
}

void shuffle_it(){
  if (frameCount%30==0){
     shuffle_timeline();
  } 
}

void shuffle_timeline(){
for (int i=0;i<time.length;i++){
    time[i]=int(random(upper_bound-1));
  }
}

void generate_timeline(){
 int steps=upper_bound/lines;
 println(steps);
 for (int i=0;i<time.length;i++){
   if(i*steps>=upper_bound-1){
      time[i]=upper_bound-1;
      println(time[i]);
   }else{
    time[i]=i*steps;
   }
 }
}


void gaussien_timeline(){
  
  for (int i=0;i<time.length;i++){
    time[i]=int((float)normValue(i,time.length/2,30,upper_bound-1));
  }

}

void mousePressed(){
int std=int(map(mouseY,0,height,0,height/2));
int mean=int(map(mouseX,0,width,1,time.length-1));

  for (int i=0;i<time.length;i++){
    time[i]=int((float)normValue(i,mean,std,upper_bound-1));
  }
}


double normValue(float x, float Mean, float StdDev,float value){
  double peak=NormalDensityZx(x,x,StdDev);
  double rscale=value/peak;
  return NormalDensityZx(x,Mean,StdDev)*rscale;
}

double NormalDensityZx(float x, float Mean, float StdDev ) {
    float a = x - Mean;
    return (Math.exp( -( a * a ) / ( 2 * StdDev * StdDev ) ) / ( Math.sqrt( 2 * Math.PI ) * StdDev ));
}