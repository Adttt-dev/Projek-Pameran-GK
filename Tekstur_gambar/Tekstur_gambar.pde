int maxTime = 1000;
int strokesPerFrame = 80;

String[] imgNames = {
  "https://www.presidenri.go.id/assets/uploads/2020/02/presidenri.go.id-05022020111245-5e3a40bd7cdcb1.35250820-384x512.jpg",
  "https://4.bp.blogspot.com/-zVAlieR3DVM/T9BX20gl9bI/AAAAAAAAAD4/xraLwSMi7l0/s640/Profil-Prabowo-Subianto2.jpg"
};

PImage img;
int imgIndex = -1;
float brightnessShift;

void setup() {
  size(1112, 834);
  colorMode(HSB, 255);
  nextImage();
}

void draw() {
  translate(width / 2, height / 2);
  scale(1.4);
  for (int i = 0; i < strokesPerFrame; i++) {
    int index = int(random(img.width * img.height));
    
    color pixelColor = img.pixels[index];
    pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 255);

    int x = index % img.width;
    int y = index / img.width;
    
    pushMatrix();
    translate(x - img.width / 2, y - img.height / 2);
    
    if (frameCount % 5 == 0) {
      paintDot(pixelColor, random(2, 6) * map(frameCount, 0, maxTime, 1, 0.1));
    } else {
      paintStroke(map(frameCount, 0, maxTime, 1, 8), pixelColor, (int)random(1, 2) * map(frameCount, 0, maxTime, 1, 0.9));
    }

    popMatrix();
  }
  
  if (frameCount > maxTime) {
    noLoop();
  }
}

void mousePressed() {
  nextImage();
}

void nextImage() {
  background(255);
  loop();
  frameCount = 0;
  
  brightnessShift = random(255);
  
  imgIndex++;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }
  
  img = loadImage(imgNames[imgIndex]);
  img.loadPixels();
}

void paintStroke(float strokeLength, color strokeColor, float strokeThickness) {
  float b = brightness(strokeColor);
  
  float bShift = b + brightnessShift;
  if (bShift > 255) {
    bShift -= 255;
  }
  
  pushMatrix();
  rotate(radians(map(b, 0, 255, -180, 180)));
  
  stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 0, 100), 50);
  line(-strokeLength, 1, strokeLength, 1);
  
  stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 0, 255));
  strokeWeight(strokeThickness);
  line(-strokeLength, 0, strokeLength, 0);
  
  stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 150, 255), 20);
  line(-strokeLength, 2, strokeLength, 2);
  
  popMatrix();
}

void paintDot(color strokeColor, float strokeThickness) {
  float b = brightness(strokeColor);
  
  float bShift = b + brightnessShift;
  if (bShift > 255) {
    bShift -= 255;
  }
  
  pushMatrix();
  rotate(radians(random(-180, 180)));
  
  stroke(map(bShift, 0, 255, 0, 255), 150, map(b, 0, 255, 0, 255));
  strokeWeight(strokeThickness);
  line(0, 0, 5, 0);
  
  popMatrix();
}
