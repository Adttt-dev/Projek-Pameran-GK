import ddf.minim.*;

Minim minim;
AudioPlayer playerSupermi;
AudioPlayer playerGw;
AudioPlayer playerKendaraan;

PImage img;
PImage[] supermi = new PImage[39];
PImage[] gw = new PImage[37];
PImage[] kendaraan = new PImage[24]; 
int supermiX = 1200; 
int gwX = 400; 
int kendaraanX = 800; 
float supermiScale = 0.5; 
float gwScale = 0.9; 
float kendaraanScale = 1; 
float supermiSpeed = 1; 
float gwSpeed = 1; 
float kendaraanSpeed = 1; 
float supermiFrameCounter = 0; 
float gwFrameCounter = 0; 
float kendaraanFrameCounter = 0; 

void setup() {
  size(1300, 800);
  smooth();
  img = loadImage("background.jpg");
  
  minim = new Minim(this);
  playerSupermi = minim.loadFile("soundkota.mp3");
  playerGw = minim.loadFile("burung.mp3");
  playerKendaraan = minim.loadFile("soundkota.mp3");
  
  playerSupermi.loop();
  playerGw.loop();
  playerKendaraan.loop();

  for (int i = 0; i < 39; i++) {
    supermi[i] = loadImage("supermi (" + (i + 1) + ").gif");
  }
  
  for (int i = 0; i < 37; i++) {
    gw[i] = loadImage("gw (" + (i + 1) + ").gif");
  }
  
  for (int i = 0; i < 24; i++) {
    kendaraan[i] = loadImage("mobil (" + (i + 1) + ").gif");
  }
}

void draw() {
  image(img, 0, 0, width, height);
  
  pushMatrix();
  scale(supermiScale);
  image(supermi[(int)supermiFrameCounter % 39], supermiX / supermiScale, 200 / supermiScale); 
  popMatrix();
  
  pushMatrix();
  scale(gwScale);
  image(gw[(int)gwFrameCounter % 37], gwX / gwScale, 400 / gwScale); 
  popMatrix();
  
  pushMatrix();
  scale(kendaraanScale);
  image(kendaraan[(int)kendaraanFrameCounter % 24], kendaraanX / kendaraanScale, 450 / kendaraanScale); 
  popMatrix();
  
  supermiFrameCounter += supermiSpeed;
  gwFrameCounter += gwSpeed;
  kendaraanFrameCounter += kendaraanSpeed;
  
  supermiX -= 20;
  if (supermiX < -200) {
    supermiX = width;
  }
  
  gwX += 20;
  if (gwX > width) {
    gwX = -200;
  }
  
  kendaraanX -= 25;
  if (kendaraanX < -1300) {
    kendaraanX = width;
  }
}

void stop() {
  playerSupermi.close();
  playerGw.close();
  playerKendaraan.close();
  minim.stop();
  super.stop();
}
