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
 jbum
 forum.processing.org | 2020
 
 */

// richiamare l'utilizzo immagine
PImage myImage;
// percorso immagine all'interno della cartella dello sketch
String imgFileName = "i_stand_alone";
String fileType = "PNG";


float distortion = 30; // ampiezza; 30 per la tipografia, 15 per le immagini
float speed1 = .01;
float speed2 = 5;

void setup()
{
  size(2216, 826);
  myImage = loadImage(imgFileName+"."+fileType);
}

void draw()
{
  background(0);
  for (int i = 0; i < myImage.width; ++i) {
    copy(myImage, i,0,1,height, i, (int) (sin((millis()+i*speed2)*speed1)*distortion),1,height);
  }
  // salvataggio
  save(imgFileName+"_glitched.png");
  println("Finished");
}

// interruzione sketch
void mousePressed() {
  exit(); 
}
