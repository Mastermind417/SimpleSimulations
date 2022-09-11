int[] blue = {79, 77, 255};

class Water{
  PVector position;
  int[] colour;
  String name;
  int size = gridSpacing;
  String direction;
  String type = "water";
  
  boolean shouldStopMoving;
  int numberOfTimesSideWasHit;
  
  Water(int x, int y){
    position = new PVector(x,y);
    colour = blue;
    name = new String("water" + water.size());
    assignRandomDirection();
    
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
    //PVector posSide = lPos;
    //PVector posOppSide = rPos;
    //direction = "left";
    if(r < 0.5){
      firstPosDown= drPos;
      secondPosDown = dlPos;
      ////posSide = rPos;
      ////posOppSide = lPos;
      //direction = "right";
    }
    
    //if(direction == null) assignRandomDirection();
    
    PVector[] posSides = new PVector[]{lPos, rPos};
    PVector posSide = findAppropriatePosSide(posSides, true);
    PVector posOppSide = findAppropriatePosSide(posSides, false);
    
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
    for(Pixel p : occupiedPixels){
      PVector pixelPos = p.position;
      if(pos.y == pixelPos.y && pos.x == pixelPos.x) return false;
    }
    
    //occupiedPixels.remove(new Pixel(position, type));
    boolean hitsBottom = pos.y == height-size; 
    if(hitsBottom) stopParticleAtPosition(pos);
    
    position = pos;
    //occupiedPixels.add(position);
    return true;
  }
  
  boolean checkSidePositionIsUnoccupiedAndUpdate(PVector pos){
    
    for(Pixel p : occupiedPixels){
      PVector pixelPos = p.position;
      boolean hitsOccPixel = pos.x == pixelPos.x && pos.y == pixelPos.y; 
      if(hitsOccPixel) {
        stopParticleAtPosition(pos);
        //changeDirection();
        //numberOfTimesSideWasHit++;
        return false;
      }
    }
    
    //occupiedPixels.remove(new Pixel(position, type));
    
    //boolean hitsBottom = pos.y == height-size; 
    //if(hitsBottom) stopParticleAtPosition(pos);
    
    boolean hitsEdge = pos.x == 0 || pos.x == width-size;
    if(hitsEdge) {
      stopParticleAtPosition(pos);
      //changeDirection();
      //occupiedPixels.add(pos);
    }
    
    boolean waterParticleExhausted = numberOfTimesSideWasHit >= 5;
    if(waterParticleExhausted) stopParticleAtPosition(pos);
    
    position = pos;
    //occupiedPixels.add(position);
    
    return true;

  }
  
  void stopParticleAtPosition(PVector pos){
    shouldStopMoving = true;
    occupiedPixels.add(new Pixel(pos, type, name));
    
    Pixel lastOP = occupiedPixels.get(occupiedPixels.size()-1);
    lastOP.log();
  }
  
  PVector findAppropriatePosSide(PVector[] posSides, boolean sameDir){
    PVector posSide = new PVector();
    
    // resolve whether give posSide in same direction or opposite
    int nl = 0;
    int nr = 1;  
    if(!sameDir){ // switch
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
  
  void assignRandomDirection(){
    float r = random(0,1);
    if(r < 0.5) direction = "left";
    else direction = "right";
  }
}
