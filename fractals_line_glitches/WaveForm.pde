void temp_draw_function(int size){
pushMatrix();
  translate(0, height/2, 0);
float[] temp_f=vizAudio.getValue(size);
int temp_block_size=width/size;
for (int i=0;i<temp_f.length-1;i++){
line(i*temp_block_size,temp_f[i]*temp_block_size,(i+1)*temp_block_size,temp_f[i+1]*temp_block_size);
}
  popMatrix();

}