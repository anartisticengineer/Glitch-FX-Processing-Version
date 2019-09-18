//OpenCV

class FiltersCV extends Filters {
  OpenCV opencv;
  FiltersCV(PApplet mainApplet) {
    opencv = new OpenCV(mainApplet, 1000, 1000);
  }

  PImage edgeDetector(PImage src_) {
    PImage s_copy = src_.copy();
    PImage dest = src_;
    opencv.loadImage(s_copy);
    int whichEdgeDetect = floor(random(0, 2));
    switch(whichEdgeDetect) {
    case 0:
      opencv.findScharrEdges(OpenCV.HORIZONTAL);
      break;
    case 1:
      opencv.findSobelEdges(1, 1);
      break;
    }
    dest = opencv.getSnapshot();
    return dest;
  }
}
