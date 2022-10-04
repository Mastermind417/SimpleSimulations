int holeRadius = 50;
int holeDiameter = 2*holeRadius;

int hDLarge = 100;
int hDSmall = 80;

// left to right and top to bottom
ArrayList<Edge> edges;
ArrayList<Hole> holes;
ArrayList<Bump> bumps;

int[] red = new int[]{224, 36, 36};
int[] yellow = new int[]{245, 235, 42};
int[] white = new int[]{255, 255, 255};
int[] black = new int[]{0, 0, 0};

class Edge {
  PVector position;
  PVector size;
  int numberScrews = 0;

  Edge(int x, int y, int w, int h) {
    position = new PVector(x, y);
    size = new PVector(w, h);

    calculateScrews();
  }

  void display() {
    fill(102, 13, 5);
    rect(position.x, position.y, size.x, size.y);
    displayScrews();
  }

  void calculateScrews() {
    numberScrews = 6;
    if (size.y > size.x) {
      numberScrews = 3;
    }
  }

  void displayScrews() {
    fill(255);

    if (numberScrews == 6) {
      int gap = int(size.x/(numberScrews+1));
      for (int i = 1; i<=numberScrews; i++) {
        circle(position.x + i*gap, position.y+ size.y/2, 5);
      }
    } else {
      int gap = int(size.y/(numberScrews+1));
      for (int i = 1; i<=numberScrews; i++) {
        circle(position.x + size.x/2, position.y + i*gap, 5);
      }
    }
  }
}

class Hole {
  PVector position;
  int diameter;
  float radius;

  Hole(int x, int y, int size_) {
    position = new PVector(x, y);
    diameter = size_;
    radius = diameter/2;
  }

  void display() {
    fill(0);
    circle(position.x, position.y, diameter);
  }
}

class Bump {
  int vertices;
  int[] coordinatesX;
  int[] coordinatesY;

  String name;
  
  boolean horizontalBump;
  int directionFromCentre; 
  int locationClosestToCentre;
  
  int lowestTip;
  int highestTip;

  Bump(int nV, int[] cordsX, int[] cordsY) {
    vertices = nV; // nV
    coordinatesX = cordsX; // coordinates come in pairs of number of vertices: x1, x2, ..., x_nV
    coordinatesY = cordsY; // coordinates come in pairs of number of vertices: y1, y2, ..., y_nV

    name = "Bump" + (bumps.size()+1); // Bump1, Bump2, ..., Bump 6

    allocateQuantitiesNeededForCollisionResolution();
    findSideClosestToBilliardCentre();
    findExtremePoints();
  }

  void drawVertices() {
    for (int i = 0; i < vertices; i++) {
      vertex(coordinatesX[i], coordinatesY[i]);
    }
  }

  void display() {
    beginShape();
    fill(6, 65, 95);
    drawVertices();
    endShape(CLOSE);
  }

  void allocateQuantitiesNeededForCollisionResolution() {
    // allocate bump type, i.e. horizontal or not
    horizontalBump = true;
    if (coordinatesY[0] != coordinatesY[1]) horizontalBump = false;
    
    // allocate direction from centre, -1 for left, 1 for right or -1 for up, 1 for down according to bump type
    if(horizontalBump) {
      directionFromCentre = -1;
      if (coordinatesY[0] > height/2) directionFromCentre = 1;
    }
    else{
      directionFromCentre = -1;
      if (coordinatesX[0] > width/2) directionFromCentre = 1;      
    }
  }

  void findSideClosestToBilliardCentre() {
    /*
    Finds side location closest to centre needed for collision resolution.
    */

    int flip = -directionFromCentre;

    if (horizontalBump) {
      // this should look at y-locations
      locationClosestToCentre = coordinatesY[0];
      for (int i = 1; i<vertices; i++) {
        int locY = coordinatesY[i];       
        // the flip acts like reversing the greater operator
        if ( flip*locY > flip*locationClosestToCentre) locationClosestToCentre = locY;
      }
    } 
    else {
      // this should look at x-locations
      locationClosestToCentre = coordinatesX[0];
        for (int i = 1; i<vertices; i++) {
          int locX = coordinatesX[i];
          // the flip acts like reversing the greater operator
          if ( flip*locX > flip*locationClosestToCentre) locationClosestToCentre = locX;
        }
    }
  }
  
