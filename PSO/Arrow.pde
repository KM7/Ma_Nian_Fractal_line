class Particle {
  PVector location;
  PVector orientation;
  PVector linear_velocity;
  PVector angular_velocity;
  float size;
  
  Particle(PVector location,PVector orientation,PVector linear_velocity,PVector angular_velocity,float size){
    this.location=location;
    this.orientation=orientation;
    this.linear_velocity=linear_velocity;
    this.angular_velocity=angular_velocity;
    this.size=size;
  }
  
  
  void draw(){
    draw_arrow(location,orientation,20);
  }
  
  PVector get_rotation(){
    pushMatrix();
    rotateZ(orientation.z);
    rotateY(orientation.y);
    rotateX(orientation.x);
    float x=modelX(linear_velocity.x,linear_velocity.y,linear_velocity.z);
    float y=modelY(linear_velocity.x,linear_velocity.y,linear_velocity.z);
    float z=modelZ(linear_velocity.x,linear_velocity.y,linear_velocity.z);
    popMatrix();
    return new PVector(x,y,z);
  }
  
  void update(){
   // println(location);
    //println("V_CHANGE"+linear_velocity);
    orientation.x=angle_normalize(orientation.x+angular_velocity.x);
    orientation.y=angle_normalize(orientation.y+angular_velocity.y);
    orientation.z=angle_normalize(orientation.z+angular_velocity.z);
    //println(orientation);
    PVector temp_location_change=get_rotation();
   // println("rotate",temp_location_change);
   //  println("orientation",orientation);
    
    location.x=location.x+temp_location_change.x;
    location.y=location.y+temp_location_change.y;
    location.z=location.z+temp_location_change.z;
  }
  
}