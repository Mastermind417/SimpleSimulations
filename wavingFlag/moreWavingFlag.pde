void reset(){
  physics = new VerletPhysics2D();
  particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();
  
  flag = null;
}

void showPole(){
  strokeWeight(4);
  fill(0);
  line(poleTop.x,poleTop.y, poleBottom.x, poleBottom.y);
}

void createFlag(){
  flag = new Flag(8, 20, 17*width/20, poleTop.x, 1.05*poleTop.y, poleTop.x, poleBottom.y);
}
