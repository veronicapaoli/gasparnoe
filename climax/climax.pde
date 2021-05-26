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
 Simple Image Glitching Processing
 datamoshing.com | 2016
 
 */

// richiamare l'utilizzo immagine
PImage img; 
// percorso immagine all'interno della cartella dello sketch
String imgFileName = "climax";
String fileType = "PNG";

boolean glitchComplete = false;
boolean glitchSaved = false;

void setup() {
  img = loadImage(imgFileName+"."+fileType);

  size(1, 1);

  surface.setResizable(true);
  surface.setSize(img.width, img.height);

  // caricare l'immagine
  image(img, 0, 0, img.width, img.height);
}


void draw() {
  if (!glitchComplete)
  {
    img.loadPixels();

    boolean previousPixelGlitched = false;

    color randomColor = color(random(255), random(255), random(255), 255);

    for (int x = 0; x < img.width; x++) {       // colonna di pixel

      for (int y = 0; y < img.height; y++) {   // riga di pixel

        // 25% di possibilità che il pixel X sia rielaborato, con un 80% di possibilità ancora se il pixel precedente è stato rielaborato
        if (random(100) < 25 || (previousPixelGlitched == true && random(100) < 80))
        {
          previousPixelGlitched = true;

          color pixelColor = img.pixels[y + x * img.height];

          float mixPercentage = .3 + random(30)/100;
        
          img.pixels[y + x * img.height] =  lerpColor(pixelColor, randomColor, mixPercentage);
        } else
        {
          previousPixelGlitched = false;

          randomColor = color(random(255), random(255), random(255), 255);
        }
      }
    }

    img.updatePixels();
    glitchComplete = true;

    // caricare l'immagine rielaborata
    image(img, 0, 0, img.width, img.height);

  }

  if (glitchComplete && !glitchSaved) {

    // salvataggio
    img.save(imgFileName+"_glitched.png");
    glitchSaved = true;
    println("Glitched image saved");
    println("Click or press any key to exit...");
  }
}
// interruzione sketch
void mouseClicked() {
  if (glitchSaved)
  {
    System.exit(0);
  }
}
