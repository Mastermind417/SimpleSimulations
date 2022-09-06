int holeRadius = 50;
int holeDiameter = 2*holeRadius;

void drawSideEdges(){
  fill(#896215);
  
  int size = holeRadius;
  
  // holes are counter from left to right and top to bottom: {1, 2, 3 ,..}
  // from hole 1 to hole 2
  rect(size,0,width/2-2*size,size/2,0,0,200,200);
  // from hole 2 to hole 3
  rect(width/2+size,0,width/2-2*size,size/2, 0,0,200,200);
  // from hole 1 to hole 4
  rect(0,size,size/2,height-2*size,0,200,200,0);
  // from hole 3 to hole 6
  rect(width-size/2,size,size/2,height-2*size,200,0,0,200);
  // from hole 4 to 5
  rect(width/2+size,height-size/2,width/2-2*size,size/2, 200,200,0,0);
  // from hole 5 to 6
  rect(size,height-size/2,width/2-2*size,size/2,200,200,0,0);
}

void drawHoles(){
  fill(0);
  int size = holeDiameter;
  
  // corner cases
  circle(0,0,size);
  circle(width,0,size);
  circle(0,height,size);
  circle(width,height,size);
  //circle(width/2, height/2, height);
  
  // middle cases
  circle(width/2,0,size);
  circle(width/2,height,size);
  
}
