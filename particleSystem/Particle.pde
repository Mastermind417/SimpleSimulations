class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector l){
    location = l;
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(0, 0);
    lifespan = 255;
  }
  
  void run(){
    update();
    display();
  }
  
  void update(){
    // apply external force (extra)
    PVector force = new PVector( random(-0.5,0.5), random(0,0.1));
    applyForce(force);
    
    velocity.add(acceleration);
    location.add(velocity);
    applyBoundary();
    lifespan -= random(0.1,2);
  }
  
  void display(){
    stroke(0, lifespan);
    fill(175, lifespan);
    ellipse(location.x, location.y, 20, 20);
  }
  
  void applyForce(PVector force){
    acceleration = force;
  }
  
  void applyBoundary(){
    if(location.x < 0 || location.x > width){
      velocity.x *= -1;
    }
    
    if(location.y < 0 || location.y > height){
      velocity.y *= -1;
    }
    
  }
  
  boolean isDead(){
    if(lifespan < 0) return true;
    return false;
  }
}
