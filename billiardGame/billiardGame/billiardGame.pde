final int h = 800;
final int w = 2*h; // From wiki after 'billiard table size' search: "The length of a "Regulation Standard 8ft" table should be 88 inches long and 44 inches wide."

ArrayList<Particle> particles;

PVector oldMouse = new PVector(0,0,0);
PVector newMouse = new PVector(0,0,0);

void settings(){
  size(w,h);
}

void setup(){
  particles = new ArrayList<Particle>();
  
}

void mousePressed(){
  Particle p = new Particle(mouseX, mouseY, 0,0, w, h, "Particle" + particles.size());
  particles.add(p);
  
  oldMouse = new PVector(mouseX, mouseY);
  newMouse = oldMouse;
}

void mouseDragged(){
  newMouse = new PVector(mouseX, mouseY);
}

void mouseReleased(){
  Particle lastParticle = particles.get(particles.size()-1);
  PVector newVel = PVector.sub(oldMouse, newMouse);
  newVel.div(50);
  lastParticle.setVelocity(newVel);
}

void keyPressed(){
    if (keyCode == 82){ // 'reset'. when 'r' is pressed particles disappear and time is set back to 0
    particleDeletion();  
    
    oldMouse = new PVector(0,0,0);
    newMouse = new PVector(0,0,0);
  }
}


void draw(){
  background(#12C65B);
  
  // table edges and holes
  drawSideEdges();
  drawHoles();
  
  moveParticles();
  collisionBetweenParticles();
  
  // for shooting a billiard
  drawVelLine();
}

void drawVelLine(){
  if(mousePressed){
    strokeWeight(2);
    fill(128,128,128);
    line(oldMouse.x, oldMouse.y, newMouse.x, newMouse.y);
  }
}
