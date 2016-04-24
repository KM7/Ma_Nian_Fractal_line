import themidibus.*; //Import the library
ArrayList<Particle> pts;
boolean onPressed, showInstruction;
PFont f;
NoiseMom nmom=new NoiseMom(8);
MidiBus myBus;



void setup() {
  size(720, 720, P2D);
  smooth();
  frameRate(30);
  colorMode(HSB);
  rectMode(CENTER);
  myBus = new MidiBus(this, -1, "IAC Bus 2"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  pts = new ArrayList<Particle>();
 
  background(255);
}
 
void draw() {
 //background(255);
  if (onPressed) {
     Particle newP = new Particle(mouseX, mouseY, pts.size(), pts.size());
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