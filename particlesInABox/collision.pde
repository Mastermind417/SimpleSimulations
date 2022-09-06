// This is the collision detection and collision resolution separate from the Particle class

void collide(Particle particle, Particle otherParticle){
  // check if spheres overlap and resolve contact
  if(checkCollision(particle, otherParticle)){
    // resolve contact
    resolveContact(particle, otherParticle);
  }
}

boolean checkCollision(Particle particle, Particle otherParticle){
   
  boolean sameParticle = particle.name == otherParticle.name;
  if(sameParticle) return false;
  
  PVector displacementDiff = new PVector();
  PVector.sub(particle.position, otherParticle.position, displacementDiff);
  
  float maxDist = particle.radius + otherParticle.radius;
  
  if( displacementDiff.mag() <= maxDist) {
    return true;
  }
  return false;    
}

void resolveContact(Particle particle, Particle otherParticle){
  // this is the algorithm implemented: 
  //from https://studiofreya.com/3d-math-and-physics/simple-sphere-sphere-collision-detection-and-collision-response/
  
  PVector x = PVector.sub(particle.position,otherParticle.position);
  x.normalize();
  
  PVector v1 = particle.velocity;
  float x1 = x.dot(v1);
  PVector v1x = new PVector(); 
  PVector.mult(x,x1, v1x);
  PVector v1y = PVector.sub(v1, v1x);
  float m1 = particle.mass;

  x.mult(-1);
  PVector v2 = otherParticle.velocity;
  float x2 = x.dot(v2);
  PVector v2x = new PVector();
  PVector.mult(x, x2, v2x);
  PVector v2y = PVector.sub(v2, v2x);
  float m2 = otherParticle.mass;
  
  PVector partv1_1 = new PVector();
  PVector partv1_2 = new PVector();
  PVector.mult(v1x,(m1-m2)/(m1+m2), partv1_1);
  PVector.mult(v2x,(2*m2)/(m1+m2), partv1_2);
  particle.velocity = partv1_1;
  particle.velocity.add(partv1_2);
  particle.velocity.add(v1y);
  
  PVector partv2_1 = new PVector();
  PVector partv2_2 = new PVector();
  PVector.mult(v1x,(2*m1)/(m1+m2), partv2_1);
  PVector.mult(v2x,(m2-m1)/(m1+m2), partv2_2);
  otherParticle.velocity = partv2_1;
  otherParticle.velocity.add(partv2_2);
  otherParticle.velocity.add(v2y); 
}
