int w = 640;
int h = 640;

PVector oldMouse;
PVector newMouse;

boolean lineShouldAppear;
Particle particleSelected;

ArrayList<Particle> particles;

//VerletSpring2D spring = new VerletSpring2D(

void settings(){
  size(w, h); 
}

void setup(){
  reset();
}

void draw(){
  background(255);
    
  drawParticleLine();
  displayParticles();
}

void keyPressed(){
  // 67 is key 'c' for create
  if(keyCode == 67){
      Particle p1 = new Particle(mouseX, mouseY);
      particles.add(p1);
      return;
  } 
  
  // 82 is key 'r' for reset
  if(keyCode == 82) reset();
}

void mousePressed(){
  if(lineShouldAppear) return;
  
  for(Particle p : particles){
    float leftBoundary = p.position.x - p.radius;
    float rightBoundary = p.position.x + p.radius;
    float upBoundary = p.position.y - p.radius;
    float downBoundary = p.position.y + p.radius;
    
    if(mouseX >= leftBoundary && mouseX <= rightBoundary && mouseY >= upBoundary && mouseY <= downBoundary){
        particleSelected = p;
        oldMouse.set(p.position.x, p.position.y);
        newMouse.set(mouseX, mouseY);
        lineShouldAppear = true;
        break;
    }
  }
}

void mouseDragged(){
  newMouse.set(mouseX, mouseY);
}

void mouseReleased(){
  if(!lineShouldAppear) return;
  
  moveParticle(oldMouse.x - newMouse.x, oldMouse.y - newMouse.y);
  
  lineShouldAppear = false;

  newMouse.set(new PVector(0,0));
  oldMouse.set(new PVector(0,0));  
}

void reset(){
  particles = new ArrayList<Particle>();
  
  oldMouse = new PVector(0,0);
  newMouse = new PVector(0,0);
  
  lineShouldAppear = false;
  particleSelected = null;
}

void displayParticles(){
  if(particles.size() == 0 || particles == null) return;
  
  for(Particle p : particles){
      p.display();
      p.move();
  }
}

void moveParticle(float vx, float vy){
  if(particles.size() == 0 || particles == null) return;
  
  for(Particle p : particles){
    if(p.name == particleSelected.name){
      p.setVelocity(vx, vy);
      break;
    }
  }
}

void drawParticleLine(){
  if(!lineShouldAppear) return;
  
  fill(240, 39, 52);
  strokeWeight(1);
  line(oldMouse.x, oldMouse.y, newMouse.x, newMouse.y);
}
