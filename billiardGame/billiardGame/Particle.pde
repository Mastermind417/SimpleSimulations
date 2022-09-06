// class from particlesInABox

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
  
  Particle(float x, float y, float vx, float vy, float bx, float by, String name_){
    position = new PVector(x,y);
    velocity = new PVector(vx, vy);
    
    force = new PVector(0,0);
    boundary = new PVector(bx, by);
    maxVel = new PVector(0.001,0.001);
    minVel = new PVector(0.001, 0.001);
    name = name_;
    
    life = 10000;
    diameter = (int)random(20,40);
    radius = diameter/2;
    mass = map(radius, 5,20,1,100); 
    
    colour = new int[]{209, 32, 79};
    
    // second ball is white
    if(particles.size() == 1) {
      for(int i = 0; i < colour.length; i++){
        colour[i] = 255;
      }
    }
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
    
    // record maximum velocity
    recordExtremeVelocity();
    
    // clear total force at the end
    force.mult(0);
    
    life -= 1;
    killParticle();
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
  
  void killParticle(){
    if(life > 0) return;
    
    diameter = 0;
    hasDied = true;
  }
}
