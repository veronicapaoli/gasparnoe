/*

 Gaspar Noé
 Veronica Paoli (698)
 28/05/2021
 
 Elementi di informatica per il Design
 Professor Davide Riboli
 AA 2019/2020
 Comunicazione e Design per l'Editoria
 ISIA U
 
 CREDITS
 tfguy44
 forum.processing.org | 2019
 
 */
 
// richiamare l'utilizzo immagine
PImage img;
// percorso immagine all'interno della cartella dello sketch
String imgFileName = "love";
String fileType = "PNG";

void setup() {
  size(1846, 774);
  img=loadImage(imgFileName+"."+fileType);
  image(img, 0, 0);
}

void draw() {
  int i;
  int j;
  color c;
  loadPixels();
  for (int w=0; w<500; w++) {
    i = int(random(pixels.length));
    j = int(random(i, pixels.length));
    if ( j<pixels.length && i<pixels.length && pixels[i] > pixels[j] ) {
      c = pixels[i];
      pixels[i] = pixels[j];
      pixels[j] = c;
    }
  }
  updatePixels();
  
  // salvataggio
  save(imgFileName+"_glitched.png");
  println("Finished");
}

// interruzione sketch
void mousePressed() {
  exit(); 
}
