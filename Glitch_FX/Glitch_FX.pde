import gab.opencv.*;

/*
  Glitch FX (Processing Version)
 
 By: Justin J
 March 12, 2019
 
 A version of the GlitchFX sketch done completely in (Java) Processing
 Includes filters from the original sketch, plus more in the future.
 **Now allows you to load/save your own images! But only with a fixed size; I hope to make adjustments to that in the future.
 ***OpenCV filter, resizeable window!
 */

PImage srcImg;
GlitchFX gfx;

void setup() {
  size(250, 250);
  surface.setResizable(true);
  //fullScreen();
  textAlign(CENTER);
  textSize(30);
  //double the display density if supported
  pixelDensity(displayDensity());
  //Load an image
  selectInput("Select an image file", "fileSelected");
  noLoop();
}

void fileSelected(File f) {
  if (f == null) {
    println("Window closed or the user hit cancel");
    exit();
  } else {
    println("Loading image at: " + f.getAbsolutePath());
    srcImg = loadImage(f.getAbsolutePath());
    //srcImg.resize(width, height);
    surface.setSize(int(srcImg.width/4),int(srcImg.height/4));
    surface.setResizable(false);
    srcImg.resize(width,height);
    //setup Glitch FX object
    gfx = new GlitchFX(this, srcImg);
    redraw();
  }
}

void draw() {
  if (srcImg == null) {
    background(0);
    textSize(10);
    text("No Image Loaded :(", width/2, height/2);
  } else {
    //image(srcImg,0,0);
    image(gfx.getOutputImage(), 0, 0);
  }
}

void keyPressed() {
  if (key == 'g' || key == 'G') {
    //apply new effects
    gfx.mosh();
    redraw();
  } else if (key == 'j' || key == 'J') {
    //save image as JPG
    selectOutput("Save as JPG", "parseFileJPG");
  } else if (key == 'p' || key == 'P') {
    //save image as PNG 
    selectOutput("Save as PNG", "parseFilePNG");
  } else if (key == 'x' || key == 'X') {
    exit();
  }
}
//function to setup output upon saving.
void parseFileJPG(File f) {
  if (f == null) {
    println("Window closed or operation cancelled.");
  } else {
    println(f.getAbsolutePath());
    save(f.getAbsolutePath()+".jpg");
  }
}

//function to setup output upon saving as PNG.
void parseFilePNG(File f) {
  if (f == null) {
    println("Window closed or operation cancelled.");
  } else {
    println(f.getAbsolutePath());
    save(f.getAbsolutePath()+".png");
  }
}
