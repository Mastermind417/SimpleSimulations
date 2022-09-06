void moveParticles(){
  if(particles == null) return;
  
  // particle force manipulation
  for(Particle p : particles){
    p.update();
    p.display();
  }
}

void collisionBetweenParticles(){
  /*
  This is the collision resolution between all the particles.
  */
  for(int i = particles.size()-1; i > 0; i--){
    Particle p1 = particles.get(i);
    for(int j = i-1; j>=0;j--){
      Particle p2 = particles.get(j);
      collide(p1, p2); // remember to uncomment the last 3 lines in 'resolveContact'
    }
  }

}

void particleDeletion(){
  // remove all particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.remove(i);
    }
}
