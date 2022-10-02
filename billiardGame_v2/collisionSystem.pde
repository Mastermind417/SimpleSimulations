// This is the collision detection and collision resolution separate from the Particle class

void collide(Particle particle, Particle otherParticle){
  // check if spheres overlap and resolve contact
  if(checkCollision(particle, otherParticle)){
    
    // resolve penetration as to simulate hard contact between the particles
    resolvePenetration(particle, otherParticle);

    // resolve collision
    resolveCollision(particle, otherParticle);
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

void resolvePenetration(Particle particle, Particle otherParticle){
  // This is a simple penetration resolution algorithm developed by myself on paper
  // The idea is that when particle 2 penetrates particle 1, particle 2 moves at the start of the penetration
  
  PVector dVec = new PVector();
  PVector.sub(particle.position, otherParticle.position, dVec);
  
  float dMag = dVec.mag();
  float radiiSum = particle.radius + otherParticle.radius;
  
  // if particles barely touch each other, there is no need to resolve contact
  if(dMag == radiiSum) return;
  
  dVec.normalize();
  
  // shift second particle to the point where the particles just touch each other
  otherParticle.position.sub(dVec.mult(radiiSum-dMag));
}

void resolveCollision(Particle particle, Particle otherParticle){
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

//void simulateHardContact(Particle particles, Particle otherParticle){
  
//}

void collideWithEdges(Particle particle){
  float yTop = particle.position.y - particle.radius;
  float yBottom = particle.position.y + particle.radius;
  float xLeft = particle.position.x - particle.radius;
  float xRight = particle.position.x + particle.radius;
   
  // correction for curved edge piece
  float cF = holeRadius/3;
   
  // collision detection, penetration resolution and contact resolution(bounces off the edge)
  // top edges
  if(yTop <= edges.get(0).position.y + edges.get(0).size.y && xRight >= edges.get(0).position.x + cF && xLeft <= edges.get(0).position.x + edges.get(0).size.x - cF){
    
    particle.position.y -= yTop - (edges.get(0).position.y + edges.get(0).size.y);
    particle.velocity.y *= -1;
  }
  else if(yTop <= edges.get(1).position.y + edges.get(1).size.y && xRight >= edges.get(1).position.x && xLeft + cF <= edges.get(1).position.x + edges.get(1).size.x - cF){
    particle.position.y -= yTop - (edges.get(1).position.y + edges.get(1).size.y);
    particle.velocity.y *= -1;
  }
  
  // bottom edges
  else if(yBottom >= edges.get(4).position.y && xRight >= edges.get(4).position.x && xLeft + cF <= edges.get(4).position.x + edges.get(4).size.x - cF){
    particle.position.y -= yBottom - edges.get(4).position.y;
    particle.velocity.y *= -1;
  }
  else if(yBottom >= edges.get(5).position.y && xRight >= edges.get(5).position.x + cF && xLeft <= edges.get(5).position.x + edges.get(5).size.x - cF){
    particle.position.y -= yBottom - edges.get(5).position.y;
    particle.velocity.y *= -1;
  }
  
  // side edges
  else if(xLeft <= edges.get(2).position.x + edges.get(2).size.x && yBottom >= edges.get(2).position.y + cF && yTop <= edges.get(2).position.y + edges.get(2).size.y - cF){
    particle.position.x -= xLeft - (edges.get(2).position.x + edges.get(2).size.x);
    particle.velocity.x *= -1;
  }
  
  else if(xRight >= edges.get(3).position.x && yBottom >= edges.get(3).position.y + cF && yTop <= edges.get(3).position.y + edges.get(3).size.y - cF){
    particle.position.x -= xRight - (edges.get(3).position.x);
    particle.velocity.x *= -1;
  }

}

void collideWithHole(Particle particle){
  PVector pos = particle.position;
  float r = particle.radius;
  
  for(Hole h : holes){
    PVector hPos = h.position;
    float holeRadius = h.radius;
    if(pos.x - r >= hPos.x - holeRadius && pos.x + r <= hPos.x + holeRadius && pos.y - r >= hPos.y - holeRadius && pos.y + r <= hPos.y + holeRadius){
      particle.setVelocity(new PVector(0,0,0));
      particle.hasEnteredHole = true;
    } 
  }
  
  
}
