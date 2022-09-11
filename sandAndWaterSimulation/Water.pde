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
  
  boolean directionFlipped;
  
  Water(int x, int y){
    position = new PVector(x,y);
    colour = blue;
    //colour = new int[]{(int)random(0,255), (int)random(0,255), (int)random(0,255)};
    name = new String("water" + water.size());
    //direction = "left";
    assignRandomDirection();
    
    shouldStopMoving = false;
    numberOfTimesSideWasHit = 0;
    directionFlipped = false;
    
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
    if(r < 0.5){
      firstPosDown= drPos;
      secondPosDown = dlPos;
    }
    
    //if(direction == null) assignRandomDirection();
    
    // direction can be assigned towards where there is 'less' water on the same level
    assignDirection();
    
    PVector[] posSides = new PVector[]{lPos, rPos};
    PVector posSide = findAppropriatePosSide(posSides, true);
    PVector posOppSide = findAppropriatePosSide(posSides, false);
    
    // piling algorithm
    // down
    PVector pos = null; //<>//
    
    if( checkPosition(dPos) ) pos = dPos;
    else if( checkPosition(firstPosDown) ) {
      pos = firstPosDown;
    }
    else if( checkPosition(secondPosDown) ) {
      pos = secondPosDown;
    }
    else if( checkPositionForSide(posSide) ) {
      pos = posSide;
      //findDirection();
    }
    //else if( checkPositionForSide(posOppSide) && directionFlipped ) pos = posOppSide;
    
    else stopParticleAtPosition(position);
    
    updatePosition(pos);
  }
  
  void display(int[] colour){
    fill(colour[0], colour[1], colour[2]);
    rect(position.x, position.y,size,size);   
  }
  
  boolean checkPosition(PVector pos){
    for(int i = occupiedPixels.size() -1 ; i >= 0; i--){
      Pixel p = occupiedPixels.get(i);
      PVector pixelPos = p.position;
      if(pos.y == pixelPos.y && pos.x == pixelPos.x) return false;
    }
    return true;
  }
  
  boolean checkPositionForSide(PVector pos){
    for(int i = occupiedPixels.size() -1 ; i >= 0; i--){
      Pixel p = occupiedPixels.get(i);
      PVector pixelPos = p.position;
      if(pos.y == pixelPos.y && pos.x == pixelPos.x) {
        directionFlipped = true;
        ++numberOfTimesSideWasHit;
        return false;
      }
    }
    return true;
  }
  
  void updatePosition(PVector newPos){
    if(newPos == null) return;
    
    alignDirection(newPos);
    
    boolean hitsEdge = newPos.x == 0+size || newPos.x == width-2*size;
    boolean hitsBottom = newPos.y == height-size; 
    
    if(hitsBottom || hitsEdge) stopParticleAtPosition(newPos);
    
    position = newPos;
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
  
  void alignDirection(PVector newPos){
    if(newPos.x > position.x) direction = "right";
    else if ((newPos.x < position.x)) direction = "left";
  }
  
  void assignDirection(){
    // this function will count for a pixel whether the water particles to the left of the given pixel and to the right until it hits a sand particle
    
    float posx = position.x;
    
    // count of water left and right until closest sand particle
    int waterCountToLeft = 0;
    int waterCountToRight = 0;
    
    // sand pixels closest to position
    float pL = 0;
    float pR = width;    
    
    // find sand pixel closest from the left and to closest from the right
    for(Pixel p : occupiedPixels){
      float pixPosx = p.position.x;
      if(p.type != "sand" && pixPosx > pL && pixPosx < posx){
        pL = pixPosx;
      }
      
      else if(p.type != "sand" && pixPosx < pR && pixPosx > posx){
        pR = pixPosx;
      }
    } 
     
     // count the water particles from position to pL and pR respectively    
     for(Pixel p : occupiedPixels){
       float pixPosx = p.position.x;
       
       if(p.type == "water" && pixPosx > pL && pixPosx < posx){
         ++waterCountToLeft;
       }
       else if(p.type == "water" && pixPosx < pR && pixPosx > posx){
         ++waterCountToRight;
       }
      }
    }
}
