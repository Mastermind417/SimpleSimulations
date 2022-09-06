// Created 18th August 2022

final int w = 1000;
final int h = 1000; 
int backgroundColour = 100; // 0 black, 255 white

ArrayList<Particle> particles;

// forces
PVector wind = new PVector(-0.15,0); 
PVector gravity = new PVector(0,0.1);
PVector extForce = new PVector(0,0);

// extra helpful
int[] buttons = {87, 83, 65, 68};

// images for external user control
PImage photoUp;
PImage photoDown;
PImage photoLeft;
PImage photoRight;
int picCounter = 0; //{0,1,2,3,4} -> {No pic, Up, Down, Left, Right};

PrintWriter logger;
int time = 0;
boolean simPaused;

PVector oldMouse = new PVector(0,0,0);
PVector newMouse = new PVector(0,0,0);

void settings(){
  size(w,h); 
}

void setup(){
  logger = createWriter("logger.txt");
  simPaused = false;
  //frameRate(20);
  
  particles = new ArrayList<Particle>();  
  background(backgroundColour);
  
  // load pictures
  photoUp = loadImage("DirectionPics/up.png");
  photoDown = loadImage("DirectionPics/down.png");
  photoLeft = loadImage("DirectionPics/left.png");
  photoRight = loadImage("DirectionPics/right.png");
}

void mousePressed(){
  Particle p = new Particle(mouseX, mouseY, 0,0, w, h, "Particle" + particles.size());
  particles.add(p);
  
  oldMouse = new PVector(mouseX, mouseY);
  newMouse = oldMouse;
}

void mouseDragged(){
  newMouse = new PVector(mouseX, mouseY);
  //drawVelLine(); 
}

void mouseReleased(){
  Particle lastParticle = particles.get(particles.size()-1);
  PVector newVel = PVector.sub(oldMouse, newMouse);
  newVel.div(100);
  lastParticle.setVelocity(newVel);
}

void keyPressed(){
  float controlAmount = 0.05;
  float amountX = 0, amountY = 0;
  
  if(keyCode == buttons[0]){
    amountX = 0;
    amountY = -controlAmount;
    picCounter = 1;
  }
  else if(keyCode == buttons[1]){
    amountX = 0;
    amountY = controlAmount;
    picCounter = 2;
  }
  else if (keyCode == buttons[2]){
    amountX = -controlAmount;
    amountY = 0;  
    picCounter = 3;
  }
  else if(keyCode == buttons[3]){
    amountX = controlAmount;
    amountY = 0;
    picCounter = 4;
  }
  
  else if (keyCode == 67){ 
    extForce.mult(0); // clears force when 'c' is pressed
    return;
  }
  
  else if (keyCode == 82){ // 'reset'. when 'r' is pressed particles disappear and time is set back to 0
    particleDeletion();  
    logger = createWriter("logger.txt");
    time = 0;
    
    oldMouse = new PVector(0,0,0);
    newMouse = new PVector(0,0,0);
    
    if(simPaused) {
      loop();
      simPaused = false;
    }
  }
  
  else if (keyCode == 80){ // 'pause', when 'p' is pressed time freezes - simulation is paused
    if(!simPaused) {
      noLoop();
      simPaused = true;
    }
    else {
      loop();
      simPaused = false;
    } 
  }
  
  // make image transparent
  makeImgTransparent();
  
  // apply force to each particle
  PVector correctionForce = new PVector(amountX, amountY);  
  extForce.add(correctionForce);
    
  // draw square at bottom of screen to indicate when external force is added
  //drawBottomSquare();
}

void keyReleased(){
  if(keyCode == buttons[0] || keyCode == buttons[1]){
    extForce.y = 0;
    picCounter = 0;
  }
  else if(keyCode == buttons[2] || keyCode == buttons[3]){
    extForce.x = 0;
    picCounter = 0;
  }
}

void draw(){  
  background(backgroundColour);
  drawAppropriatePicture();

  // particle force manipulation
  for(Particle p : particles){
    //p.addForce(wind);
    //p.addForce(gravity);
    p.addForce(extForce);
    p.update();
    p.display();
  }
  
  drawVelLine();
  
  particleDeath();

  collisionBetweenParticles();
  
  // show particle count
  showParticleCount(str(particles.size()));
  showTime(time++);
}
