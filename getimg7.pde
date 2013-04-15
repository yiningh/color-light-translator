import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;

Minim minim;
AudioOutput out;
AudioPlayer music;

PImage pic;
PFont font;
String selected;
int h, s, b;
float[] grav, rectX, rectY, horizon;
int r, k, rate;
boolean drop, visual, audio;
boolean[] sound;
color[] c;
float rectHue, rectSat, rectBri, pitch, amp;
SineWave mySine;
MyNote newNote;

void setup() {
  font = loadFont("14.vlw");
  textFont(font);
  colorMode(HSB, 99);
  size(1000, 600, P3D);
  selected = "img.jpg";
  pic = loadImage(selected); 
  grav = new float[600000];
  horizon = new float[600000];
  sound = new boolean[600000];
  c = new color[600000];
  for ( int i = 0; i < 600000; i++) {
    grav[i] = 0;
    horizon[i] = random(-50, 50);
  }
  r = 0;
  k = 0;
  drop = false;
  rectX = new float[600000];
  rectY = new float[600000];  
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);
  sound[k] = false;
  rate = 24;
  visual = true;
  audio = false;
}

void draw() {
  frameRate(rate);
  pitch = 0;
  noStroke();
  fill(0, 0, 95, 40);
  rect(0, 0, width, height);
  uploads();
  if(visual){
    drawPic();
    if (pitch > 0) {
      newNote = new MyNote(pitch, amp);
    }
    for (int i = 0; i < pic.width*pic.height; i++) {
      grav[i] *= 1+random(0.2, 0.5);
    }
    if (drop) {
      for (int i = 0; i < 100; i++) {
        r++;
        if (r >= pic.width*pic.height-1) {
          r = pic.width*pic.height-1;
        }
        grav[r] = 1;
      }
    }
  }
  if(audio){
    music.play();
    
  }
  numbers();
  println(rate);
}

void fileSelect(File selection){
  if(selection == null){
    println("No seletion!");
  }else{
    println("Seleted " + selection.getAbsolutePath());
  }
}

void mouseReleased(){
  if(dist(mouseX, mouseY, 960, 32) <= 43){
    selected = selectInput("Select an image");
    pic = loadImage(selected);
    for ( int i = 0; i < pic.width*pic.height; i++) {
      grav[i] = 0;
      r = 0;
    }
    visual = true;
    audio = false;
  }
  if(dist(mouseX, mouseY, 927, 32) <= 25){
    selected = selectInput("Select a music file");
    pic = loadImage("250.jpg");
    for ( int i = 0; i < pic.width*pic.height; i++) {
      grav[i] = 0;
      r = 0;
    }
    music = minim.loadFile(selected);
    audio = true;
    visual = false;
  }
}

void keyReleased() {
  if (keyCode == DOWN) {
    drop = true;
  }
  if (keyCode == UP) {
    drop = false;
  }
  if (keyCode == LEFT) {
    rate -= 3;
    if (rate <= 3) {
      rate = 3;
    }
  }
  if (keyCode == RIGHT) {
    rate += 3;
    if (rate >= 60) {
      rate = 60;
    }
  }
}

void stop() {
  music.stop();
  out.close();
  minim.stop();
  super.stop();
}

