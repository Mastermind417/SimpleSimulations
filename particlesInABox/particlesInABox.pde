// Created 18th August 2022

int w = 640;
int h = 640; 

ArrayList<Particle> particles;

// forces
PVector wind = new PVector(-0.15,0); 
PVector gravity = new PVector(0,0.1);
PVector extForce = new PVector(0,0);

// extra helpful
int[] buttons = {87, 83, 65, 68};

void settings(){
  size(w,h);
}

void setup(){
  particles = new ArrayList<Particle>();  
  background(0);
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
  //extForceApplied = false; 
  //extForce.mult(0);
  
  float controlAmount = 0.05;
  float amountX = 0, amountY = 0;
  
  if(keyCode == buttons[0]){
    amountX = 0;
    amountY = -controlAmount;
  }
  else if(keyCode == buttons[1]){
    amountX = 0;
    amountY = controlAmount;
  }
  else if (keyCode == buttons[2]){
    amountX = -controlAmount;
    amountY = 0;  
  }
  else if(keyCode == buttons[3]){
    amountX = controlAmount;
    amountY = 0;
  }
  
  else if (keyCode == 67){ 
    extForce.mult(0); // clears force when 'c' is pressed
    return;
  }
  
  // apply force to each particle
  PVector correctionForce = new PVector(amountX, amountY);  
  extForce.add(correctionForce);
    
  // draw square at bottom of screen to indicate when external force is added
  drawBottomSquare();
}

void keyReleased(){
  if(keyCode == buttons[0] || keyCode == buttons[1]){
    extForce.y = 0;
  }
  else if(keyCode == buttons[2] || keyCode == buttons[3]){
    extForce.x = 0;
  } 
}

void draw(){
  background(0);
  
  for(Particle p : particles){
    p.addForce(wind);
    p.addForce(gravity);
    p.addForce(extForce);
    p.update();
    p.display();
    p.controlParticleColour();
  }
}

void drawBottomSquare(){
  int sL = 300;
  square(w - sL/2, h - sL/2, sL); // sL/2 is to centre the box better
  stroke(100);
  //fill(200);
}
