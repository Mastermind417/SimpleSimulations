import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.geom.*;

VerletPhysics2D physics;

int w = 800;
int h = 640;

PVector poleTop= new PVector(w/20, h/8);
PVector poleBottom = new PVector(w/20, h);

Flag flag;

Vec2D gravity;
Vec2D wind;

int particleRows = 8;
int particleCols = 20;

PImage img;

void settings(){
  size(w,h, P2D);
}

void setup(){
  reset();
  createFlag();
  
  img = loadImage("michalis.jpg");
}

void draw(){
  physics.update();
  
  // clears screen
  background(255);
  
  showPole();
  applyForcesOnParticles();
  flag.display();
  
  
  //applyTextureOnFlag();
  
  

}
