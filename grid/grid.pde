import java.util.Date;
static int image_size = 512;
static int num_rows = 6;

void setup() {
  // image_size * num_rows (doesnt accept variables)
  size(3072,3072);

  // Using just the path of this sketch to demonstrate,
  // but you can list any directory you like.
  String path = sketchPath() + "/images";

  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);
  String[] newfilenames = listFileNames(path);
  printArray(filenames);


  File[] files = listFiles(path);
  
  // remove .DS_Store from the list of images
  for (int i=0, j=0; i < files.length; i++){
        if(!filenames[i].contains(".DS_Store")){
        newfilenames[j++] = filenames[i];
      }
  }
  int row = -1;
  for (int i = 0; i < files.length; i++) {
    print(filenames[i]);

    PImage pic = loadImage(sketchPath() + "/images/" + newfilenames[i], "unknown");
  
    
    int col = image_size*(i%num_rows);
    if (col == 0)
    {
      row++;
    }
    image(pic,col,row*image_size);
  }
    
 }

void draw() {
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

void keyPressed(){
  
  // save image
  if (key == 's' || key == 'S') {
    String fname = "Zoom Call";
    save(fname + ".png");
    print("\nImage saved: " + fname + ".png");
  }
}
