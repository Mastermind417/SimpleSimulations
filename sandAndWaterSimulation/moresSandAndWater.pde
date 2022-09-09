ArrayList<Sand> sand; 
ArrayList<Water> water;

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
  
  for(Water w : water){
    w.display(w.colour);
    w.update();
  }
}
