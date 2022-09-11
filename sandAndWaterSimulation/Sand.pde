int[] gold = {234, 167, 31};

class Sand{
  PVector position;
  int[] colour;
  String name;
  int size = gridSpacing;
  String type = "sand";
  
  boolean shouldStopMoving;
  
  Sand(int x, int y){
    position = new PVector(x,y);
    colour = gold;
    shouldStopMoving = false;
    name = new String("sand" + sand.size());
  }
  
  void update(){
    if(shouldStopMoving) return;
    
    // d is the pixel immediately underneath the pixel, l is the pixel immediately underneath and to the left
    // and r is the pixel immediately underneath the pixel and to the right
    PVector dPos = new PVector(position.x,position.y+size);
    PVector lPos = new PVector(position.x-size,position.y+size);
    PVector rPos = new PVector(position.x+size,position.y+size);
    
    // this is to randomise how the particles fall left and right
    float r = random(0,1);
    PVector firstPos = lPos;
    PVector secondPos = rPos;
    if(r < 0.5){
      firstPos = rPos;
      secondPos = lPos;
    }
    
    // piling algorithm
    
    PVector pos = null;
    
    if( checkPosition(dPos) ) pos = dPos;
    else if( checkPosition(firstPos) ) pos = firstPos;
    else if( checkPosition(secondPos) ) pos = secondPos;
    else stopParticleAtPosition(position);
    
    updatePosition(pos);
  }
  
  void display(int[] colour){
    fill(colour[0], colour[1], colour[2]);
    rect(position.x, position.y,size,size);   
  }
  
  boolean checkPosition(PVector pos){
    for(Pixel p : occupiedPixels){
      PVector pixelPos = p.position;
      if(pos.y == pixelPos.y && pos.x == pixelPos.x) return false;
    }
    return true;
  }
  
  void updatePosition(PVector pos){
    if(pos == null) return;
    
    boolean hitsEdge = pos.x == 0+size || pos.x == width-2*size;
    
    boolean hitsBottom = pos.y == height-size; 
    if(hitsBottom || hitsEdge) stopParticleAtPosition(pos);
    
    position = pos;
  }
  
  void stopParticleAtPosition(PVector pos){
    shouldStopMoving = true;
    occupiedPixels.add(new Pixel(pos, type, name));
  }

}
