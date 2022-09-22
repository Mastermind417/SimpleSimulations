ArrayList<Spring> springs;

void addHorizontalSpring(int i, int j){
  if(i == 0) return;
  
  Particle pNow = particles[i][j]; // last particle added
  Particle pPrevious = particles[i-1][j]; // previous horizontal particle, i.e. the one to its left
  
  PVector diffVec = new PVector(); 
  PVector.sub(pNow.position, pPrevious.position, diffVec);
  
  Spring spring = new Spring(pNow, pPrevious, diffVec.mag(), 1);
  springs.add(spring);
  physics.addSpring(spring);
}

void addVerticalSpring(int i, int j){
  if(j == 0) return;
  
  Particle pNow = particles[i][j]; // last particle added
  Particle pPrevious = particles[i][j-1]; // previous vertical particle, i.e. a layer above

  PVector diffVec = new PVector(); 
  PVector.sub(pNow.position, pPrevious.position, diffVec);
  
  Spring spring = new Spring(pNow, pPrevious, diffVec.mag(), 1);
  springs.add(spring);
  physics.addSpring(spring);
}

class Spring extends VerletSpring2D{
  Spring(Particle p1, Particle p2, float len, float strength){
      super(p1, p2, len, strength);
  }
  
  void display(){
    //noStroke();
    //noFill();
    stroke(0);
    strokeWeight(2);
    line(a.x, a.y, b.x, b.y);
  }
  
}
