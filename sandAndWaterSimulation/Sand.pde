int[] gold = {234, 167, 31};

class Sand{
  PVector position;
  int[] colour;
  int size = gridSpacing;
  
  Sand(int x, int y){
    position = new PVector(x,y);
    colour = gold;
  }
  
  void update(){
    PVector dPos = new PVector(position.x,position.y+size);
    PVector lPos = new PVector(position.x-size,position.y+size);
    PVector rPos = new PVector(position.x+size,position.y+size);
    
    if( checkPositionIsOccupied(dPos) ) return;
    if( checkPositionIsOccupied(lPos) ) return;
    if( checkPositionIsOccupied(rPos) ) return;
    
  }
  
  void display(int[] colour){
    fill(colour[0], colour[1], colour[2]);
    rect(position.x, position.y,size,size);   
  }
  
  boolean checkPositionIsOccupied(PVector pos){
    for(PVector pixel : occupiedPixels){
      if(pos == pixel) return false;
    }
    
    if(pos.y == height){
      occupiedPixels.add(position);
      return false;
    } 
    
    position = pos;
    occupiedPixels.add(position);
    return true;

  }

}
