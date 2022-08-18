// created 18th August 2022
// Took 1h 43mins (1st project in processing)

PVector ctr;
PVector ctrNow;
PVector ceiling;

final float circleR = 25;
final float angle0 = radians(20);
float ropeL;

float time = 0;
final float simulationTime = 1000;
final float g = 9.81;

void settings(){
  size(640, 640);
}

void setup(){
  ctr = new PVector(width/2,height/2);
  ceiling = new PVector(ctr.x, 0);
  ropeL = width/2 - circleR;
}

void draw(){
  setBackground();
  movePendulum(time);
  time += 0.1;
}

float calculateAngle(float t){
  return angle0 * cos(sqrt(g/ropeL)*t);
}

PVector calculateDisplacement(float t){
  float angle = calculateAngle(t);
  float dx = ropeL * sin(angle);
  float dy = -ropeL * (1 - cos(angle));
  PVector displacement = new PVector(dx, dy);
  return displacement;
}

void movePendulum(float t){
  PVector d = calculateDisplacement(t);
  float angle = calculateAngle(t);
  ctrNow = PVector.add(ctr, d);
  circle(ctrNow.x,ctrNow.y, 2*circleR);
  int angleC = (int)map(abs(angle), 0, angle0, 100,200);
  int timeC = (int)map(t, 0, simulationTime, 100,255);
  fill(angleC);
  line(ctrNow.x - circleR*sin(angle), ctrNow.y - circleR*cos(angle), ceiling.x, ceiling.y);
}

void setBackground(){
  background(255, 120, 255);
}
