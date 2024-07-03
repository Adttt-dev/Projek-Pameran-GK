import processing.video.*;

PImage[] animasi;
int animasiX = 750;  // Posisi X awal
int animasiY = 500;  // Posisi Y awal
float animasiSkala = 0.6; 
int animasiPenghitungFrame = 0; 
Movie videoLatar;
boolean videoMulai = false;
float videoSpeed = 0.5;  // Kecepatan default video

void setup() {
  size(1400, 900);
  smooth();
  frameRate(60);  // Set frame rate to 60 FPS
  
  videoLatar = new Movie(this, "latar.mp4");
  videoLatar.loop();  
  videoLatar.speed(videoSpeed);  // Set kecepatan awal video
  
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
    
    if (frameCount % 2 == 0) {
      animasiPenghitungFrame = (animasiPenghitungFrame + 1) % animasi.length;
    }
  }
  
  fill(255);
  text("Klik di mana saja untuk memindahkan karakter", 10, 20);
  text("Posisi: (" + animasiX + ", " + animasiY + ")", 10, 40);
  text("FPS: " + frameRate, 10, 60);
  text("Video Speed: " + videoSpeed + "x", 10, 80);  // Tampilkan kecepatan video
  text("Tekan + untuk mempercepat, - untuk memperlambat video", 10, 100);
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
    videoSpeed = max(1, videoSpeed - 1);  // Pastikan kecepatan tidak kurang dari 1
    videoLatar.speed(videoSpeed);
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
