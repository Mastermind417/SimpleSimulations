ArrayList<Spring> springs;

void addHorizontalSpring(int nCols){
  int particleSize = particles.size();
  if(particleSize < 2 || particleSize%nCols == 1) return;
  
  Particle pLast = particles.get(particleSize-1); // last particle added
  Particle pPrevious = particles.get(particleSize-2); // previous horizontal particles, i.e. the one to its left
  
  PVector diffVec = new PVector(); 
  PVector.sub(pLast.position, pPrevious.position, diffVec);
  
  Spring spring = new Spring(pLast, pPrevious, diffVec.mag(), 0.01);
  springs.add(spring);
  physics.addSpring(spring);
}

void addVerticalSpring(int nCols){
  int particleSize = particles.size();
  if(particleSize <= nCols) return;
  
  Particle pLast = particles.get(particleSize-1); // last particle added
  Particle pPrevious = particles.get(particleSize-1-nCols); // previous vertical particles, i.e. a layer above
  
  PVector diffVec = new PVector(); 
  PVector.sub(pLast.position, pPrevious.position, diffVec);
  
  Spring spring = new Spring(pLast, pPrevious, diffVec.mag(), 0.01);
  springs.add(spring);
  physics.addSpring(spring);
}

class Spring extends VerletSpring2D{
  Spring(Particle p1, Particle p2, float len, float strength){
      super(p1, p2, len, strength);
  }
  
  void display(){
    stroke(0);
    //strokeWeight(2);
    line(a.x, a.y, b.x, b.y);
  }
  
}
