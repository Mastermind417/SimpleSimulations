int w = 1000;
int h = 800;

int gridSpacing = 10;

int bColour[] = {255, 255, 255};

boolean sandOn;

PrintWriter logger;

int time;

void settings(){
  size(w,h);  
}

void setup(){
  reset();
  logger = createWriter("logger.txt"); 

  //frameRate(5);
}

void draw(){
  background(bColour[0]);
  
  //showGrid();
  showSand();
  showWater();
  
  if(mousePressed){
    createSand();
    createWater();
  }
  
  ++time;
}

void mousePressed(){
  createSand();
}

void showGrid(){
  stroke(0);
  strokeWeight(1);
  
  int d = gridSpacing; // this is the spacing between the grid squares
  for(int i = d; i<height;i+=d){
    line(0,i,width,i);
  }
  
  for(int j = d; j<width;j+=d){
    line(j,0,j,height);
  }
}

void keyPressed(){
  // 'r' is pressed
  if(keyCode == 82) reset();
  if(keyCode == 83) sandOn = !sandOn;
}

void reset(){
  // this is what happens at screen initialisation
  background(bColour[0]);
  sandOn = true;
  
  sand = new ArrayList<Sand>();
  water = new ArrayList<Water>();
  occupiedPixels = new ArrayList<Pixel>();
  
  time = 0;
}
