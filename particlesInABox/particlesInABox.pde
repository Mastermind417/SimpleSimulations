// Created 18th August 2022

int w = 640;
int h = 640; 

ArrayList<Particle> particles;

// forces
PVector wind = new PVector(-0.5,0); 
PVector gravity = new PVector(0,0.1);
PVector extForce = new PVector(0,0);
boolean extForceApplied = false;

void settings(){
  size(w,h);
}

void setup(){
  particles = new ArrayList<Particle>();  
}

void mousePressed(){
  Particle p = new Particle(mouseX, mouseY, 0,0, w, h);
  particles.add(p);
}

void mouseDragged(){
  float vx = mouseX - pmouseX;
  float vy = mouseY - pmouseY;
  Particle p = new Particle(mouseX, mouseY, vx, vy, w, h);
  particles.add(p);
}

void keyPressed(){
  extForceApplied = false;
  
  float controlAmount = 1000;
  float amountX = 0, amountY = 0;
  
  if(keyCode == 'w'){
    amountX = 0;
    amountY = -controlAmount;
    extForceApplied = true;
  }
  else if(keyCode == 's'){
    amountX = 0;
    amountY = controlAmount;
    extForceApplied = true;
  }
  else if (keyCode == 'a'){
    amountX = -controlAmount;
    amountY = 0;  
    extForceApplied = true;
  }
  else if(keyCode == 's'){
    amountX = controlAmount;
    amountY = 0;
    extForceApplied = true;
  }
  
  // apply force to each particle
  PVector correctionForce = new PVector(amountX, amountY);  
  extForce.add(correctionForce);  
 
  int sL = 300;
  square(w - sL/2, h - sL/2, sL); // sL/2 is to centre the box better
  stroke(100);
  fill(200); 
}

//void keyReleased(){
//  if(keyCode == 'w' || keyCode == 's' || keyCode == 'a' || keyCode == 'd'){
//      extForceApplied = false;
//      extForce.mult(0);
//  }
//}

void draw(){
  background(0);
   
  // this does not work for some reason
  if(extForceApplied) {
    int sL = 100;
    square(w - sL/2, h - sL/2, sL); // sL/2 is to centre the box better
    stroke(100);
    fill(200); 
  }
  
  for(Particle p : particles){
    //p.addForce(wind);
    p.addForce(gravity);
    //p.addForce(extForce);
    p.update();
    p.display();
    p.controlParticleColour();
  }
}
