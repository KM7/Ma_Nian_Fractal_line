class NoiseMom{
  NoiseBoy[] boys;
  
  NoiseMom(int boysvolume){
    boys=new NoiseBoy[boysvolume];
    for (int i=0;i<boys.length;i++){
    boys[i]=new NoiseBoy(); 
    }
  }
  // create a new noise boy to handle noise
   int newBoy(int pitch,int x,int y){
     int tempIndex=check_index();
     if (tempIndex!=-1){
     boys[check_index()]=new NoiseBoy(pitch,x,y,tempIndex);
     }
     return tempIndex;
   }
   
   //loop though boys to get it working
   void playBoy(){
     
   }
   
   int check_index(){
     int temp_return=-1;
     for (int i=0;i<boys.length;i++){
       if (!boys[i].isActive()){
         temp_return=i;
         break;
       }
     }
     return temp_return;
   }
  
}