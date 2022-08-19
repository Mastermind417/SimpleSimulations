class Platform{
  int pHeight;
  int pWidth;
  float pSpeed;
  
  int sceneWidth;
  int sceneHeight;
  
  // position of platform
  int[] position = new int[2];
   
  
  Platform(int w, int speed, int sw, int sh){
    pWidth = w;
    pHeight = 50; // keep constant for now
    pSpeed = speed;
    
    sceneWidth = sw;
    sceneHeight = sh;
    
    // initialize platform position at edge of scene
    position[0] = sceneWidth;
    position[1] = (int)random(sceneHeight);
    
    display();
  }
  
  
  void move(){
    position[0] -= pSpeed; 
  }
  
  void display(){
    rect(position[0],position[1], pWidth, pHeight);
  }
  
}
