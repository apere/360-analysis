 import gab.opencv.*;

OpenCV opencv;
PImage[] frames;
PImage output;
int ind = 0;
int offset = 10;
boolean firstRun = true;
String filename = "coaster";
int rando = int(random(0,999));

//PImage colorDiff;
void setup() {
  String path = sketchPath("")+"img/" + filename + "/"; 
  File[] files = listFiles(path);
  frames =new PImage[files.length];
  size(1280,720);

  print(path+"\n"); 
  print(files.length+"\n"); //how many files are here
  println();
  
  //opencv = new OpenCV(this, before);    
  //opencv.diff(after);
  //grayDiff = opencv.getSnapshot(); 
  
  for(int i=0;i<files.length;i++) {
    //println(files[i]);
    opencv = new OpenCV(this, loadImage(files[i].getAbsolutePath()) );

    frames[i]= opencv.getOutput();
    //frames[i] = loadImage(files[i].getAbsolutePath());
  }
  
  println("*******opencv done*********");
}

void draw() {
  if(ind+offset < frames.length) {
    opencv = new OpenCV(this, frames[ind]);  
    //opencv.threshold(2);
    opencv.diff(frames[ind]);
    output = opencv.getSnapshot();
    
    for(int i = 1; i < offset; i++) {
       opencv = new OpenCV(this, output); 
       opencv.diff(frames[ind+i]);
       //opencv.dilate();
       output = opencv.getSnapshot();
    }
    
    pushMatrix();
   // scale(0.5);
    //image(frames[ind], 0, 0);
    //image(frames[ind + offset], frames[ind].width, 0);
//  image(colorDiff, 0, before.height);
   // image(output, frames[ind].width, frames[ind].height);
    image(output, 0,0);
    popMatrix();
    
  
     
  }
  
  if(firstRun) {
    saveFrame(filename + "_off" + offset + "_rand" + rando + "_######.png");
  }
  
  ind++;
  if(ind+offset > frames.length) {
     ind = 0; 
     println("loop");
     firstRun = false;
  }
  delay(10);
}