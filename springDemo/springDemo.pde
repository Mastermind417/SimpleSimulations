import toxi.audio.*;
//import toxi.color.*;
//import toxi.color.theory.*;
import toxi.data.csv.*;
import toxi.data.feeds.*;
import toxi.data.feeds.util.*;
import toxi.doap.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.geom.nurbs.*;
import toxi.image.util.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.music.*;
import toxi.music.scale.*;
import toxi.net.*;
import toxi.newmesh.*;
import toxi.nio.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.processing.*;
import toxi.sim.automata.*;
import toxi.sim.dla.*;
import toxi.sim.erosion.*;
import toxi.sim.fluids.*;
import toxi.sim.grayscott.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.volume.*;

int w = 640;
int h = 640;

ArrayList<Particle> particles;


//VerletSpring2D spring = new VerletSpring2D(

void keyPressed(){
  // 67 is key 'c' for create
  if(keyCode == 67){
      Particle p1 = new Particle(mouseX, mouseY);
      particles.add(p1);
      return;
  } 
  
  // 67 is key 'd' for delete
  if(keyCode == 68) reset();
}

void mousePressed(){
  //PVector mouse = new PVector(mouseX, mouseY);
  
  Particle pSelect = null;
  for(Particle p : particles){
    float leftBoundary = p.position.x - p.radius;
    float rightBoundary = p.position.x + p.radius;
    float upBoundary = p.position.y - p.radius;
    float downBoundary = p.position.y + p.radius;
    
    if(mouseX >= leftBoundary && mouseX <= rightBoundary && mouseY >= upBoundary && mouseY <= downBoundary){
        pSelect = p;
        break;
    }
  }
}

void settings(){
  size(w, h);
  
}

void setup(){
  reset();
}

void draw(){
  background(255);
  
  displayParticles();
}

void displayParticles(){
  if(particles.size() == 0 || particles == null) return;
  
  for(Particle p : particles){
    p.display();
  }
}

void reset(){
  particles = new ArrayList<Particle>();
}
