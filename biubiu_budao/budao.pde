class Budao{
  int size;
  float direction;
  float speed;
  float vector;
  float rFactor;
  float fraction=0.99;
  PVector location;
  Budao(int size,float rFactor,PVector location){
  this.size=size;
  this.rFactor=rFactor;
  this.location=location;
  }
  
  void kickit(PVector direction){
    direction.sub(location);
    direction.normalize();
    
    float tempDirection=PVector.angleBetween(direction,(new PVector(0,-1)));
    if (direction.x<0){
    this.direction=-tempDirection;
    }else{
    this.direction=tempDirection;
    }
    speed=0;
  }
  
  void update(){
    vector=-direction*rFactor;
    speed=(speed+vector)*fraction;
    direction=direction+speed;
  }
  
  void draw_skeleton(){
    translate(location.x,location.y);
    rotate(direction);
    rect(-size/4,-size*3,size/2,size*3);
    ellipse(0,0,size,size);
  }
  
}