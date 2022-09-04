class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  int life;
  boolean hasDied = false;
  String name;
  
  int diameter;
  float radius;
  
  final float dampening = 0.999;
  
  PVector force;
  float mass;
  
  PVector boundary;
  PVector maxVel;
  
  Particle(float x, float y, float vx, float vy, float bx, float by, String name_){
    position = new PVector(x,y);
    velocity = new PVector(vx, vy);
    mass = 1;
    force = new PVector(0,0);
    boundary = new PVector(bx, by);
    maxVel = new PVector(0.001,0.001);
    name = name_;
    
    life = 1000;
    diameter = (int)random(20,80);
    radius = diameter/2;
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
    recordMaxVel();
    
    // clear total force at the end
    force.mult(0);
    
    life -= 1;
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
    if(position.x + radius > boundary.x || position.x - radius < 0){
      velocity.x *= -1; 
    }
    else if(position.y + radius > boundary.y || position.y - radius < 0){
      velocity.y *= -1; 
    }    
  }
  
  void collideWithParticle(Particle otherParticle){
    // check if spheres overlap and resolve contact //<>//
    if(checkCollision(otherParticle)){
      // resolve contact
      //resolveContact(otherParticle);
      bounceContact(otherParticle);
    }
  }
  
  boolean checkCollision(Particle otherParticle){
    PVector otherPos = otherParticle.position;
    
    boolean sameParticle = name == otherParticle.name;
    if(sameParticle) return false;
    
    PVector displacementDiff = new PVector();
    PVector.sub(position, otherPos, displacementDiff);
    
    float maxDist = radius + otherParticle.radius;
    
    // 04.09.22
    float distanceApart = abs(displacementDiff.mag() - maxDist);
    logger.println("Time: " + time + " | " + abs(displacementDiff.mag() - maxDist));
    if( distanceApart < 10 && distanceApart > 5) { // collision is within 5-10 pixels
      logger.println(" Hit!"); 
      return true;
    }
    return false;
    
    //if( displacementDiff.mag() <= maxDist ) return true;
    //return false;
    
    
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
  
  void bounceContact(Particle otherParticle){
    // Bounce algorithm developed by myself [04.09.22]
    
    print("Initial velocity: " + velocity);
    PVector v1 = velocity;
    PVector v2 = otherParticle.velocity;
    
    if((v1.x * v2.x) < 0) {
      println(v1.x);
      println(v2.x);
      v1.x *= -1;
      v2.x *= -1;
      println(v1.x);
      println(v2.x);
      println();
    }
    
    if((v1.y * v2.y) < 0) {
      v1.y *= -1;
      v2.y *= -1;
    }    
    
    velocity = v1;
    print("Final velocity: " + velocity);
    
    //otherParticle.velocity = v2;
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
    if(life > 0) return;
    
    diameter = 0;
    hasDied = true;
  }
}
