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
  square(w - sL/2, h - sL/2, sL); // sL/2 is to centre the box better
  stroke(100);
  //fill(200);
}

void showParticleCount(){
  textSize(100);
  
  String countToShow = str(particles.size());
  if (countToShow == "0") countToShow = "";
  
  text("Particle Count: " + countToShow, 0, h); 
  fill(128, 128, 128);
}

void showTime(int time){
  textSize(50);
  
  String timeToShow = str(time);
  
  text("Time: " + timeToShow, 0, 40); 
  fill(128, 128, 128);
}
