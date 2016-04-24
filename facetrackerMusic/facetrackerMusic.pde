import oscP5.*;
OscP5 oscP5;
import themidibus.*; //Import the library
// num faces found
MidiBus myBus;
int found;
boolean mouthFlag = false;
// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();
int note_length_ms=20;
// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;

void setup() {
  size(640, 480);
  frameRate(30);

  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
  myBus = new MidiBus(this, -1, "IAC Bus 2"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  thread("midi_thread");
}

void draw() {  
  background(255);
  stroke(0);
  //trigger_midi(22);
  if(found > 0) {
    translate(posePosition.x, posePosition.y);
    scale(poseScale);
    noFill();
    ellipse(-20, eyeLeft * -9, 20, 7);
    ellipse(20, eyeRight * -9, 20, 7);
    ellipse(0, 20, mouthWidth* 3, mouthHeight * 3);
    ellipse(-5, nostrils * -1, 7, 3);
    ellipse(5, nostrils * -1, 7, 3);
    rectMode(CENTER);
    fill(0);
    rect(-20, eyebrowLeft * -5, 25, 5);
    rect(20, eyebrowRight * -5, 25, 5);
    if(mouthHeight> 5){
      
      mouthFlag = true;
    }
  }
}
void midibus(){
  if(mouthHeight >5){
    println(mouthHeight);
    trigger_midi(mouthHeight);
  }else{
   delay(note_length_ms); 
  }
}
// OSC CALLBACK FUNCTIONS

public void found(int i) {
  //println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  //println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
  //println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  //println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  //println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  //println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  //println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  //println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  //println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  //println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  //println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  //println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if(m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}

void trigger_midi(float input){
  //midi on
  int k=int(map(input,0,15,0,127));
    println(input,k);

  println("midi on");
      myBus.sendNoteOn(1, k, 127);
delay(note_length_ms);
  println("midi off");
//midi off
     myBus.sendNoteOff(1, k, 127);

  
}

void midi_thread(){
  while (true){
    delay(100);
      midibus();
  }
  
}