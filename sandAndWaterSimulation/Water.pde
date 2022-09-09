int[] blue = {79, 77, 255};

class Water{
  PVector position;
  int[] colour;
  String name;
  int size = gridSpacing;
  String direction;
  
  boolean shouldStopMoving;
  int numberOfTimesSideWasHit;
  
  Water(int x, int y){
    position = new PVector(x,y);
    colour = blue;
    name = new String("sand" + sand.size());
    direction = "left";
    
    shouldStopMoving = false;
    numberOfTimesSideWasHit = 0;
  }
  
  void update(){
    if(shouldStopMoving) return;
    
    // d is the pixel immediately underneath the pixel, dl is the pixel immediately underneath and to the left
    // and dr is the pixel immediately underneath the pixel and to the right
    PVector dPos = new PVector(position.x,position.y+size);
    PVector dlPos = new PVector(position.x-size,position.y+size);
    PVector drPos = new PVector(position.x+size,position.y+size);
    
    PVector lPos = new PVector(position.x-size, position.y);
    PVector rPos = new PVector(position.x+size, position.y);
    
    // this is to randomise how the particles fall left and right
    float r = random(0,1);
    PVector firstPosDown = dlPos;
    PVector secondPosDown = drPos;
    PVector posSide = lPos;
    PVector posOppSide = rPos;
    direction = "left";
    if(r < 0.5){
      firstPosDown= drPos;
      secondPosDown = dlPos;
      posSide = rPos;
      posOppSide = lPos;
      direction = "right";
    }
    
    //generateRandomDirection();
    
    //PVector[] posSides = new PVector[]{lPos, rPos};
    //PVector posSide = findAppropriatePosSide(posSides, true);
    //PVector posOppSide = findAppropriatePosSide(posSides, false);
    
    // piling algorithm
    // down
    if( checkDownPositionIsUnoccupiedAndUpdate(dPos) ); 
    else if( checkDownPositionIsUnoccupiedAndUpdate(firstPosDown) );
    else if( checkDownPositionIsUnoccupiedAndUpdate(secondPosDown) );
    
    // side
    else if ( checkSidePositionIsUnoccupiedAndUpdate(posSide) );
    else if ( checkSidePositionIsUnoccupiedAndUpdate(posOppSide) );
       
    // stationary
    else stopParticleAtPosition(position);
  }
  
  void display(int[] colour){
    fill(colour[0], colour[1], colour[2]);
    rect(position.x, position.y,size,size);   
  }
  
  boolean checkDownPositionIsUnoccupiedAndUpdate(PVector pos){
    for(PVector pixel : occupiedPixels){
      if(pos.y == pixel.y && pos.x == pixel.x) return false;
    }
    
    occupiedPixels.remove(position);
    boolean hitsBottom = pos.y == height-size; 
    if(hitsBottom) stopParticleAtPosition(pos);
    
    position = pos;
    occupiedPixels.add(position);
    return true;
  }
  
  boolean checkSidePositionIsUnoccupiedAndUpdate(PVector pos){
    for(PVector pixel : occupiedPixels){
      boolean hitsOccPixel = pos.x == pixel.x && pos.y == pixel.y; 
      if(hitsOccPixel) {
        changeDirection();
        numberOfTimesSideWasHit++;
        return false;
      }
    }
    
    occupiedPixels.remove(position);
    
    boolean hitsBottom = pos.y == height-size; 
    if(hitsBottom) stopParticleAtPosition(pos);
    
    boolean hitsEdge = pos.x == 0-size || pos.x == width+size;
    if(hitsEdge) {
      changeDirection();
      occupiedPixels.add(pos);
    }
    
    boolean waterParticleExhausted = numberOfTimesSideWasHit >= 100;
    if(waterParticleExhausted) stopParticleAtPosition(pos);
    
    position = pos;
    occupiedPixels.add(position);
    
    return true;

  }
  
  void stopParticleAtPosition(PVector pos){
    shouldStopMoving = true;
    occupiedPixels.add(pos);
  }
  
  PVector findAppropriatePosSide(PVector[] posSides, boolean sameDir){
    PVector posSide = new PVector();
    
    // resolve whether give posSide in same direction or opposite
    int nl = 0;
    int nr = 1;  
    if(!sameDir){
      nl = 1;
      nr = 0;
    }
       
    if(direction == "left") posSide = posSides[nl];
    else posSide = posSides[nr];
    
    return posSide;
  }
  
  void changeDirection(){
    if(direction == "left") direction = "right";
    else direction = "left";
  }
  
  void generateRandomDirection(){
    float r = random(1);
    if(r < 0.5) direction = "left";
    direction = "right";
  }
}
