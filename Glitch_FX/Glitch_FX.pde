/*
  Glitch FX (Processing Version)
  
  By: Justin J
  March 12, 2019
  
  A version of the GlitchFX sketch done completely in (Java) Processing
  Includes filters from the original sketch, plus more in the future.
  **Now allows you to load/save your own images! But only with a fixed size; I hope to make adjustments to that in the future.
*/

PImage srcImg;
GlitchFX gfx;

void setup(){
  size(1000,1000);
  textAlign(CENTER);
  textSize(30);
  //double the display density if supported
  pixelDensity(displayDensity());
  //Load an image
  selectInput("Select an image file","fileSelected");
  noLoop();
}

void fileSelected(File f){
  if (f == null){
    println("Window closed or the user hit cancel");
    exit();
  }
  else{
    println("Loading image at: " + f.getAbsolutePath());
    srcImg = loadImage(f.getAbsolutePath());
    srcImg.resize(width,height);
    //setup Glitch FX object
    gfx = new GlitchFX(srcImg);
    redraw();
  }
}

void draw(){
  if (srcImg == null){
    background(0);
    text("No Image Loaded :(",width/2,height/2);
  }
  else{
    //image(srcImg,0,0);
    image(gfx.getOutputImage(),0,0);
  }
}

void keyPressed(){
  if (key == 'g' || key == 'G'){
    //apply new effects
    gfx.mosh();
    redraw();
  }
  else if (key == 's' || key == 'S'){
    //save image
    selectOutput("","parseFile");
  }
}
//function to setup output upon saving.
void parseFile(File f){
  if (f == null){
    println("Window closed or operation cancelled.");
  }
  else{
    println(f.getAbsolutePath());
    save(f.getAbsolutePath()+".jpg");
  }
  
}
