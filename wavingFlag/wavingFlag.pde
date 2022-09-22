import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;

VerletPhysics2D physics;

int w = 800;
int h = 640;

PVector poleTop= new PVector(w/20, h/8);
PVector poleBottom = new PVector(w/20, h);

Flag flag;

PVector gravity;
PVector wind;

PImage img;

void settings(){
  size(w,h, P2D);
}

void setup(){
  reset();
  createFlag();
  
  img = loadImage("frog.jpg");
}

void draw(){
  physics.update();
  
  // clears screen
  background(255);
  
  showPole();
  applyForcesOnParticles();
  flag.display();
  
  
  applyTextureOnFlag();
  
  

}
