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

void collideWithEdges(Particle particle){
  float yminus = particle.position.y - particle.radius;
  float yplus = particle.position.y + particle.radius;
  float xminus = particle.position.x - particle.radius;
  float xplus = particle.position.x + particle.radius;
  
  
  // collision detection and resolution(bounces off the edge)
  // top edges
  if(yminus <= edges.get(0).position.y + edges.get(0).size.y && xplus >= edges.get(0).position.x && xminus <= edges.get(0).position.x + edges.get(0).size.x){
    
    particle.velocity.y *= -1;
  }
  else if(yminus <= edges.get(1).position.y + edges.get(1).size.y && xplus >= edges.get(1).position.x && xminus <= edges.get(1).position.x + edges.get(1).size.x){
    particle.velocity.y *= -1;
  }
  
  // bottom edges
  else if(yplus >= edges.get(4).position.y && xplus >= edges.get(4).position.x && xminus <= edges.get(4).position.x + edges.get(4).size.x){
    particle.velocity.y *= -1;
  }
  else if(yplus >= edges.get(5).position.y && xplus >= edges.get(5).position.x && xminus <= edges.get(5).position.x + edges.get(5).size.x){
    particle.velocity.y *= -1;
  }
  
  // side edges
  else if(xminus <= edges.get(2).position.x + edges.get(2).size.x && yplus >= edges.get(2).position.y && yminus <= edges.get(2).position.y + edges.get(2).size.y){
    particle.velocity.x *= -1;
  }
  
  else if(xplus >= edges.get(3).position.x && yplus >= edges.get(3).position.y && yminus <= edges.get(3).position.y + edges.get(3).size.y){
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
