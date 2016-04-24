class SwarmUnit{
  PVector position;
  PVector vector;
  
 SwarmUnit(PVector position,PVector vector){
   this.position=position;
   this.vector=vector;
 }
 
 void draw(){
   pushMatrix();
   translate(position.x,position.y,position.z);
   box(20);
   popMatrix();
 }
  
 PVector getPosition(){
   
   return this.position;
 }
  
 PVector getVector(){
   
  return this.vector; 
 }
 
 void new_vector(PVector new_vector){
   this.vector=new_vector;
 }
 
 void update(){
   position.add(vector);
 }
  
  
}