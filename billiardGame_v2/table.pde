int holeRadius = 50;
int holeDiameter = 2*holeRadius;

int hDLarge = 100;
int hDSmall = 80;

// left to right and top to bottom
ArrayList<Edge> edges;
ArrayList<Hole> holes;
ArrayList<Bump> bumps;
ArrayList<AngledPiece> angledPieces;

int[] red = new int[]{224, 36, 36};
int[] yellow = new int[]{245, 235, 42};
int[] white = new int[]{255, 255, 255};
int[] black = new int[]{0, 0, 0};

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
  angledPieces = new ArrayList<AngledPiece>();

  int lG = 27; // large gap
  int sG = 5; // small gap
  int bumpW = 25; // bump width

  bumps.add(new Bump( 4, new int[] {hDLarge, width/2-hDSmall/2, width/2-hDSmall/2-sG, hDLarge+lG}, new int[] {hDLarge/2, hDLarge/2, hDLarge/2+bumpW, hDLarge/2+bumpW} ));
  angledPieces.add(new AngledPiece(0, 0, 3));
  angledPieces.add(new AngledPiece(0, 1, 2));

  bumps.add(new Bump( 4, new int[] {width/2+hDSmall/2, width-hDLarge, width-hDLarge-lG, width/2+hDSmall/2+sG}, new int[] {hDLarge/2, hDLarge/2, hDLarge/2+bumpW, hDLarge/2+bumpW} ));
  angledPieces.add(new AngledPiece(1, 0, 3));
  angledPieces.add(new AngledPiece(1, 1, 2));

  bumps.add(new Bump( 4, new int[] {hDLarge/2, hDLarge/2+bumpW, hDLarge/2+bumpW, hDLarge/2}, new int[] {hDLarge, hDLarge+lG, height-(hDLarge+lG), height-hDLarge} ));
  angledPieces.add(new AngledPiece(2, 0, 1));
  angledPieces.add(new AngledPiece(2, 2, 3));

  bumps.add(new Bump( 4, new int[] {width-hDLarge/2, width-(hDLarge/2+bumpW), width-(hDLarge/2+bumpW), width-hDLarge/2}, new int[] {hDLarge, hDLarge+lG, height-(hDLarge+lG), height-hDLarge} ));
  angledPieces.add(new AngledPiece(3, 0, 1));
  angledPieces.add(new AngledPiece(3, 2, 3));

  bumps.add(new Bump( 4, new int[] {hDLarge, width/2-hDSmall/2, width/2-hDSmall/2-sG, hDLarge+lG}, new int[] {height-hDLarge/2, height-hDLarge/2, height-(hDLarge/2+bumpW), height-(hDLarge/2+bumpW)} ));
  angledPieces.add(new AngledPiece(4, 0, 3));
  angledPieces.add(new AngledPiece(4, 1, 2));

  bumps.add(new Bump( 4, new int[] {width/2+hDSmall/2, width-hDLarge, width-hDLarge-lG, width/2+hDSmall/2+sG}, new int[] {height-hDLarge/2, height-hDLarge/2, height-(hDLarge/2+bumpW), height-(hDLarge/2+bumpW)} ));
  angledPieces.add(new AngledPiece(5, 0, 3));
  angledPieces.add(new AngledPiece(5, 1, 2));
}

void drawBumps() {
  if (bumps == null || bumps.size() == 0) return;
  for (Bump b : bumps) {
    b.display();
  }
}

void drawAngledPieces() {
  if (angledPieces == null || angledPieces.size() == 0) return;
  for (AngledPiece ap : angledPieces) {
    ap.display();
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

void createBallAtPosition(float posX, float posY, int[] colour) {
  Particle p = new Particle(posX, posY, 0, 0, width, height, colour);
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

void positionWhiteBall(int posX, int posY) {
  Particle whiteBall = findWhiteBall();
  whiteBall.setPosition(new PVector(posX, posY));
  whiteBall.setVelocity(new PVector(0, 0));
}
