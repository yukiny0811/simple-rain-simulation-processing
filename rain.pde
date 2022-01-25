
// Copyright 2022 Yuki Kuwashima
// All images are licensed under the Pixabay License

float[][] water = new float[400][400];
float rainRate = 0.0006;
PImage img;

void setup() {
  size(400, 400);
  background(40);
  for (int x = 0; x < 400; x++) {
    for (int y = 0; y < 400; y++) {
      water[x][y] = 0;
    }
  }
  frameRate(15);
  img = loadImage("image1.jpg");
  img.filter(BLUR, 2);
  colorMode(HSB);
}

void draw() {
  image(img, 0, 0);
  
  if (keyPressed == false) {
    rainRate = 0.0006;
  }
  
  for (int x = 1; x < 399; x++) {
    for (int y = 0; y < 399; y++) {
      float r = random(1.0);
      if (r < rainRate) {
        water[x][y] += random(10, 20);
      }
    }
  }
  
  for (int i = 0; i < 100000; i++) {
    int x = floor(random(1.1, 395.1));
    int y = floor(random(1.1, 395.1));
    if (water[x][y+1] >= 30) {
      water[x][y+1] += water[x][y];
      water[x][y] = 0;
    }
    if (water[x+1][y+1] >= 30) {
      water[x+1][y+1] += water[x][y];
      water[x][y] = 0;
    }
    if (water[x-1][y+1] >= 30) {
      water[x-1][y+1] += water[x][y];
      water[x][y] = 0;
    }
    if (water[x+1][y] >= 30 && water[x][y] >= 100) {
      float average = (water[x][y] + water[x+1][y]) / 2.0;
      water[x][y] = average;
      water[x+1][y] = average;
    }
    if (water[x-1][y] >= 30 && water[x][y] >= 100) {
      float average = (water[x][y] + water[x-1][y]) / 2.0;
      water[x][y] = average;
      water[x-1][y] = average;
    }
  }
  for (int i = 1; i < 4; i++) {
    for (int x = 1; x < 399; x++) {
      for (int y = 1; y < 399; y++) {
        if (water[x][y] >= i * 250.0) {
          for (int k = -i; k < i; k++) {
            if (k == 0) continue;
            if (x+k < 0 || x+k > 399) continue;
            water[x][y] += water[x+k][y];  
            water[x+k][y] = 0;
          }
          if (water[x-1][y+1] >= 30 && water[x-1][y+1] >= water[x][y+1] && water[x-1][y+1] >= water[x+1][y+1]) {
            water[x-1][y+1] += water[x][y];
            water[x][y] = 0;
          } else if (water[x+1][y+1] >= 30 && water[x+1][y+1] >= water[x][y+1] && water[x+1][y+1] >= water[x-1][y+1]) {
            water[x+1][y+1] += water[x][y];
            water[x][y] = 0;
          } else {
            water[x][y+1] += water[x][y];
            water[x][y] = 0;
          } 
        }
      }
    }
  }
  
  for (int x = 0; x < 400; x++) {
    for (int y = 0; y < 400; y++) {
      float tempWater = water[x][y];
      if (tempWater > 255) {
        tempWater = 255;
      }
      float waterOpacity = tempWater / 255.0;
      float pixelBrightness = brightness(get(x, y));
      float viewBrightness = pixelBrightness + (getmaxBrightness(pixelBrightness) - pixelBrightness) * waterOpacity;
      set(x, y, color(hue(get(x, y)), saturation(get(x, y)), viewBrightness));
    }
  }
  
  fill(200);
  text("Press SPACE to increase rain", 10, 10);
  text("Press 1~9 to change image", 10, 20);
}

float getmaxBrightness(float b) {
  return -0.66 * b + 230;
}

void keyPressed() {
  if ( key == ' ' ) {
    rainRate = 0.01;
  }
  if ( key == '1') {
    img = loadImage("image1.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '2') {
    img = loadImage("image2.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '3') {
    img = loadImage("image3.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '4') {
    img = loadImage("image4.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '5') {
    img = loadImage("image5.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '6') {
    img = loadImage("image6.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '7') {
    img = loadImage("image7.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '8') {
    img = loadImage("image8.jpg");
    img.filter(BLUR, 2);
  }
  if ( key == '9') {
    img = loadImage("image9.jpg");
    img.filter(BLUR, 2);
  }
}  