class Particle{
  float radius = 50;
  PVector position;
  String name;
  
  Particle(float x, float y){
    //super(x,y);
    position = new PVector(x,y);
    name = new String("Particle" + particles.size());
  }
  
  void display(){
    fill(0);
    //stroke(0);
    //strokeWeight(2);
    circle(position.x,position.y, radius);
  }
}
