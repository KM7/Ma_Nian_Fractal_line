class Swarms{
   PVector goal;
   SwarmUnit[] fishes;
   int swarmVolume;
   int spread;
   float c1=0.6;
   float c2=0.6;
   float c3=0.6;
   float w= 0.8;
   float[] fitness;
   PVector pi_best;
   PVector pg_best;

   
   
   Swarms(PVector goal,int swarmVolume,int spread){
     this.goal=goal;
     this.swarmVolume=swarmVolume;
     this.spread=spread;
     this.fishes=new SwarmUnit[swarmVolume];
     this.fitness=new float[swarmVolume];
     this.pg_best=PVector.random3D();
     initialize();
     evaluate_fitness();
     update_temp_best();
   }
   
   PVector getBest(){
     return pg_best;
   }
   
   void initialize(){
     //random generate initial positions rand random vectors
     for (int i=0;i<swarmVolume;i++){
       fishes[i]=new SwarmUnit(PVector.random3D().mult(spread),PVector.mult(PVector.random3D(),(random(1))));
     }
   }
   
   void evaluate_fitness(){
     for (int i=0;i<swarmVolume;i++){
       fitness[i]=evalueate_single_fitness(fishes[i].getPosition());
     }
   }
   
   float evalueate_single_fitness(PVector input){
     return goal.dist(input); 
   }
   
   void vector_update(){
       //print(pi_best);
       for (int i=0;i<fishes.length;i++){
       float r1=random(1);
       float r2=random(1);
       float r3=random(1);
       //split the function into 3 parts
       //println(fishes[i].getVector());
       PVector v1=PVector.mult(fishes[i].getVector(),w);
       PVector v2=PVector.mult(PVector.sub(pi_best,fishes[i].getPosition()),c1*r1);
       PVector v3=PVector.mult(PVector.sub(pg_best,fishes[i].getPosition()),c2*r2);
       PVector v4=PVector.mult(PVector.sub(fishes[int(random(swarmVolume))].getPosition(),fishes[i].getPosition()),c3*r3);
       PVector newVector=v1.add(v2.add(v3).add(v4));
       //println("v1"+v1+v2+v3);
       //println("r1"+r1+"r2"+r2+newVector);
       fishes[i].new_vector(handicap(newVector));
       fishes[i].update();
     }
   }
   
   void update_temp_best(){
     //first, transfer the previous best replace the one before
     pi_best=pg_best;
     int temp_index=0;
     //then find the current best fitness index
    for (int i=0;i<swarmVolume;i++){
      if (fitness[i]<fitness[temp_index]){
       temp_index=i; 
      }
    }
     pg_best=fishes[temp_index].getPosition();
    // println("best_fitness"+fitness[pg_best]+"index of: "+pg_best+"position is"+fishes[pg_best].getPosition()+"vector is"+fishes[pg_best].getVector());
   }
   
   
   void update(){
     vector_update();
     evaluate_fitness();
     update_temp_best();
   }
   
   
   void draw(){
     for (int i=0;i<fishes.length;i++){
       fishes[i].draw();
     }
     
   }
   
  void change_goal(PVector input){
    this.goal=input;
  }  
  
  PVector handicap(PVector input){
    if (input.x>spread/2){
      input.x=spread/2;
    }else if (input.x<-spread/2){
      input.x=-spread/2;
    }
      if (input.y>spread/2){
      input.x=spread/2;
    }else if (input.y<-spread/2){
      input.y=-spread/2;
    }
      if (input.z>spread/2){
      input.z=spread/2;
    }else if (input.z<-spread/2){
      input.z=-spread/2;
    }
    
    return input;
    
    
  }
}