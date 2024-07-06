import processing.video.*;

PImage[] animasi;
int animasiX = 750;
int animasiY = 500;
float animasiSkala = 0.6; 
int animasiPenghitungFrame = 0; 
Movie videoLatar;
boolean videoMulai = false;
float videoSpeed = 0.5;

float animasiSpeed = 0.3;
int animasiCounter = 0;

void setup() {
  size(1400, 900);
  smooth();
  frameRate(60);
  
  videoLatar = new Movie(this, "latar.mp4");
  videoLatar.loop();  
  videoLatar.speed(videoSpeed);
  
  int jumlahFile = 0;
  while (loadImage("apeni (" + (jumlahFile + 1) + ").gif") != null) {
    jumlahFile++;
  }
  
  animasi = new PImage[jumlahFile];
  for (int i = 0; i < jumlahFile; i++) {
    animasi[i] = loadImage("apeni (" + (i + 1) + ").gif");
  }
  
  println("Berhasil memuat " + jumlahFile + " gambar");
}

void draw() {
  if (videoLatar.available()) {
    videoLatar.read();
    videoMulai = true;
  }
  
  if (videoMulai) {
    image(videoLatar, 0, 0, width, height);
  }
  
  if (animasi.length > 0) {
    pushMatrix();
    translate(animasiX, animasiY);
    scale(animasiSkala);
    image(animasi[animasiPenghitungFrame], -animasi[animasiPenghitungFrame].width/2, -animasi[animasiPenghitungFrame].height/2); 
    popMatrix();
    
    animasiCounter++;
    if (animasiCounter >= animasiSpeed) {
      animasiCounter = 0;
      animasiPenghitungFrame = (animasiPenghitungFrame + 1) % animasi.length;
    }
  }
}

void mousePressed() {
  animasiX = mouseX;
  animasiY = mouseY;
}

void keyPressed() {
  if (key == '+' || key == '=') {
    videoSpeed += 1;
    videoLatar.speed(videoSpeed);
  } else if (key == '-' || key == '_') {
    videoSpeed = max(1, videoSpeed - 1);
    videoLatar.speed(videoSpeed);
  } else if (key == 'f' || key == 'F') {
    animasiSpeed = max(1, animasiSpeed - 1);
  } else if (key == 's' || key == 'S') {
    animasiSpeed++;
  }
}

void movieEvent(Movie m) {
  m.read();
  if (m.time() >= m.duration() - 0.1) {
    m.jump(0);
  }
}

void stop() {
  videoLatar.stop();
  super.stop();
}
