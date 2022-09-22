void reset() {
  physics = new VerletPhysics2D();
  particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();

  flag = null;

  gravity = new PVector(0, 0.5);
  wind = new PVector(0, 0);
}

void showPole() {
  strokeWeight(4);
  fill(0);
  line(poleTop.x, poleTop.y, poleBottom.x, poleBottom.y);
}

void createFlag() {
  flag = new Flag(4, 10, 17*width/20, poleTop.x, 1.05*poleTop.y, poleTop.x, poleBottom.y);
}

void applyForcesOnParticles() {
  PVector upwardForce = new PVector(0, 0);

  int timeDiff = int(random(10, 100));
  if (frameCount%timeDiff == 0) {
    wind.set(random(-0.5, 2), 0);
    //wind.set(map(noise(frameCount), 0,1,0,2),0);
  }

  for (Particle p : particles) {
    if (p == particles.get(0) || p == particles.get(flag.nParticles-flag.nCols)) {
      continue;
    }

    p.addForce(gravity);
    p.addForce(wind);

    int timeDif2 = int(random(10, 50));
    if (frameCount%timeDif2 == 0) {
      upwardForce.set(0, map(noise(frameCount), 0, 1, -2, 0));
    }
    p.addForce(upwardForce);

    p.move();
  }
}

void applyTextureOnFlag() {
  int nRows = flag.nRows;
  int nCols = flag.nCols;

  stroke(0);
  strokeWeight(2);
  noFill();
  textureMode(NORMAL);
  beginShape(TRIANGLE_STRIP);
  texture(img);
  for (int i = 0; i<nCols-1; i++) {
    for (int j = 0; j < nRows; j++) {

      Particle p1 = particles.get(j*nCols+i);
      int u1 = int(map(p1.x, 0,width, 0, 1));
      int v1 = int(map(p1.y, 0,height, 0, 1));
      vertex(p1.x, p1.y, u1, v1);

      Particle p2 = particles.get(j*nCols+i+1);
      int u2 = int(map(p2.x, 0,width, 0, 1));
      int v2 = int(map(p2.y, 0,height, 0, 1));

      vertex(p2.x, p2.y, u2, v2);

    }
  }
  endShape();
}
