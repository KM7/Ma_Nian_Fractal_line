float x=0;
float grid_size=50;
float depth=-500;
PVector location=new PVector(0,0,0);
Swarms swarm=new Swarms(location,3000,100);

void setup(){
 size(1000,500,P3D);
 fill(0);
 stroke(255);
 frameRate(30);
}

void draw(){
//lights();
background(0);
text("My reaction towards social media these days",0,0,width,200);
beginCamera();
camera();
translate(0,0,-500);
endCamera();
fill(20,140,20);

pushMatrix();
translate(0,0,500);
draw_training_room();
popMatrix();

translate(width/2,height/2);
fill(122,23,12);

box(20);
float x=modelX(mouseX,mouseY,0);
float y=modelY(mouseX,mouseY,0);
//println(x,y);
fill(22,23,122);

swarm.draw();
swarm.change_goal(new PVector(mouseX-width/2,mouseY-height/2,250));
swarm.update();

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