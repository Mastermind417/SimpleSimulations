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
    stroke(0);
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
    if (horizontalBump) {
      directionFromCentre = -1;
      if (coordinatesY[0] > height/2) directionFromCentre = 1;
    } else {
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
    } else {
      // this should look at x-locations
      locationClosestToCentre = coordinatesX[0];
      for (int i = 1; i<vertices; i++) {
        int locX = coordinatesX[i];
        // the flip acts like reversing the greater operator
        if ( flip*locX > flip*locationClosestToCentre) locationClosestToCentre = locX;
      }
    }
  }

  void findExtremePoints() {
    int[] coords = coordinatesX;
    int[] otherCoords = coordinatesY;
    if (!horizontalBump) {
      coords = coordinatesY;
      otherCoords = coordinatesX;
    }

    lowestTip = width + 1; // i.e. a large number
    highestTip = 0;
    for (int i = 0; i < vertices; i++) {
      if (otherCoords[i] == locationClosestToCentre) {
        int currentLoc = coords[i];
        if (currentLoc > highestTip) highestTip = currentLoc;
        if (currentLoc < lowestTip) lowestTip = currentLoc;
      }
    }
  }
}

class AngledPiece {
  int x1;
  int y1;
  int x2;
  int y2;
  float gradient;
  PVector grad;
  PVector tangent;
  String name;

  int numPoints = 1000;
  ArrayList<FloatList> allPoints;

  AngledPiece(int bumpIndex, int vertexIndex1, int vertexIndex2) {
    name = "AngledPiece" + (angledPieces.size() + 1); // AnglePiece1, AnglePiece2, ...
    
    Bump b = bumps.get(bumpIndex);
    x1 = b.coordinatesX[vertexIndex1];
    x2 = b.coordinatesX[vertexIndex2];
    y1 = b.coordinatesY[vertexIndex1];
    y2 = b.coordinatesY[vertexIndex2];
    
    findSlope();
    allPoints = findAllPoints();
    
    //printVertices();
  }

  ArrayList<FloatList> findAllPoints() {
    ArrayList<FloatList> points = new ArrayList<FloatList>();
    
    logger.println(name);
    // discretize line from (xMin,yMin) to (xMax,yMax)
    float dx = (x2-x1) / float(numPoints);
    float dy = (y2-y1) / float(numPoints);
    
    logger.println("( " + x1 + " , " + y1 + " ) ( " + x2 + " , " + y2 + " )");
    for(int i = 0; i <= numPoints; i++){
      float x = x1 + i*dx;
      float y = y1 + i*dy;
      points.add(new FloatList (x,y));
      logger.println(x + " , " + y);
    }
    
    logger.flush();
    
    return points;
  }
  
  void findSlope(){
    float dx = x2-x1;
    float dy = y2-y1;
    
    gradient = dx/dy;
    grad = new PVector(dx, dy);
    
    // need to adjust tangent vector to points 'inwards', i.e. towards pool table
    tangent = new PVector(1, -gradient);
    tangent.mult(-1);
    tangent.normalize();
    
    println(name + " " + gradient + " " + tangent);
  }
  
  void display(){
    //print("should draw");
    //fill(219,42,42);
    strokeWeight(2);
    //stroke(219,42,42);
    stroke(200);
    line(x1,y1,x2,y2);
  }
  
  void printVertices(){
    println(name);
    println(x1 + " , " + y1);
    println(x2 + " , " + y2);
    println(" ");
  }
}
