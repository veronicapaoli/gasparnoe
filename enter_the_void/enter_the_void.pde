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
 Channel Shift Image Glitching Processing v1.1
 datamoshing.com | 2016
 
 */

// richiamare l'utilizzo immagine
PImage sourceImg;
PImage targetImg;

boolean glitchComplete = false;
boolean glitchSaved = false;

// percorso immagine all'interno della cartella dello sketch
String imgFileName = "enter_the_void";
String fileType = "PNG";

// numero di iterazioni del processo
int iterations = 10;

boolean recursiveIterations = false;

// spostamento verticale
boolean shiftVertically = true;

// spostamento orizzontale
boolean shiftHorizontally = true;

void setup() {
  // caricamento di PImage
  targetImg = loadImage(imgFileName+"."+fileType);
  sourceImg = loadImage(imgFileName+"."+fileType);
  
  size(1, 1);

  surface.setResizable(true);
  surface.setSize(targetImg.width, targetImg.height);

  // caricare l'immagine
  image(sourceImg, 0, 0);
}


void draw() { 
  if (!glitchComplete)
  {
    // load pixels
    sourceImg.loadPixels();
    targetImg.loadPixels();
  
    // ripetizione del processo a seconda della variabile di iterazione
    for(int i = 0;i < iterations;i++)
    {
      int sourceChannel = int(random(3));
      int targetChannel = int(random(3));
      
      int horizontalShift = 0; 
      
      if(shiftHorizontally)
        horizontalShift = int(random(targetImg.width));
      
      int verticalShift = 0;
      
      if(shiftVertically)
        verticalShift = int(random(targetImg.height));
      
      copyChannel(sourceImg.pixels, targetImg.pixels, verticalShift, horizontalShift, sourceChannel, targetChannel);
      
      if(recursiveIterations)
        sourceImg.pixels = targetImg.pixels;
    }
    
    targetImg.updatePixels();
      
    glitchComplete = true;

     // caricare l'immagine rielaborata
    image(targetImg, 0, 0, targetImg.width, targetImg.height);
  }

  if (glitchComplete && !glitchSaved) {

    // salvataggio
    targetImg.save(imgFileName+"_glitched.png");
    glitchSaved = true;
    println("Glitched image saved");
    println("Click or press any key to exit...");
  }
}

void copyChannel(color[] sourcePixels, color[] targetPixels, int sourceY, int sourceX, int sourceChannel, int targetChannel)
{
    for(int y = 0; y < targetImg.height; y++)
    {   
        int sourceYOffset = sourceY + y;
        
        if(sourceYOffset >= targetImg.height)
          sourceYOffset -= targetImg.height;
              
        for(int x = 0; x < targetImg.width; x++)
        {
            int sourceXOffset = sourceX + x;
            
            if(sourceXOffset >= targetImg.width)
              sourceXOffset -= targetImg.width;

            color sourcePixel = sourcePixels[sourceYOffset * targetImg.width + sourceXOffset];
            
            float sourceRed = red(sourcePixel);
            float sourceGreen = green(sourcePixel);
            float sourceBlue = blue(sourcePixel);
   
            color targetPixel = targetPixels[y * targetImg.width + x]; 

            float targetRed = red(targetPixel);
            float targetGreen = green(targetPixel);
            float targetBlue = blue(targetPixel);
            

            float sourceChannelValue = 0;
            
            switch(sourceChannel)
            {
              case 0:
   
                sourceChannelValue = sourceRed;
                break;
              case 1:
   
                sourceChannelValue = sourceGreen;
                break;
              case 2:
 
                sourceChannelValue = sourceBlue;
                break;
            }
            
            switch(targetChannel)
            {
              case 0:
                
                targetPixels[y * targetImg.width + x] =  color(sourceChannelValue, targetGreen, targetBlue);
                break;
              case 1:
              
                targetPixels[y * targetImg.width + x] =  color(targetRed, sourceChannelValue, targetBlue);
                break;
              case 2:
                
                targetPixels[y * targetImg.width + x] =  color(targetRed, targetGreen, sourceChannelValue);
                break;
            }

        }
    }
}

// interruzione sketch
void mouseClicked() {
  if (glitchSaved)
  {
    System.exit(0);
  }
}
