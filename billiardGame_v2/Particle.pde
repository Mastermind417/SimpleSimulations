// class from particlesInABox

int diameterCONST = 40;

class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  int life;
  boolean hasDied = false;
  String name;
  
  int diameter;
  float radius;
  int[] colour;
  
  final float dampening = 0.99;
  
  PVector force;
  float mass;
  
  PVector boundary;
  PVector maxVel;
  PVector minVel;
  
  boolean hasEnteredHole;
  
  Particle(float x, float y, float vx, float vy, float bx, float by, int[] colour_){
    position = new PVector(x,y);
    velocity = new PVector(vx, vy);
    
    force = new PVector(0,0);
    boundary = new PVector(bx, by);
    maxVel = new PVector(0.001, 0.001);
    minVel = new PVector(0.001, 0.001);
    name = "Particle" + particles.size();
    
    life = 10000;
    diameter = diameterCONST;
    radius = diameter/2;
    mass = 100; // map(radius, 5,20,1,100); 
    
    colour = colour_;
    hasEnteredHole = false;
   
  }
  
  void setPosition(PVector newPosition){
    position = newPosition;
  }
  
  void setVelocity(PVector newVelocity){
    velocity = newVelocity;
  }
  
  void update(){
    // apply boundary conditions
    //applyBCs();
 
    // restrict particle to box
    restrictToBox();

    // apply force and update acceleration
    applyForce();
    
    // update kinematics
    velocity.add(acceleration);
    velocity.mult(dampening);
    position.add(velocity);
    
    // record extreme velocity
    recordExtremeVelocity();
    
    // clear velocity if velocity is too low
    clearLowSpeed();
    
    // clear total force at the end
    force.mult(0);
    
    //life -= 1;
    //killParticle();
  }
  
  void display(){ 
    stroke(0);
    strokeWeight(3);
    fill(colour[0], colour[1], colour[2]);
    circle(position.x, position.y, diameter);
    
    //controlParticleColour();
  }
  
  // F = ma => a = F/M
  void addForce(PVector f){
    force.add(f);
  }
  
  void applyForce(){
    acceleration = PVector.div(force, mass);
  }
  
  void applyBCs(){
    if(position.x > boundary.x){
      position.x = position.x % boundary.x; 
    }
    else if(position.x < 0){
      position.x += boundary.x;
    }
    else if(position.y > boundary.y){
      position.y = position.y % boundary.y; 
    }
    else if(position.y < 0){
      position.y += boundary.y;
    }
  }
  
  void restrictToBox(){
    if(position.x + radius > boundary.x || position.x - radius < 0){
      velocity.x *= -1; 
    }
    else if(position.y + radius > boundary.y || position.y - radius < 0){
      velocity.y *= -1; 
    }    
  }
  

  
  void controlParticleColour(){ 
    int colourX = (int)map(abs(velocity.x), 0, maxVel.x, 255, 50);
    int colourY = (int)map(abs(velocity.y), 0, maxVel.y, 255, 50);
    
    fill(colourX, colourY, 150);
    circle(position.x, position.y, diameter);
  }
  
  void recordExtremeVelocity(){
    if(velocity.x > maxVel.x){
      maxVel.x = velocity.x;
    }
    if(velocity.y > maxVel.y){
      maxVel.y = velocity.y;
    }
    
    if(velocity.x < minVel.x){
      minVel.x = velocity.x;
    }
    if(velocity.y < minVel.y){
      minVel.y = velocity.y;
    }
  }
  
  void clearLowSpeed(){
    /*
    This is to make the balls slow quicker so that they don't seem to 'jiggle'.
    */
    
    //if(colour[0] == 255 && colour[0] == 255 && colour[0] == 255) println(velocity.mag());
    
    float lowSpeedThreshold = 0.5;
    if(velocity.mag() <= lowSpeedThreshold) velocity.mult(0);
  }
  
  void killParticle(){
    if(life > 0) return;
    
    diameter = 0;
    hasDied = true;
  }
}
