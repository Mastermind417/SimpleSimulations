int w = 1000;
int h = 1000;

int gridSpacing = 10;

int bColour[] = {255, 255, 255};

ArrayList<PVector> occupiedPixels;

void settings(){
  size(640,640);  
}

void setup(){
  reset();
}

void draw(){
  background(bColour[0]);
  
  showGrid();
  showSand();
  
  if(mousePressed)createSand();
  
}

void mousePressed(){
  createSand();
}

void showGrid(){
  stroke(0);
  
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
}

void reset(){
  // this is what happens at scren initialisation
  background(bColour[0]);
  
  sands = new ArrayList<Sand>();
  occupiedPixels = new ArrayList<PVector>();

}