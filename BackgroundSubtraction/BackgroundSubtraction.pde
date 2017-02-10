import gab.opencv.*;
import processing.video.*;

Movie video;
OpenCV opencv;
boolean firstRun = true;
int ind = 0;
int offset = 1;
int op = 255;
void setup() {
  size(1280, 720);
  video = new Movie(this, "bjork.avi");
  opencv = new OpenCV(this, 1280, 720);
 
  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  background(0);

  video.loop();
  video.play();
}

void draw() {
  //image(video, 0, 0);  
  opencv.loadImage(video);
  
  opencv.updateBackground();
  
  opencv.dilate();
  opencv.erode();
  opencv.erode();

  noFill();
  stroke(255, 0, 0, op);
  strokeWeight(1);
  for (Contour contour : opencv.findContours()) {
    //stroke(0, 255, 0);
   // contour.draw();
    
    stroke(255, 0, 0, op);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
    
  }
  //op = op - 5;
  
  if(frameCount %10 == 0) {
    background(0);
  }
  
  if(firstRun) {
    saveFrame("coaster-######.png");
  }
  
  ind++;
  if(ind+offset > 300) {
     ind = 0; 
     println("loop");
     firstRun = false;
  }
  delay(10);
  
}

void movieEvent(Movie m) {
  m.read();
}