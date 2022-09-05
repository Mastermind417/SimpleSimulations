void collisionBetweenParticles(){
  /*
  This is the collision resolution between all the particles.
  */
  
  // IMPLEMENTATION 1 [this doesn't work yet]
  // this checks N-1<->N-2, N-1<->N-3, ..., N-1<->0, N-2<->N-3, ..., 1<->0
  // This should be slightly faster than the previous implementation as the 'resolve contact' algorithm already calculutes the velocity changes for the other particles
  //for(int i = particles.size()-1; i > 0; i--){
  //  Particle p1 = particles.get(i);
  //  for(int j = i-1; j>=0;j--){
  //    Particle p2 = particles.get(j);
  //    collision(p2, p1); // remember to uncomment the last 3 lines in 'resolveContact'
  //  }
  //}
  
  // IMPLEMENTATION 2
  for(Particle part1 : particles){
    for(Particle part2 : particles){
      // remember to comment the last 3 lines in 'resolveContact'
      //collision(part1, part2);
      part2.collideWithParticle(part1);
    }
  }

}

void particleDeath(){
  // check if particles have 'died'
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    if ( p.hasDied ) particles.remove(i);
    }
}

void particleDeletion(){
  // remove all particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.remove(i);
    }
}
