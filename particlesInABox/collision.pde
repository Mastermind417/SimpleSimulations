// This is to have the collision detection and collision resolution differently from the 'Particle' class

void collision(Particle particle, Particle otherParticle){
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
  
  if( displacementDiff.mag() <= maxDist ) return true;
  return false;    
}

public static void resolveContact(Particle particle, Particle otherParticle){
  // this is the algorithm implemented: 
  //from https://studiofreya.com/3d-math-and-physics/simple-sphere-sphere-collision-detection-and-collision-response/
  
  PVector x = PVector.sub(particle.position,otherParticle.position);
  x.normalize();
  
  PVector v1 = particle.velocity;
  float x1 = x.dot(v1);
  PVector v1x = x.mult(x1);
  PVector v1y = PVector.sub(v1, v1x);
  float m1 = particle.mass;
  
  x.mult(-1);
  PVector v2 = otherParticle.velocity;
  float x2 = x.dot(v2);
  PVector v2x = x.mult(x2);
  PVector v2y = PVector.sub(v2, v2x);
  float m2 = otherParticle.mass;
  
  particle.velocity = v1x.mult((m1-m2)/(m1+m2));
  particle.velocity.add(v2x.mult((2*m2)/(m1+m2)));
  particle.velocity.add(v1y);
  
  // comment/uncomment according to implemention 1 or 2 in resolveContact
  otherParticle.velocity = v1x.mult((2*m1)/(m1+m2));
  otherParticle.velocity.add(v2x.mult((m2-m1)/(m1+m2)));
  otherParticle.velocity.add(v2y); 
}
