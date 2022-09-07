int holeRadius = 50;
int holeDiameter = 2*holeRadius;

// left to right and top to bottom
ArrayList<Edge> edges;
ArrayList<Hole> holes;

class Edge{
  PVector position;
  PVector size;
  int[] radii;
  
  Edge(int x, int y, int w, int h, int pos1, int pos2, int pos3, int pos4){
    position = new PVector(x,y);
    size = new PVector(w,h);
    radii = new int[]{pos1,pos2,pos3,pos4};
  }
  
  void update(){
    fill(#896215);
    rect(position.x,position.y,size.x,size.y,radii[0],radii[1],radii[2],radii[3]);
  }
}

class Hole{
  PVector position;
  int diameter;
  float radius;
  
  Hole(int x, int y, int size_){
    position = new PVector(x,y);
    diameter = size_;
    radius = diameter/2;
    
  }
  
  void update(){
    fill(0);
    circle(position.x,position.y,diameter);
  }
}

void createEdges(){
  edges = new ArrayList<Edge>();
  
  int hR = holeRadius;
  
  edges.add(new Edge( hR,0,width/2-2*hR,hR,0,0,200,200 ));
  edges.add(new Edge( width/2+hR,0,width/2-2*hR,hR, 0,0,200,200 ));
  
  edges.add(new Edge( 0,hR,hR,height-2*hR,0,200,200,0 ));
  edges.add(new Edge( width-hR/2,hR,hR,height-2*hR,200,0,0,200 ));
  
  edges.add(new Edge( hR,height-hR/2,width/2-2*hR,hR,200,200,0,0 ));
  edges.add(new Edge( width/2+hR,height-hR/2,width/2-2*hR,hR, 200,200,0,0 ));
  
}

void drawSideEdges(){
  for(Edge e : edges){
    e.update();
  }
}

void createHoles(){
  holes = new ArrayList<Hole>();
  
  int hD = holeDiameter;
  
  holes.add(new Hole( 0+hD/3,0+hD/3,hD ));
  holes.add(new Hole( width-hD/3,0+hD/3,hD ));
  holes.add(new Hole( 0+hD/3,height-hD/3,hD ));
  holes.add(new Hole( width-hD/3,height-hD/3,hD ));
  holes.add(new Hole( width/2,0+hD/3,hD ));
  holes.add(new Hole( width/2,height-hD/3,hD ));
}

void drawHoles(){
  for(Hole h : holes){
    h.update();
  }
}

void initialiseBalls(){
  int dist = 31;
  PVector rightMark = new PVector(3*width/4,height/2);
  PVector leftMark = new PVector(1*width/4,height/2);
  
  createBallAtPosition(rightMark.x, rightMark.y, red);
  
  createBallAtPosition(rightMark.x + dist, rightMark.y + dist/2, yellow);
  createBallAtPosition(rightMark.x + dist, rightMark.y - dist/2, red);
  
  createBallAtPosition(rightMark.x + 2*dist, rightMark.y,red);
  createBallAtPosition(rightMark.x + 2*dist, rightMark.y - 2*dist/2,yellow);
  createBallAtPosition(rightMark.x + 2*dist, rightMark.y + 2*dist/2,red);
  
  
  //createBallAtPosition(mark.x + 3*dist, mark.y);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y + dist/2,yellow);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y + 3*dist/2,red);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y - dist/2,yellow);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y - 3*dist/2,red);
  
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y,red);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y - 2*dist/2,yellow);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y + 2*dist/2,red);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y - 4*dist/2,yellow);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y + 4*dist/2,red);
  
  initialiseWhiteBall();
  
}

void initialiseWhiteBall(){
  PVector leftMark = new PVector(1*width/4,height/2);
  createBallAtPosition(leftMark.x, leftMark.y, white);
}

void createBallAtPosition(float posx, float posy, int[] colour){
  Particle p = new Particle(posx, posy, 0,0, width, height, colour);
  particles.add(p);
}

boolean whiteBallFound(PVector mouse){
  Particle whiteBall = findWhiteBall();
  
  float r = whiteBall.radius;
  PVector pos = whiteBall.position;
  
  if(mouse.x <= pos.x + r && mouse.x >= pos.x - r && mouse.y <= pos.y + r && mouse.y >= pos.y - r) return true;
  return false;
}

Particle findWhiteBall(){
  Particle whiteBall = particles.get(particles.size()-1);
  // not technically needed
  for(int i = particles.size()-1; i >= 0; i--){
    Particle p = particles.get(i);
    if(p.colour == white) {
      whiteBall = p;
      break;
    }
  }
  return whiteBall;
}
