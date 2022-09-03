class Particle{
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  int lifetime;
  boolean hasDied = false;
  String name;
  
  int diameter = (int)random(40,80);
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
    
    lifetime = 1000;
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
    
    lifetime -= 1;
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
 //<>// //<>// //<>//
    
    // check if spheres overlap and resolve contact
    if(checkCollision(otherParticle)){
      // resolve contact
      //resolveContact(otherParticle);
      collisionResolution(otherParticle);
    }
  }
  
  boolean checkCollision(Particle otherParticle){
    PVector otherPos = otherParticle.position;
    
    boolean sameParticle = name == otherParticle.name;
    if(sameParticle) return false;
    
    PVector displacementDiff = new PVector();
    PVector.sub(position, otherPos, displacementDiff);
    
    float maxDist = radius + otherParticle.radius;
    
    if( displacementDiff.mag() <= maxDist ) return true;
    return false;
  }
  
  void resolveContact(Particle otherParticle){
    // CHECK THIS RESOLUTION CAREFULLY [02.09.22] 
    // this is taking into account an elastic collision of a classical two particle system
    float m2 = mass;
    float m1 = otherParticle.mass;
    PVector u1 = otherParticle.velocity;
    PVector u2 = velocity;
    
    // The quadratic equation is m2/m1 * (m1+m2) * v2^2 - 2*m2*(u1+m2u2)* v2 + m2*u2((m2/m1-1)*u2 + 2*u1)
    // coefficient of v2^2
    float a = m2/m1 * (m1 + m2);
    
    // coefficient of v2
    PVector B = u1;
    B.add(u2.mult(m2));
    B.mult(2*m2);
    
    // coefficient of v2^0
    PVector cPar1 = u2.mult(m2);
    PVector cPar2 = u1.mult(2);
    cPar2.add(u2.mult(m2/m1 -1));
    float c = cPar1.dot(cPar2);

    
    // find correct v2
    float discri = sqrt(B.dot(B) - 4*a*c);
    PVector v2 = B;
    v2.add(discri,discri);
    v2.div(2*a);
    if (v2.mag() > u2.mag()) {
      v2 = B;
      v2.sub(discri,discri);
      v2.div(2*a);
    }; 
    
    // assign new velocity to current velocity
    velocity = v2;
  }
  
  void collisionResolution(Particle otherParticle){
    // this is the algorithm implemented: 
    //from https://studiofreya.com/3d-math-and-physics/simple-sphere-sphere-collision-detection-and-collision-response/
    
    PVector vecx = PVector.sub(position,otherParticle.position);
    vecx.normalize();
    
    PVector vecv1 = velocity;
    float x1 = vecx.dot(vecv1);
    PVector vecv1x = vecx.mult(x1);
    PVector vecv1y = PVector.sub(vecv1, vecv1x);
    float m1 = mass;
    
    vecx.mult(-1);
    PVector vecv2 = otherParticle.velocity;
    float x2 = vecx.dot(vecv2);
    PVector vecv2x = vecx.mult(x2);
    PVector vecv2y = PVector.sub(vecv2, vecv2x);
    float m2 = otherParticle.mass;
    
    velocity = vecv1x.mult((m1-m2)/(m1+m2));
    velocity.add(vecv2x.mult((2*m2)/(m1+m2)));
    velocity.add(vecv1y);
    
    otherParticle.velocity = vecv1x.mult((2*m1)/(m1+m2));
    otherParticle.velocity.add(vecv2x.mult((m2-m1)/(m1+m2)));
    otherParticle.velocity.add(vecv2y); 
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
    if(lifetime > 0) return;
    
    diameter = 0;
    hasDied = true;
  }
}
