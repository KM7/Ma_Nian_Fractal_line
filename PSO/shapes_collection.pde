void draw_arrow(PVector location, PVector direction,float size){
 //PVector currentDirection=new PVector(0,0,1);
 //println(direction);
 //direction=direction.sub(currentDirection);
 
pushMatrix();
translate(location.x, location.y, location.z);
rotateZ(direction.z);
rotateY(direction.y);
rotateX(direction.x);


//rotateZ(-PI);
beginShape();
vertex(-size, -size, 0);
vertex( size, -size, 0);
vertex(   0,    0,  size);

vertex( size, -size, 0);
vertex( size,  size, 0);
vertex(   0,    0,  size);

vertex( size, size, 0);
vertex(-size, size, 0);
vertex(   0,   0,  size);

vertex(-size,  size, 0);
vertex(-size, -size, 0);
vertex(   0,    0,  size);
endShape(); 

beginShape();

vertex(-size,  -size, 0);
vertex(+size, -size, 0);
vertex(+size, +size, 0);
vertex(-size, +size, 0);


endShape(); 
translate(0,0, -size);

box(size/2,size/2,-size*2);

 popMatrix() ;
}


PVector rotate3DX(PVector input,float q){
  float y=input.y*cos(q)-input.z*sin(q);
  float z=input.y*sin(q)+input.z*cos(q);
  float x=input.x;
  return new PVector(x,y,z);
}

PVector rotate3DY(PVector input,float q){
  float z=input.z*cos(q)-input.x*sin(q);
  float x=input.z*sin(q)+input.x*cos(q);
  float y=input.y;
  return new PVector(x,y,z);
}
PVector rotate3DZ(PVector input,float q){
  float x=input.x*cos(q)-input.y*sin(q);
  float y=input.x*sin(q)+input.y*cos(q);
  float z=input.x;
  return new PVector(x,y,z);
}