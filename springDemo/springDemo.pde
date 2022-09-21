int w = 1000;
int h = 800;

PVector oldMouse;
PVector newMouse;

boolean lineShouldAppear;
Particle particleSelected;

ArrayList<Particle> particles;
ArrayList<Spring> springs;

VerletPhysics2D physics;

void settings(){
  size(w, h); 
}

void setup(){
  reset();
}

void draw(){
  background(255);
    
  drawParticleLine();
  displayParticles();
  displaySprings();
  
  physics.update();
}

void keyPressed(){
  // 67 is key 'c' for create
  if(keyCode == 67){
      createNewParticle(mouseX, mouseY);
      createNewSpring();
      return;
  } 
  
  // 82 is key 'r' for reset
  if(keyCode == 82) {
    reset();
    return;
  }
}

void mousePressed(){
  selectParticle();
}

void mouseDragged(){
  newMouse.set(mouseX, mouseY);
}

void mouseReleased(){
  unselectParticle(); 
}
