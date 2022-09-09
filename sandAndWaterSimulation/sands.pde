ArrayList<Sand> sands; 

void createSand(){
  int posx = mouseX - mouseX % gridSpacing;
  int posy = mouseY - mouseY % gridSpacing;
    
  Sand s = new Sand(posx,posy);
  s.display(s.colour);
  sands.add(s);
}

void showSand(){
  strokeWeight(1);
  noStroke();
  
  if(sands == null || sands.size() == 0) return;
  
  for(Sand s : sands){
    s.display(s.colour);
    s.update();
  }
}
