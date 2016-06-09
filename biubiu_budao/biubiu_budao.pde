Budao biubiu;

void setup(){
  size(800,800,P2D);
  biubiu=new Budao(50,0.005,new PVector(width/4,height/2));
  
}

void draw(){
background(255);
if (!mousePressed){
biubiu.update();
}else{
biubiu.kickit(new PVector(mouseX,mouseY));
}
biubiu.draw_skeleton();


}

void mousePressed(){
  
}