int holeRadius = 50;
int holeDiameter = 2*holeRadius;

// left to right and top to bottom
ArrayList<Edge> edges;
ArrayList<Hole> holes;

int[] red = new int[]{224,36,36};
int[] yellow = new int[]{245,235,42};
int[] white = new int[]{255,255,255};
int[] black = new int[]{0,0,0};

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
  
  edges.add(new Edge( 5*hR/3,0,width/2-(hR+5*hR/3),hR,0,0,200,200 ));
  edges.add(new Edge( width/2+hR,0,width/2-(hR+5*hR/3),hR, 0,0,200,200 ));
  
  edges.add(new Edge( 0,5*hR/3,hR,height-(2*5*hR/3),0,200,200,0 ));
  edges.add(new Edge( width-hR,5*hR/3,hR,height-(2*5*hR/3),200,0,0,200 ));
  
  edges.add(new Edge( 5*hR/3,height-hR,width/2-(hR+5*hR/3),hR,200,200,0,0 ));
  edges.add(new Edge( width/2+hR,height-hR,width/2-(hR+5*hR/3),hR, 200,200,0,0 ));
}

void drawSideEdges(){
  if(edges == null || edges.size() == 0) return;
  for(Edge e : edges){
    e.update();
  }
  
  // add white pieces to hide green table floor near holes
  patchHolesAndEdges();
  
  // this is for collision understanding near the curved piece
  //showCurvedEdgeArea();  
}

void patchHolesAndEdges(){
  fill(#E8E1E1);
  
  int hR = holeRadius;
  
  // top left
  triangle(4*hR/3, 0, 5*hR/3, 0, 5*hR/3, hR/2 );
  triangle(0, 4*hR/3, 0, 5*hR/3, hR/2, 5*hR/3);
  
  // bottom left
  triangle(0, height-4*hR/3, 0, height-5*hR/3, hR/2, height-5*hR/3);
  triangle(4*hR/3, height, 5*hR/3, height, 5*hR/3, height-hR/2 );
  
  // top right
  triangle(width-4*hR/3, 0, width-5*hR/3, 0, width-5*hR/3, hR/2 );
  triangle(width, 4*hR/3, width, 5*hR/3, width-hR/2, 5*hR/3);  
  
  // top left
  triangle(width, height-4*hR/3, width, height-5*hR/3, width-hR/2, height-5*hR/3);
  triangle(width-4*hR/3, height, width-5*hR/3, height, width-5*hR/3, height-hR/2 );
}

void showCurvedEdgeArea(){
  float cF = holeRadius/3;
  strokeWeight(2);
  stroke(0);
  line(edges.get(0).position.x,0,edges.get(0).position.x, width/6);
  line(edges.get(0).position.x+cF,0,edges.get(0).position.x+cF, width/6);
  line(edges.get(0).position.x+edges.get(0).size.x,0,edges.get(0).position.x+edges.get(0).size.x, width/6);
  line(edges.get(0).position.x+edges.get(0).size.x-cF,0,edges.get(0).position.x+edges.get(0).size.x-cF, width/6);
  
  line(edges.get(1).position.x,0,edges.get(1).position.x, width/6);
  line(edges.get(1).position.x+cF,0,edges.get(1).position.x+cF, width/6);
  line(edges.get(1).position.x+edges.get(1).size.x,0,edges.get(1).position.x+edges.get(1).size.x, width/6);
  line(edges.get(1).position.x+edges.get(1).size.x-cF,0,edges.get(1).position.x+edges.get(1).size.x-cF, width/6);
  
  line(edges.get(5).position.x,height,edges.get(5).position.x, height-width/6);
  line(edges.get(5).position.x+cF,height,edges.get(5).position.x+cF, height-width/6);
  line(edges.get(5).position.x+edges.get(5).size.x,height,edges.get(5).position.x+edges.get(5).size.x, height-width/6);
  line(edges.get(5).position.x+edges.get(5).size.x-cF,height,edges.get(5).position.x+edges.get(5).size.x-cF, height-width/6);
  
  line(edges.get(4).position.x,height,edges.get(4).position.x, height-width/6);
  line(edges.get(4).position.x+cF,height,edges.get(4).position.x+cF, height-width/6);
  line(edges.get(4).position.x+edges.get(4).size.x,height,edges.get(4).position.x+edges.get(4).size.x, height-width/6);
  line(edges.get(4).position.x+edges.get(4).size.x-cF,height,edges.get(4).position.x+edges.get(4).size.x-cF, height-width/6);

  line(0,edges.get(2).position.y,width/6, edges.get(2).position.y);
  line(0,edges.get(2).position.y+cF,width/6, edges.get(2).position.y+cF);
  line(0,edges.get(2).position.y+edges.get(2).size.y,width/6, edges.get(2).position.y+edges.get(2).size.y);
  line(0,edges.get(2).position.y+edges.get(2).size.y-cF,width/6,edges.get(2).position.y+edges.get(2).size.y-cF);

  line(width,edges.get(3).position.y,width-width/6, edges.get(3).position.y);
  line(width,edges.get(3).position.y+cF,width-width/6, edges.get(3).position.y+cF);
  line(width,edges.get(3).position.y+edges.get(3).size.y,width-width/6, edges.get(3).position.y+edges.get(3).size.y);
  line(width,edges.get(3).position.y+edges.get(3).size.y-cF,width-width/6,edges.get(3).position.y+edges.get(3).size.y-cF);

  
}

void createHoles(){
  holes = new ArrayList<Hole>();
  
  int hD = holeDiameter;
  
  holes.add(new Hole( 0+hD/3,0+hD/3,hD ));
  holes.add(new Hole( width-hD/3,0+hD/3,hD ));
  holes.add(new Hole( 0+hD/3,height-hD/3,hD ));
  holes.add(new Hole( width-hD/3,height-hD/3,hD ));
  holes.add(new Hole( width/2,0+hD/6,hD ));
  holes.add(new Hole( width/2,height-hD/6,hD ));
}

void drawHoles(){
  if(holes == null || holes.size() == 0) return;
  for(Hole h : holes){
    h.update();
  }
}

void initialiseBalls(){
  int dist = 40;
  PVector rightMark = new PVector(3*width/4,height/2);
  PVector leftMark = new PVector(1*width/4,height/2);
  
  createBallAtPosition(rightMark.x, rightMark.y, red);
  
  createBallAtPosition(rightMark.x + dist, rightMark.y + dist/2, yellow);
  createBallAtPosition(rightMark.x + dist, rightMark.y - dist/2, red);
  
  createBallAtPosition(rightMark.x + 2*dist, rightMark.y,black);
  createBallAtPosition(rightMark.x + 2*dist, rightMark.y - 2*dist/2,yellow);
  createBallAtPosition(rightMark.x + 2*dist, rightMark.y + 2*dist/2,red);
  
  
  //createBallAtPosition(mark.x + 3*dist, mark.y);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y + dist/2,red);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y + 3*dist/2,yellow);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y - dist/2,yellow);
  createBallAtPosition(rightMark.x + 3*dist, rightMark.y - 3*dist/2,red);
  
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y,red);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y - 2*dist/2,yellow);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y + 2*dist/2,yellow);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y - 4*dist/2,red);
  createBallAtPosition(rightMark.x + 4*dist, rightMark.y + 4*dist/2,yellow);
  
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
