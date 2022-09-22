ArrayList<Particle> particles;

void addParticle(float x, float y, boolean lockInPlace){
  Particle p = new Particle(x,y);
  particles.add(p);
  physics.addParticle(p);
  
  if(lockInPlace) p.lock();
}

class Particle extends VerletParticle2D{
  float diameter = 10;
  float radius = diameter/2;
  String name;
  PVector position;
  
  Particle(float x, float y){
    super(x,y);
    position = new PVector(x,y);
    name = new String("Particle" + particles.size());
  }
  
  void display(){
    fill(203,47,76);
    //stroke(0);
    //strokeWeight(3);
    circle(x,y, diameter);
  }
  
  void move(float vx, float vy){
    lock();
    x += vx;
    y += vy;
    unlock();
  }
}
