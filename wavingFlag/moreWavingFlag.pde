void reset(){
  physics = new VerletPhysics2D();
  particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();
  
  flag = null;
  
  gravity = new PVector(0,0.5);
  wind = new PVector(0,0);
}

void showPole(){
  strokeWeight(4);
  fill(0);
  line(poleTop.x,poleTop.y, poleBottom.x, poleBottom.y);
}

void createFlag(){
  flag = new Flag(8, 20, 17*width/20, poleTop.x, 1.05*poleTop.y, poleTop.x, poleBottom.y);
}

void applyForcesOnParticles(){
  PVector upwardForce = new PVector(0,0);
  
  int timeDiff = int(random(10,100));
  if(frameCount%timeDiff == 0){
    wind.set(random(-0.5,2),0);
    //wind.set(map(noise(frameCount), 0,1,0,2),0);
  }
  
  for(Particle p : particles){
    if(p == particles.get(0) || p == particles.get(flag.nParticles-flag.nCols)){
      continue;
    }
    
    p.addForce(gravity);    
    p.addForce(wind);

    int timeDif2 = int(random(10,50));
    if(frameCount%timeDif2 == 0) {
      upwardForce.set(0, map(noise(frameCount), 0,1,-2,0));
    }
    p.addForce(upwardForce);
    
    p.move();
    
    
  }
}
