class Flag{
  int nRows;
  int nCols;
  PVector top;
  PVector bottom;
  int len; // this is the length of the flag
  int nParticles; // this is the number of particles on the flag
  
  Flag(int rows_, int cols_, int len_, float topX, float topY, float bottomX, float bottomY){
    nRows = rows_;
    nCols = cols_;
    nParticles = nRows*nCols;
    len = len_;
    top = new PVector(topX, topY);
    bottom = new PVector(bottomX, bottomY);
    
    createFlag();
  }
  
  void createFlag(){
    float dx = len/nCols;
    float dy = (abs(top.y - bottom.y))/nRows;
    for(int i = 0; i< nRows; i++){
      for(int j = 0; j < nCols; j++){
        // x position
        float x = top.x + j*dx;
        // y position
        float y = top.y + i*dy;
        
        // create particle at position (x,y) and locks in place the (0,0) and (0,nRows) particle
        addParticle(x,y, j == 0 && (i == 0 || i == nRows-1));
        
        // create spring between horizontal particles
        addHorizontalSpring(nCols);
        
        // create spring between vertical particles
        addVerticalSpring(nCols);
      }
    }
  }
  
  void display(){
    for(Particle p : particles){
      p.display();
    }
    
    for(Spring s : springs){
      s.display();
    } 
  }
}