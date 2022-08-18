class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  int lifetime;
  final int MAXLIFETIME = 1000;
  int diameter = 40;
  final float dampening = 0.999;
  
  PVector force;
  float mass;
  
  PVector boundary;
  PVector maxVel;
  
  Particle(float x, float y, float vx, float vy, float bx, float by){
    position = new PVector(x,y);
    velocity = new PVector(vx, vy);
    mass = 1;
    force = new PVector(0,0);
    boundary = new PVector(bx, by);
    maxVel = new PVector(0.001,0.001);
    lifetime = 0;
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
    velocity.x *= dampening;
    position.add(velocity);
    
    // record maximum velocity#
    recordMaxVel();
    
    // clear total force at the end
    force.mult(0);
    
    lifetime += 1;
    killParticle();
  }
  
  void display(){
    circle(position.x, position.y, diameter);
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
    float radius = diameter/2;
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
    
    circle(position.x, position.y, diameter);
    fill(colourX, colourY, 150);
  }
  
  void recordMaxVel(){
    if(velocity.x > maxVel.x){
      maxVel.x = velocity.x;
    }
    if(velocity.y > maxVel.y){
      maxVel.y = velocity.y;
    }  
  }
  
  void killParticle(){
    if(lifetime == MAXLIFETIME){
      // do something when lifetime 'expires'
      // change particle radius. When set to 0 the particle is simply not shown
      diameter = 0;
    } 
  }
}
