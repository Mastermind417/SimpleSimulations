void drawAppropriatePicture(){
  PImage pImg = photoUp; 
  if(picCounter == 1){
    pImg = photoUp;
  }
  else if(picCounter == 2){
    pImg = photoDown; 
  }
  else if(picCounter == 3){
    pImg = photoLeft;
  }
  else if(picCounter == 4){
    pImg = photoRight;
  }
  else return;
  
  float scaleDownFactor = 0.75; 
  int imgW = (int)(scaleDownFactor * pImg.width);
  int imgH = (int)(scaleDownFactor * pImg.height);
  
  image(pImg,w-imgW,h-imgH, imgW, imgH);
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
