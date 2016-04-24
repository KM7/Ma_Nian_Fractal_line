class NoiseBoy{
  boolean active=false;
  int pitch;
  int x;
  int y;
  int index;
  
  
    
  NoiseBoy(){
    this.pitch=0;
    this.x=0;
    this.y=0;
    this.index=0;
    active=false;
  }
  
  NoiseBoy(int pitch,int x,int y,int index){
    this.pitch=pitch;
    this.x=x;
    this.y=y;
    this.index=index;
    active=true;
  }

  
  boolean isActive(){
    return active;
  }
  
  void playboy(){
  myBus.sendNoteOn(index, pitch, 127);
  }
  
  void kill(){
   active=false;
   myBus.sendNoteOff(index, pitch, 127);
  }
  
}