void reset(){
  particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0,0,width,height));
  
  oldMouse = new PVector(0,0);
  newMouse = new PVector(0,0);
  
  lineShouldAppear = false;
  particleSelected = null;
}

void displayParticles(){
  for(Particle p : particles){
      p.display();
  }
}

void displaySprings(){
  for(Spring s : springs){
      s.display();
  }
}

void moveParticle(float vx, float vy){
  for(Particle p : particles){
    if(p.name == particleSelected.name){
      p.move(vx, vy);
      break;
    }
  }
}

void drawParticleLine(){
  if(!lineShouldAppear) return;
  
  fill(240, 39, 52);
  strokeWeight(1);
  line(oldMouse.x, oldMouse.y, newMouse.x, newMouse.y);
}

void selectParticle(){
  if(lineShouldAppear) return;
  
  for(Particle p : particles){
    float leftBoundary = p.x - p.radius;
    float rightBoundary = p.x + p.radius;
    float upBoundary = p.y - p.radius;
    float downBoundary = p.y + p.radius;
    
    if(mouseX >= leftBoundary && mouseX <= rightBoundary && mouseY >= upBoundary && mouseY <= downBoundary){
        particleSelected = p;
        oldMouse.set(p.x, p.y);
        newMouse.set(mouseX, mouseY);
        lineShouldAppear = true;
        break;
    }
  }
}

void unselectParticle(){
  if(!lineShouldAppear) return;
  
  moveParticle(oldMouse.x - newMouse.x, oldMouse.y - newMouse.y);
  
  lineShouldAppear = false;

  newMouse.set(new PVector(0,0));
  oldMouse.set(new PVector(0,0));
  
  particleSelected = null;
}

void createNewSpring(){
  int particleSize = particles.size();
  if(particleSize < 2) return;
  
  Particle pNew = particles.get(particleSize-1);
  Particle pLast = particles.get(particleSize-2);
  
  PVector diffVec = new PVector(); 
  PVector.sub(pNew.position, pLast.position, diffVec);
  
  Spring spring = new Spring(pNew, pLast, diffVec.mag(), 0.001);
  physics.addSpring(spring);
  springs.add(spring);
}

void createNewParticle(float x, float y){
    Particle pNew = new Particle(x, y);
    particles.add(pNew);
    physics.addParticle(pNew);
}
