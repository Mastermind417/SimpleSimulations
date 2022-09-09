//ParticleSystem ps;
int totalParticles = 10;
ArrayList<Particle> particles = new ArrayList<Particle>();

void setup(){
  size(640,640);
  //ps = new ParticleSystem();
  smooth();
  
  for(int i = 0; i < totalParticles;i++){
    PVector location = new PVector(width/2, random(0,20));
    particles.add(new Particle(location));
  }
}

void draw(){
  background(255);
  
  for(int i = 0; i<particles.size(); i++){
    Particle p = particles.get(i);
    p.run();
    if(p.isDead()) print("Particle " + i + " has died.");
  }
}
