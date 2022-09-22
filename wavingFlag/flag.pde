class Flag {
  int nRows;
  int nCols;
  PVector top;
  PVector bottom;
  int len; // this is the length of the flag
  int nParticles; // this is the number of particles on the flag

  Flag(int rows_, int cols_, int len_, float topX, float topY, float bottomX, float bottomY) {
    nRows = rows_;
    nCols = cols_;
    nParticles = nRows*nCols;
    len = len_;
    top = new PVector(topX, topY);
    bottom = new PVector(bottomX, bottomY);

    createFlag();
  }

  void createFlag() {
    int dx = int(len/nCols);
    int dy = int((abs(top.y - bottom.y))/nRows);
    for (int j = 0; j< nRows; j++) {
      for (int i = 0; i < nCols; i++) {
        // x position
        int x = (int)top.x + i*dx;
        // y position
        int y = (int)top.y + j*dy;

        // create particle at position (x,y) and locks in place the (0,0) and (0,nRows) particle
        addParticle(i, j, x, y);

        // create spring between horizontal particles
        addHorizontalSpring(i, j);

        // create spring between vertical particles
        addVerticalSpring(i, j);
      }
    }
    
    // lock particles in place
    particles[0][0].lock();
    particles[0][nRows-1].lock();
  }

  void display() {
    for (int j = 0; j < particles[0].length; j++) {
      for (int i = 0; i < particles.length; i++) {
        Particle p = particles[i][j];
        p.display();
      }
    }

    for (Spring s : springs) {
      s.display();
    }
  }
}
