void drawAppropriatePicture(){
  if(picCounter == 1){
    image(photoUp,w-photoUp.width,h-photoUp.width);  
  }
  else if(picCounter == 2){
    image(photoDown,w-photoDown.width,h-photoDown.width); 
  }
  else if(picCounter == 3){
    image(photoLeft,w-photoLeft.width,h-photoLeft.width);
  }
  else if(picCounter == 4){
    image(photoRight,w-photoRight.width,h-photoRight.width);
  }
  makeImgTransparent();
}
void makeImgTransparent(){
  tint(255, 127);
}

void drawBottomSquare(){
  int sL = 300;
  stroke(100);
  //fill(200);
  square(w - sL/2, h - sL/2, sL); // sL/2 is to centre the box better
}

void showParticleCount(String particleCount){
  textSize(100);
  
  //String countToShow = str(particles.size());
  if (particleCount == "0") particleCount = "";
  
  stroke(0);
  fill(256, 128, 128);
  text("Particle Count: " + particleCount, 0, h);   
}

void showTime(int time){
  textSize(50);
  
  String timeToShow = str(time);
  
  stroke(0);
  fill(128, 128, 256);
  text("Time: " + timeToShow, 0, 40); 
  
}

void drawVelLine(){
  if(mousePressed){
    strokeWeight(2);
    fill(128,128,128);
    line(oldMouse.x, oldMouse.y, newMouse.x, newMouse.y);
  }
}
