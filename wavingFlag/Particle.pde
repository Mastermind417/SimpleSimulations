//ArrayList<Particle> particles;
Particle[][] particles;

void addParticle(int i, int j, int x, int y){
  Particle p = new Particle(i,j,x,y);
  particles[i][j] = p;
  physics.addParticle(p);
}

class Particle extends VerletParticle2D{
  float diameter = 15;
  float radius = diameter/2;
  String name;
  PVector position;

  
  Particle(int i, int j, int x, int y){
    super(x,y);
    position = new PVector(x,y);
    name = new String("Particle" + i + "" + j);
  }
  
  void display(){
    //fill(46,75,255);
    //stroke(0);
    //strokeWeight(3);
    //circle(x,y, diameter);
  }
  
  void move(float vx, float vy){
    lock();
    x += vx;
    y += vy;
    unlock();
    
  }
}
