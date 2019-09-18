/*
  All the Glitch FX filters here
 */
class Filters {
  Filters() {
  }
  //SCRAMBLE
  PImage scramble(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    //
    int N = round(random(0, 10));
    for (int i = 0; i < N; i++) {
      int sx = floor(random(width));
      int sy = floor(random(height));
      int sw = floor(random(width));
      int sh = floor(random(height));
      int dx = floor(random(width));
      int dy = floor(random(height));
      int dw = floor(random(width));
      int dh = floor(random(height));
      dest.copy(s_copy, sx, sy, sw, sh, dx, dy, dw, dh);
    }
    return dest;
  }
  //SCANLINES
  PImage scanlines(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    boolean dir = (random(0, 1) >= 0.5); //0 - horizontal, 1 - vertical
    dest.loadPixels();
    for (int x = 0; x < width; x+=(dir)?1:2) {
      for (int y = 0; y < height; y+=(dir)?2:1) {
        dest.pixels[x + y* width] = #000000;
      }
    }
    dest.updatePixels();
    return dest;
  }
  //WARP
  PImage warp(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = src_;
    int maxOffset = floor(random(1, width/2));
    dest.loadPixels();
    for (int x = 0; x < width-maxOffset; x++) {
      for (int y = 0; y < height; y++) {
        int i = x + y*width;
        int offset = floor(maxOffset*noise(x/width*0.1, y/height*0.1));
        dest.pixels[i] = s_copy.pixels[i+offset];
      }
    }
    dest.updatePixels();
    return dest;
  }
  //PIXEL BURN
  PImage pixelBurn(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    color thresholdColor = color(random(255), random(255), random(255));
    dest.loadPixels();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int i = x + y*width;
        float r = (red(s_copy.pixels[i]) > red(thresholdColor))?255:red(s_copy.pixels[i]);
        float g = (green(s_copy.pixels[i]) > green(thresholdColor))?255:green(s_copy.pixels[i]);
        float b = (blue(s_copy.pixels[i]) > blue(thresholdColor))?255:blue(s_copy.pixels[i]);
        dest.pixels[i] = color(r, g, b);
      }
    }
    dest.updatePixels();
    return dest;
  }
  //NOISY
  PImage noisy(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    float noiseStrength = random(-64, 64);
    colorMode(HSB);
    dest.loadPixels();
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        int i = x + y*width;
        color pix = s_copy.pixels[i];
        float b = constrain(brightness(pix) + noiseStrength*noise(x, y), 0, 255);
        dest.pixels[i] = color(hue(pix), saturation(pix), b);
      }
    }
    dest.updatePixels();
    colorMode(RGB);
    return dest;
  }
  //SCANNER
  PImage scanner(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    boolean orientation = (random(1) >= 0.5);
    int rand_x = floor(random(s_copy.width));
    int rand_y = floor(random(s_copy.height));

    if (orientation) {
      dest.copy(s_copy, rand_x, 0, 1, s_copy.height, rand_x, 0, s_copy.width-rand_x, s_copy.height);
    } else {
      dest.copy(s_copy, 0, rand_y, s_copy.width, 1, 0, rand_y, s_copy.width, s_copy.height-rand_y);
    }
    return dest;
  }
  //JPG DEGRADE
  PImage jpgDegrade(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    int scaleBy = int(pow(2, round(random(1, 4)))); //2,4,8,16
    dest.resize(round(s_copy.width/scaleBy), round(s_copy.height/scaleBy));
    dest.resize(round(s_copy.width*scaleBy), round(s_copy.height*scaleBy));
    return dest;
  }

  //HIGH PASS*
  PImage highPass(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    //working in HSB to adjust brightness values
    colorMode(HSB);
    s_copy.loadPixels();
    dest.loadPixels();
    //**just to avoid having to constantly type 's_copy.width' for the 'neighbors' variable in the for loop**
    int w = s_copy.width; 
    for (int x = 1; x < w-1; x++) {
      for (int y = 1; y < s_copy.height-1; y++) {
        int i = x + y*s_copy.width;
        //neighboring pixel indicies
        int [] i_n = {i-w-1, i-w, i-w+1, i-1, 1, i+1, i+w-1, i+w, i+w+1};
        float b = 0;
        for (int j = 0; j < i_n.length; j++) {
          if (j == 4) {
            b += 9*brightness(s_copy.pixels[i_n[j]]);
          } else {
            b -= brightness(s_copy.pixels[i_n[j]]);
          }
        }
        //new brightness value for pixel
        //set the current pixel
        dest.pixels[i] = color(hue(s_copy.pixels[i]), saturation(s_copy.pixels[i]), constrain(b, 0, 255));
      }
    }
    //high pass filter complete
    s_copy.updatePixels();
    dest.updatePixels();
    colorMode(RGB);
    return dest;
  }
  //INVERT SATURATION
  PImage invertSaturation(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = s_copy;
    colorMode(HSB);
    s_copy.loadPixels();
    dest.loadPixels();
    for (int x = 0; x < s_copy.width; x++) {
      for (int y = 0; y < s_copy.height; y++) {
        int i = x + y*s_copy.width;
        int s = floor(saturation(s_copy.pixels[i]));
        int invSat = 255 - s;
        dest.pixels[i] = color(hue(s_copy.pixels[i]), invSat, brightness(s_copy.pixels[i]));
      }
    }
    s_copy.updatePixels();
    dest.updatePixels();
    colorMode(RGB);
    return dest;
  }
}
