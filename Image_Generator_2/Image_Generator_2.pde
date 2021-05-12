
String imgURL = "https://fakeface.rest/thumb/view";

// returns a zoom caller

PGraphics pg;

//int numFaces = int(random(10))+1;
int numFaces = 1;
PImage[] images = new PImage[numFaces];
                  
boolean gen = true;
int frame = 0;
int numFrames = 36;

// setup
void setup() {
  size(512, 512);

  //bgImage = loadImage(bgURL, "unknown");
  print("Press G to generate and save image");
}


// crop images
PImage blur_crop(PImage img, float radius){
 // radius should be a number from 0-0.5 (> 0.5 results in clipping)
  // rgb pixels
  float r;
  float g;
  float b;
  
  // Loop through every pixel in the image
  // !!!!!for some reason it is not working when x and y index from 0?
  for (int i = 1; i < img.width; i++) {
    for (int j= 0; j < img.height; j++) {  // Skip left and right edges
     //print(j); //<>//
      // get pixel value
      color c = img.get(i,j);
      r = red(c);
      g = green(c);
      b = blue(c);
      
      // distance formula - distance of pixel from midpoint
      float iy = img.height*0.5-i;
      float jx = int(img.width*0.5-j);
      float a = sqrt(pow(jx,2)+pow(iy,2));
     
      //make transparent depending on proximity to midpoint
      color nc = color(r,g,b,map(map(a, 0, img.height*radius, 0, 255), 0, 255, 255, 0)-75);
      //replace pixel
      img.set(i,j,nc);
    }
  }
  //for(int j = 0; j<img.height;j++){
  //  img.set(j,0,color(0,0,0,0));
  //}
  return img.get(1,1,width,height);
}


void draw() {
  background(255);
  if (gen){
    for(int i=0; i<numFaces; i++)
  {
    images[i] = loadImage(imgURL, "unknown");
  } 
  
  //resize an image
  for(int i = 0; i<numFaces; i++)
  {
    

    int imageWidth = width;
    int imageHeight = height;
    int imageX = 75;
    int imageY = 50;
    // random positions
    //int imageWidth = int(random(width)*3)+50;
    //int imageHeight = int(random(height))*3+50;
    //int imageX = int(random(width/2,width/2));
    //int imageY = int(random(height/2-300,height/2+50));
    
    pushMatrix();
    popMatrix();
    
    // randomly rotate
    //rotate(random(-0.5,0.5)*PI/3);
    
    images[i] = blur_crop(images[i], 0.4);
    images[i].resize(imageWidth,imageHeight);
    noodle(imageX, imageY, imageWidth, imageHeight);
    image(images[i], imageX, imageY);
    
    for(int j=0;j<int(random(6));j++)
    {
      filter(ERODE);
      filter(BLUR,int(random(2)));
    }
    
    filter(ERODE);
    filter(BLUR, 6);
    
    frame++;
    save("/Users/ottobenson/Documents/GitHub/zoom-call/grid/images/" + frame + ".png");
    print("\nImage saved: /Users/ottobenson/Documents/GitHub/zoom-call/grid " + frame + ".png");   
  }
  }
  
  if(frame > numFrames+1){
    gen = false;
  }
  
}

void keyPressed(){
  // generate and save images
  if (key == 'g' || key == 'G') {
    gen = true;
  }
}

color extractColorFromImage(final PImage img) {
  //img.colorMode(RGB);
  img.loadPixels();
  color r = 0, g = 0, b = 0, a = 0;
 
  for (final color c : img.pixels) {
    r += red(c);
    g += green(c);
    b += blue(c);
  }
 
  r /= img.pixels.length;
  g /= img.pixels.length;
  b /= img.pixels.length;
  //a /= img.pixels.length;
  print(color(r, g, b, a));
  return color(r, g, b, 255);
  
}

  


void noodle(int imageX, int imageY, int imageWidth, int imageHeight)
{
  noStroke();
  // pick color for tint and fillz
  color c = color(random(255),random(255),random(255));
  color ca = color(c, 255);
  fill(ca);
  tint(c);
  int d = 0; //distance between ellipses
  //head
  float[] head = {imageX+imageWidth*0.35, imageY+imageHeight*0.35, imageWidth/2, imageHeight/2};
  ellipse(head[0], head[1], head[2],head[3]);
  ellipse(head[0], head[1]-50, head[2],head[3]);
  ellipse(head[0], head[1]+50, head[2],head[3]);
  rect(head[0]-(imageWidth/4)+d, head[1], (imageWidth/2)-d,imageHeight);
  filter(BLUR, 2);
  //c = color(random(255),random(255),random(255));
  //fill(c);
  //int thick = 100;
  //pushMatrix();
  //rect(head[0]-(imageWidth/4)+d, head[1], -head[2], thick);
  //rotate(random(-0.5,0.5)*PI/3);
  //popMatrix();
  
  

  //for(int i=0;i<8;i++)
  //{
  //  ellipse(head[0]/2+d*i*random(-1,1),head[1]/2+d*i*random(-1,1), head[2]*2+d*i*random(-1,1),head[3]*2+d*i*random(-1,1));
  //}
  //c = color(random(255),random(255),random(255));
  //for(int i=0;i<8;i++)
  //{
  //  ellipse(head[0]+d*i*random(-1,1),head[1]+d*i*random(-1,1), head[2]+d*i*random(-1,1),head[3]+d*i*random(-1,1));
  //}
  //body

  
  //legs
  
 /*
  for(int i = 0; i<2;i++){
    
    
    switch(int(random(5)))
    //switch(1)
    {
      case 0:
        // random polygon
        beginShape();
        for(int j=0;j<int(random(18)+2);j++){
          vertex(random(width),random(height));
        }
        endShape();
        break; 
      case 1:
        // random rectangle
        rect(random(width/2),random(height/2),random(width),random(height));
        break;
      case 2:
        fill(random(255),random(255),random(255));
      break;
      case 3:
        for(int j=0;j<int(random(18)+2);j++){
          rect(random(width/2),random(height/2),random(500,1000),random(40,100));
        }
      break;
      case 4:
        circle(random(width/2),random(height/2),random(width));
      break;
      default:
      break;
    }
    
  }
  */
}
// 
