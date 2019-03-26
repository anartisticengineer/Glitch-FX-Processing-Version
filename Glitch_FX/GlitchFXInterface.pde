class GlitchFX{
  PImage src,src_original;
  int w,h;
  Filters glitchFilter;
  
  GlitchFX(PImage src_){
    src = src_.copy();
    src_original = src_.copy();
    w = src.width;
    h = src.height;
    glitchFilter = new Filters();
  }
  
  void overwriteSource(PImage newSrc_){
    src = newSrc_;
  }
  
  void mosh(){
    //reset before glitching again
    overwriteSource(src_original);
    
    int N = int(random(2,7)); //number of effects
    println("\n" + N + " effects applied:");
    for (int i = 0; i < N; i++){
      //which effect?
      int fx = int(floor(random(0,8)));
      PImage next_step = src.copy();
      switch(fx){
        case 0:
        overwriteSource(glitchFilter.scramble(next_step));
        print(" SCRAMBLE");
        break;
        case 1:
        overwriteSource(glitchFilter.scanlines(next_step));
        print(" SCANLINES");
        break;
        case 2:
        overwriteSource(glitchFilter.warp(next_step));
        print(" WARP");
        break;
        case 3:
        overwriteSource(glitchFilter.pixelBurn(next_step));
        print(" PIXEL BURN");
        break;
        case 4:
        overwriteSource(glitchFilter.noisy(next_step));
        print(" NOISY");
        break;
        case 5:
        overwriteSource(glitchFilter.scanner(next_step));
        print(" SCANNER");
        break;
        case 6:
        overwriteSource(glitchFilter.jpgDegrade(next_step));
        print(" JPG DEGRADE");
        break;
        case 7:
        overwriteSource(glitchFilter.highPass(next_step));
        print(" HIGH PASS");
      }
      //end of switch statement
    }
    //end of glitching
  }
  //***MASTER OUTPUT***
  PImage getOutputImage(){
    return src;
  }
}
