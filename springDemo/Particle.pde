class Particle extends VerletParticle2D{
  float diameter = 20;
  float radius = diameter/2;
  PVector position;
  PVector velocity;
  String name;
  
  Particle(float x, float y){
    super(x,y);
    //position = super(x,y);
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    name = new String("Particle" + particles.size());
  }
  
  void display(){
    fill(39,57,250);
    stroke(2);
    strokeWeight(2);
    circle(position.x,position.y, diameter);
  }
  
  void move(){
    applyBoundaries();
    
    // move particle
    position.add(velocity);
    
    // decrease velocity
    velocity.mult(0.99);
  }
  
  void setVelocity(float vx, float vy){
    velocity = new PVector(vx/10, vy/10);
  }
  
  void applyBoundaries(){
    // right boundary    
    if(position.x + radius >= width){
      position.x = width - radius;
      velocity.x *= -1;
    }
    // left boundary
    else if (position.x - radius <= 0){
      position.x = radius;
      velocity.x *= -1;    
    }
    
    // up boundary 
    if(position.y - radius <= 0){
      position.y = radius;
      velocity.y *= -1;
    }
    //down boundary
    else if (position.y + radius >= height){
      position.y = height-radius;
      velocity.y *= -1;
    }
  }
}
