void uploads(){
  pushMatrix();
  translate(930, 0);
  //the pic
  stroke(0,0,90);
  fill(0,0,100);
  rect(10, 10, 40, 45);
  noStroke();
  fill(0,0,90);
  rect(15, 15, 29,29);
  
  //the note
  stroke(0,0,90);
  fill(0,0,100);
  rect(-19, 10, 5, 40);
  ellipse(-25, 44, 25, 25);
  noStroke();
  rect(-18, 10, 3, 39);

  if(dist(mouseX, mouseY, 960, 32) <= 43){
    fill(0, 0, 50);
    rect(10,10,40,45);
    fill(0,0,100);
    rect(15,15,29,29);
    cursor(HAND);
  }else{cursor(CROSS);}
  if(dist(mouseX, mouseY, 927, 32) <= 25){
    stroke(0,0,90);
    fill(0,0,50);
    rect(-19, 10, 5, 40);
    ellipse(-25, 44, 25, 25);
    noStroke();
    rect(-18, 10, 3, 39);
    cursor(HAND);
  }else{cursor(CROSS);}
  popMatrix();
}

void drawPic(){
  noFill();
  for ( int i = pic.width-1; i > 0; i--) {
    for ( int j = pic.height-1; j > 0; j--) {
      rectX[k] = (width/2)-(pic.width/2)+i;
      rectY[k] = ((height/2)-(pic.height/2)+j)+grav[i*j];
      if (rectY[k] >= height-3) {        // -. <--keep the sand on the floor.
        rectY[k]= height-random(1, 2);  //  |
        rectX[k] += horizon[k]*0.9;    //  |
      }                                // _|
      if (rectY[k] > height-11 && rectY[k] < height-10) {
        sound[k] = true;
      }
      else {
        sound[k] = false;
      }
      c[k] = pic.get(i, j);
      fill(c[k]);
      rect(rectX[k], rectY[k], 1, 1);
      k++;
      if (k >= i*j) {
        k = i*j;
      }
      if (sound[k] == true) {
        rectHue = hue(c[k]);
        rectSat = saturation(c[k]);
        rectBri = brightness(c[k]);
        pitch = map(rectHue+rectSat, 0, 198, 0, 6000);
        amp = map(rectBri, 0, 99, 0.2, 0.3);
      }
    }
  }
}

void numbers(){
  color cc = get(mouseX, mouseY);
  fill(cc);
  stroke(0,0,100);
  rect(mouseX, mouseY, 15,15);
  pushMatrix();
  translate(-50, 0);
  fill(0,0,70);
  textSize(11);
  text("H: ", 60, 40);
  text(hue(cc), 69, 40);
  text("S: ", 60, 55);
  text(saturation(cc), 69, 55);
  text("B: ", 60, 70);
  text(brightness(cc), 69, 70);
  text("SOUND FREQUENCY: ", 60, 25);
  text(map(hue(cc)+brightness(cc), 0, 198, 0, 6000), 170, 25);
  popMatrix();
}