  void findExtremePoints(){
    int[] coords = coordinatesX;
    int[] otherCoords = coordinatesY;
    if(!horizontalBump) {
      coords = coordinatesY;
      otherCoords = coordinatesX;
    }
    
    lowestTip = width + 1; // i.e. a very large number
    highestTip = 0;
    for(int i = 0; i < vertices; i++){
      if(otherCoords[i] == locationClosestToCentre){
        int currentLoc = coords[i];
        if(currentLoc > highestTip) highestTip = currentLoc;
        if(currentLoc < lowestTip) lowestTip = currentLoc;
      }
    }
  }
}
  void createEdges() {
    edges = new ArrayList<Edge>();

    edges.add(new Edge( hDLarge, 0, width-2*hDLarge, hDLarge/2 ));
    edges.add(new Edge( 0, hDLarge, hDLarge/2, height-2*hDLarge ));

    edges.add(new Edge( width-hDLarge/2, hDLarge, hDLarge/2, height-2*hDLarge ));
    edges.add(new Edge( hDLarge, height-hDLarge/2, width-2*hDLarge, hDLarge/2 ));
  }

  void drawEdges() {
    if (edges == null || edges.size() == 0) return;
    for (Edge e : edges) {
      e.display();
    }
  }

  void createHoles() {
    holes = new ArrayList<Hole>();

    holes.add(new Hole( hDLarge/2, hDLarge/2, hDLarge ));
    holes.add(new Hole( width/2, hDSmall/2, hDSmall ));
    holes.add(new Hole( width-hDLarge/2, hDLarge/2, hDLarge ));
    holes.add(new Hole( hDLarge/2, height-hDLarge/2, hDLarge ));
    holes.add(new Hole( width/2, height-hDSmall/2, hDSmall ));
    holes.add(new Hole( width-hDLarge/2, height-hDLarge/2, hDLarge ));
  }

  void drawHoles() {
    if (holes == null || holes.size() == 0) return;
    for (Hole h : holes) {
      h.display();
    }
  }

  void createBumps() {
    bumps = new ArrayList<Bump>();

    int lG = 27; // large gap
    int sG = 5; // small gap
    int bumpW = 25; // bump width

    bumps.add(new Bump( 4, new int[] {hDLarge, width/2-hDSmall/2, width/2-hDSmall/2-sG, hDLarge+lG}, new int[] {hDLarge/2, hDLarge/2, hDLarge/2+bumpW, hDLarge/2+bumpW} ));
    bumps.add(new Bump( 4, new int[] {width/2+hDSmall/2, width-hDLarge, width-hDLarge-lG, width/2+hDSmall/2+sG}, new int[] {hDLarge/2, hDLarge/2, hDLarge/2+bumpW, hDLarge/2+bumpW} ));
    bumps.add(new Bump( 4, new int[] {hDLarge/2, hDLarge/2+bumpW, hDLarge/2+bumpW, hDLarge/2}, new int[] {hDLarge, hDLarge+lG, height-(hDLarge+lG), height-hDLarge} ));
    bumps.add(new Bump( 4, new int[] {width-hDLarge/2, width-(hDLarge/2+bumpW), width-(hDLarge/2+bumpW), width-hDLarge/2}, new int[] {hDLarge, hDLarge+lG, height-(hDLarge+lG), height-hDLarge} ));
    bumps.add(new Bump( 4, new int[] {hDLarge, width/2-hDSmall/2, width/2-hDSmall/2-sG, hDLarge+lG}, new int[] {height-hDLarge/2, height-hDLarge/2, height-(hDLarge/2+bumpW), height-(hDLarge/2+bumpW)} ));
    bumps.add(new Bump( 4, new int[] {width/2+hDSmall/2, width-hDLarge, width-hDLarge-lG, width/2+hDSmall/2+sG}, new int[] {height-hDLarge/2, height-hDLarge/2, height-(hDLarge/2+bumpW), height-(hDLarge/2+bumpW)} ));
  }

  void drawBumps() {
    if (bumps == null || bumps.size() == 0) return;
    for (Bump b : bumps) {
      b.display();
    }
  }

  void initialiseBalls() {
    int dist = 40;
    PVector rightMark = new PVector(3*width/4, height/2);
    PVector leftMark = new PVector(1*width/4, height/2);

    createBallAtPosition(rightMark.x, rightMark.y, red);

    createBallAtPosition(rightMark.x + dist, rightMark.y + dist/2, yellow);
    createBallAtPosition(rightMark.x + dist, rightMark.y - dist/2, red);

    createBallAtPosition(rightMark.x + 2*dist, rightMark.y, black);
    createBallAtPosition(rightMark.x + 2*dist, rightMark.y - 2*dist/2, yellow);
    createBallAtPosition(rightMark.x + 2*dist, rightMark.y + 2*dist/2, red);


    //createBallAtPosition(mark.x + 3*dist, mark.y);
    createBallAtPosition(rightMark.x + 3*dist, rightMark.y + dist/2, red);
    createBallAtPosition(rightMark.x + 3*dist, rightMark.y + 3*dist/2, yellow);
    createBallAtPosition(rightMark.x + 3*dist, rightMark.y - dist/2, yellow);
    createBallAtPosition(rightMark.x + 3*dist, rightMark.y - 3*dist/2, red);

    createBallAtPosition(rightMark.x + 4*dist, rightMark.y, red);
    createBallAtPosition(rightMark.x + 4*dist, rightMark.y - 2*dist/2, yellow);
    createBallAtPosition(rightMark.x + 4*dist, rightMark.y + 2*dist/2, yellow);
    createBallAtPosition(rightMark.x + 4*dist, rightMark.y - 4*dist/2, red);
    createBallAtPosition(rightMark.x + 4*dist, rightMark.y + 4*dist/2, yellow);

    initialiseWhiteBall();
  }

  void initialiseWhiteBall() {
    PVector leftMark = new PVector(1*width/4, height/2);
    createBallAtPosition(leftMark.x, leftMark.y, white);
  }

  void createBallAtPosition(float posx, float posy, int[] colour) {
    Particle p = new Particle(posx, posy, 0, 0, width, height, colour);
    particles.add(p);
  }

  boolean whiteBallFound(PVector mouse) {
    Particle whiteBall = findWhiteBall();

    float r = whiteBall.radius;
    PVector pos = whiteBall.position;

    if (mouse.x <= pos.x + r && mouse.x >= pos.x - r && mouse.y <= pos.y + r && mouse.y >= pos.y - r) return true;
    return false;
  }

  Particle findWhiteBall() {
    Particle whiteBall = particles.get(particles.size()-1);
    // not technically needed
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      if (p.colour == white) {
        whiteBall = p;
        break;
      }
    }
    return whiteBall;
  }
  
  void positionWhiteBall(int posX, int posY){
    Particle whiteBall = findWhiteBall();
    whiteBall.setPosition(new PVector(posX, posY));
    whiteBall.setVelocity(new PVector(0, 0));
  }
