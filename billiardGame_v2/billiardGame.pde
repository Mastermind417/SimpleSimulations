final int h = 900;
final int w = 1600;

ArrayList<Particle> particles;

PVector oldMouse = new PVector(0,0,0);
PVector newMouse = new PVector(0,0,0);

boolean whiteBallFound = false;
boolean billiardHasSlowed = false;

int time;
PrintWriter logger;

void settings(){
  size(w,h);
}

void setup(){  
  particles = new ArrayList<Particle>(); 
  logger = createWriter("logger.txt");
  time = 0; 
    
  oldMouse = new PVector(0,0,0);
  newMouse = new PVector(0,0,0);
  
  createEdges();
  createBumps();
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
  
  if(key == 'p'){ // 'p', p for position ball
    positionWhiteBall(mouseX, mouseY);    
  }
  
  if(key == 's'){ // 's', s for slow
    if(!billiardHasSlowed) {
      frameRate(5);
    }
    else{
      frameRate(60);
    }
    billiardHasSlowed = !billiardHasSlowed;
  }  
}


void draw(){
  // table
  background(#2481AD);
  stroke(255);
  line(width/4,0,width/4,height);
  noStroke();
  
  // table edges and holes
  drawEdges();
  drawBumps();
  drawAngledPieces();
  drawPiecesBehindHoles();
  drawHoles();
  
  moveParticles();
  collisionBetweenParticles();
  collisionBetweenParticlesAndAngledPieces();
  collisionBetweenParticlesAndBumps();
  collisionBetweenParticlesAndHoles();
  
  // for shooting a billiard
  drawVelLine();
  
  showTime();
  ++time;
}

void drawVelLine(){
  if(mousePressed && whiteBallFound){
    strokeWeight(2);
    fill(128,128,128);
    line(oldMouse.x, oldMouse.y, newMouse.x, newMouse.y);
  }
}

void showTime(){
  textSize(25);
  text("Time: " + time, 5*width/6,height-15, 10);
  
}
