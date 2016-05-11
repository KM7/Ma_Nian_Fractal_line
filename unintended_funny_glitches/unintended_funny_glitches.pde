int num=100;

void setup(){
size(800, 800, P3D);
background(255);
  
}


void draw(){
background(255);
beginShape();
vertex(mouseX, mouseY);
PVector tempVector=new PVector (random(width),random(height),random(100));
for (int i=0;i<100;i++){
quadraticVertex(mouseX, mouseY,0, tempVector.x, tempVector.y,tempVector.z);
tempVector=new PVector (random(width),random(height),random(100));
vertex(tempVector.x, tempVector.y,tempVector.z);

}
endShape();
  
}