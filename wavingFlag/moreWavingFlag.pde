void reset() {
  physics = new VerletPhysics2D();
  particles = new Particle[particleCols][particleRows];
  springs = new ArrayList<Spring>();

  flag = null;

  gravity = new Vec2D(0, 1);
  wind = new Vec2D(0, 0);
}

void showPole() {
  stroke(0);
  strokeWeight(4);
  fill(0);
  line(poleTop.x, poleTop.y, poleBottom.x, poleBottom.y);
}

void createFlag() {
  flag = new Flag(particleRows, particleCols, 17*width/20, poleTop.x, 1.05*poleTop.y, poleTop.x, poleBottom.y);
}

void applyForcesOnParticles() {
  float yOff = 0;
  
  for (int j = 0; j<particleRows; j++) {
    float xOff = 0;    
    //float yWind = map(noise(yOff), 0,1,-1,0);
    float yWind = random(-2,0);
    if(frameCount %10 == 0) yWind = 0;
    //float yWind = 0;
    for (int i = 0; i<particleCols; i++) {
      Particle p = particles[i][j];
      float xWind = map(noise(yOff + frameCount), 0,1,0,3);
      wind.set(xWind, yWind);

      p.addForce(gravity);
      p.addForce(wind);
      
      xOff += 0.01;
    }
    yOff += 0.1;
  }
}

void applyTextureOnFlag() {
  int nRows = flag.nRows;
  int nCols = flag.nCols;

  stroke(0);
  strokeWeight(2);
  noStroke();
  //noFill();
  textureMode(NORMAL);
  for (int j = 0; j<nRows-1; j++) {
    beginShape(TRIANGLE_STRIP);
    texture(img);
    for (int i = 0; i < nCols; i++) {
      Particle p1 = particles[i][j];
      float u1 = map(i, 0, nCols-1, 0, 1);
      float v1 = map(j, 0, nRows-1, 0, 1);
      vertex(p1.x, p1.y, u1, v1);

      Particle p2 = particles[i][j+1];
      //float u2 = map(i, 0, nCols-1, 0, 1);
      float v2 = map(j+1, 0,nRows-1, 0, 1);
      vertex(p2.x, p2.y, u1, v2);
    }
    endShape();
  }
}
