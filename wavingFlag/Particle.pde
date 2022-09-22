ArrayList<Particle> particles;

void addParticle(float x, float y, boolean lockInPlace){
  Particle p = new Particle(x,y);
  particles.add(p);
  physics.addParticle(p);
  
  if(lockInPlace) p.lock();
}

class Particle extends VerletParticle2D{
  float diameter = 15;
  float radius = diameter/2;
  String name;
  PVector position;
  PVector velocity;
  PVector totalForce;
  
  Particle(float x, float y){
    super(x,y);
    position = new PVector(x,y);
    velocity =new PVector(0,0);
    totalForce = new PVector(0,0);
    name = new String("Particle" + particles.size());
  }
  
  void display(){
    fill(46,75,255);
    noStroke();
    //stroke(0);
    //strokeWeight(3);
    circle(x,y, diameter);
  }
  
  void move(){
    velocity.add(totalForce);
    
    lock();
    x += velocity.x;
    y += velocity.y;
    unlock();
    
    totalForce.mult(0);
    velocity.mult(0);
    
  }
  
  void addForce(PVector force){
    totalForce.add(force);  
  }
}
