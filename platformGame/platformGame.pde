// Created 19th August 2022

final int w = 640;
final int h = 640; 
final int backgroundColour = 0; // 0 black, 255 white

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

// platforms
ArrayList<Platform> platforms = new ArrayList<Platform>();
int platformSpeed = 1;

//game time
int gameTime;

void settings(){
  size(w,h);
}

void setup(){
  particles = new ArrayList<Particle>();  
  background(backgroundColour);
  
  // load pictures
  photoUp = loadImage("DirectionPics/up.png");
  photoDown = loadImage("DirectionPics/down.png");
  photoLeft = loadImage("DirectionPics/left.png");
  photoRight = loadImage("DirectionPics/right.png");
  
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
  ++gameTime;
  
  background(backgroundColour);
  drawAppropriatePicture();
   
  // particle manipulation
  for(Particle p : particles){
    //p.addForce(wind);
    //p.addForce(gravity);
    p.addForce(extForce);
    p.update();
    p.display();
    //p.controlParticleColour();
  }
  
  // new platform addition
  if(gameTime % 200 == 0){
    Platform platf = new Platform(200, ++platformSpeed, w, h);
    platforms.add(platf);
  }
  
  // move platforms
  for(Platform platform : platforms){
    platform.move();
    platform.display();
  }
  
  
}
