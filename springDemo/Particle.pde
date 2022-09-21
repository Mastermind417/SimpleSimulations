class Particle extends VerletParticle2D{
  float diameter = random(30,30);
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
    stroke(0);
    strokeWeight(3);
    circle(x,y, diameter);
  }
  
  void move(float vx, float vy){
      lock();
      x = vx;
      y = vy;
      unlock();
  }
}
