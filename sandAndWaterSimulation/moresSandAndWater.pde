ArrayList<Sand> sand; 
ArrayList<Water> water;

ArrayList<Pixel> occupiedPixels;

class Pixel{
  String type;
  PVector position;
  String particleName;
  
  Pixel(PVector pos, String type_, String name){
    type = type_;
    position = pos;
    particleName = name; 
  }
  
  void log(){
    logger.println("Pixel occupied at: (" + position.x + ", " + position.y + ") by: " + particleName + " [ " + time + " ]");
    logger.flush();
  }
}

void createSand(){
  if(!sandOn) return;
  
  int posx = mouseX - mouseX % gridSpacing;
  int posy = mouseY - mouseY % gridSpacing;
    
  Sand s = new Sand(posx,posy);
  s.display(s.colour);
  sand.add(s);
}

void showSand(){
  strokeWeight(1);
  noStroke();
  
  if(sand == null || sand.size() == 0) return;
  
  for(Sand s : sand){
    s.display(s.colour);
    s.update();
  }
}

void createWater(){
  if(sandOn) return;
  
  int posx = mouseX - mouseX % gridSpacing;
  int posy = mouseY - mouseY % gridSpacing;
    
  Water w = new Water(posx,posy);
  w.display(w.colour);
  water.add(w);
}

void showWater(){
  strokeWeight(1);
  noStroke();
  
  if(water == null || water.size() == 0) return;
  
  
  for(int i = water.size()-1;i>=0;i--){
    Water w = water.get(i);  
    w.display(w.colour);
    w.update();

  }
  
  //for(Water w : water){
  //  w.display(w.colour);
  //  w.update();
  //}
}
