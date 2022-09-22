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

void settings(){
  size(w,h);
}

void setup(){
  reset();

  createFlag();
}

void draw(){
  physics.update();
  
  // clears screen
  background(255);
  
  showPole();
  applyForcesOnParticles();
  flag.display();
  
  //particles.get(flag.nCols-1).move(2, -2);
  //particles.get(particles.size()-1).move(2, 2);
  
  
  

}
