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
  
  final float dampening = 0.999;
  
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
    mass = map(radius, 5,10,1,10); 
    colour = new int[]{(int)random(10,200), (int)random(10,200), (int)random(10,200)};
  }
  
  
  void setVelocity(PVector newVelocity){
    velocity = newVelocity;
  }
  
  void boundVelocity(){
    if( velocity.x > maxVel.x ) {
      velocity.x = maxVel.x;
    }
    else if ( velocity.x < minVel.x ){
      velocity.x = minVel.x;
    }
    
    if( velocity.y > maxVel.y ) {
      velocity.x = maxVel.x;
    }
    else if ( velocity.y < minVel.y ){
      velocity.y = minVel.y;
    }
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
    //velocity.x *= dampening;
    position.add(velocity);
    
    // record maximum velocity
    recordExtremeVelocity();
    
    // clear total force at the end
    force.mult(0);
    
    life -= 1;
    killParticle();
  }
  
  void display(){
    int oppColour = backgroundColour != 0 ? 0 : 255; 
    stroke(oppColour);
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
  
 //<>//
  
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
  
  void collideWithParticle(Particle otherParticle){
  // check if spheres overlap and resolve contact
  if(checkCollision(otherParticle)){
    // resolve contact
    resolveContact(otherParticle);
  }
}

  boolean checkCollision(Particle otherParticle){
    boolean sameParticle = name == otherParticle.name;
    if(sameParticle) return false;
    
    PVector displacementDiff = new PVector();
    PVector.sub(position, otherParticle.position, displacementDiff);
    
    float maxDist = radius + otherParticle.radius;
    
    if( displacementDiff.mag() <= maxDist ) return true;
    return false;    
  }
  
  void resolveContact(Particle otherParticle){
    // this is the algorithm implemented: 
    //from https://studiofreya.com/3d-math-and-physics/simple-sphere-sphere-collision-detection-and-collision-response/
    
    PVector x = PVector.sub(position,otherParticle.position);
    x.normalize();
    
    PVector v1 = velocity;
    float x1 = x.dot(v1);
    PVector v1x = x.mult(x1);
    PVector v1y = PVector.sub(v1, v1x);
    float m1 = mass;
    
    x.mult(-1);
    PVector v2 = otherParticle.velocity;
    float x2 = x.dot(v2);
    PVector v2x = x.mult(x2);
    PVector v2y = PVector.sub(v2, v2x);
    float m2 = otherParticle.mass;
    
    velocity = v1x.mult((m1-m2)/(m1+m2));
    velocity.add(v2x.mult((2*m2)/(m1+m2)));
    velocity.add(v1y);
    
    // comment/uncomment according to implemention 1 or 2 in resolveContact
    //otherParticle.velocity = v1x.mult((2*m1)/(m1+m2));
    //otherParticle.velocity.add(v2x.mult((m2-m1)/(m1+m2)));
    //otherParticle.velocity.add(v2y); 
  }
}
