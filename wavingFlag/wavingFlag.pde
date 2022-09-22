import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;

VerletPhysics2D physics;

int w = 800;
int h = 640;

PVector poleTop= new PVector(w/20, h/8);
PVector poleBottom = new PVector(w/20, h);

Flag flag;

int on = 1;
int time = 0;

void settings(){
  size(w,h);
}

void setup(){
  //frameRate(2);
  reset();

  createFlag();
}

void draw(){
  // clears screen
  background(255);
  showPole();
  flag.display();
  
  particles.get(flag.nCols-1).move(on*2, -2);
  particles.get(particles.size()-1).move(on*2, 2);
  
  //if(time++ % 5 == 0){
  //  on *= -1;
  //}
  
  physics.update();

}
