final int h = 800;
final int w = 2*h; // From wiki after 'billiard table size' search: "The length of a "Regulation Standard 8ft" table should be 88 inches long and 44 inches wide."

ArrayList<Particle> particles;

PVector oldMouse = new PVector(0,0,0);
PVector newMouse = new PVector(0,0,0);

int[] red = new int[]{224,36,36};
int[] yellow = new int[]{245,235,42};
int[] white = new int[]{255,255,255};

boolean whiteBallFound = false;

void settings(){
  size(w,h);
}

void setup(){
  particles = new ArrayList<Particle>(); 
    
  oldMouse = new PVector(0,0,0);
  newMouse = new PVector(0,0,0);
  
  createEdges();
  createHoles();
  
  initialiseBalls();
  
}

void mousePressed(){
  
  oldMouse = new PVector(mouseX, mouseY);
  
  whiteBallFound = whiteBallFound(oldMouse);
  Particle whiteParticle = findWhiteBall();
  
  if(whiteBallFound) oldMouse = whiteParticle.position;
  newMouse = oldMouse;
}

void mouseDragged(){
  newMouse = new PVector(mouseX, mouseY);
}

void mouseReleased(){
  if(!whiteBallFound) return;
  
  Particle whiteParticle = findWhiteBall();
  PVector newVel = PVector.sub(oldMouse, newMouse);
  newVel.div(10);
  whiteParticle.setVelocity(newVel);
  whiteBallFound = false;
}

void keyPressed(){
    if (keyCode == 82){ // 'reset'. when 'r' is pressed particles disappear and time is set back to 0
    setup();
  }
}


void draw(){
  background(#12C65B);
  
  // table edges and holes
  drawSideEdges();
  drawHoles();
  
  moveParticles();
  collisionBetweenParticles();
  collisionBetweenParticlesAndEdges();
  collisionBetweenParticlesAndHoles();
  
  // for shooting a billiard
  drawVelLine();
}

void drawVelLine(){
  if(mousePressed && whiteBallFound){
    strokeWeight(2);
    fill(128,128,128);
    line(oldMouse.x, oldMouse.y, newMouse.x, newMouse.y);
  }
}
