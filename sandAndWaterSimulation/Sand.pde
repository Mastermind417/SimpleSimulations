int[] gold = {234, 167, 31};

class Sand{
  PVector position;
  int[] colour;
  String name;
  int size = gridSpacing;
  
  boolean shouldStopMoving;
  
  Sand(int x, int y){
    position = new PVector(x,y);
    colour = gold;
    shouldStopMoving = false;
    name = new String("sand" + sands.size());
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
    if( checkPositionIsUnoccupiedAndUpdate(dPos) );
    else if( checkPositionIsUnoccupiedAndUpdate(firstPos) );
    else if( checkPositionIsUnoccupiedAndUpdate(secondPos) );
    else stopParticleAtPosition(position);
  }
  
  void display(int[] colour){
    fill(colour[0], colour[1], colour[2]);
    rect(position.x, position.y,size,size);   
  }
  
  boolean checkPositionIsUnoccupiedAndUpdate(PVector pos){
    for(PVector pixel : occupiedPixels){
      if(pos.y == pixel.y && pos.x == pixel.x) return false;
    }
    
    boolean hitsBottom = pos.y == height-size; 
    if(hitsBottom) stopParticleAtPosition(pos);
    
    position = pos;
    return true;
  }
  
  void stopParticleAtPosition(PVector pos){
    shouldStopMoving = true;
    occupiedPixels.add(pos);
  }

}
