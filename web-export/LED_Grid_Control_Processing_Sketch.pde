import controlP5.*;
import hypermedia.net.*;
 
UDP udp;  // define the UDP object

//boolean sketchFullScreen() { return true; }



LEDpoint LEDArray[];
int numLEDs = 7;
int LEDradius = 25;
ControlP5 cp5;
int gridSpacing;

public int redSlider, greenSlider, blueSlider;



void setup() {

  
  
  // size(displayWidth, displayHeight);
  size(840,980);
  background(0.0,0.0,0.0);
  strokeWeight(5);
  
  LEDArray = new LEDpoint[numLEDs * numLEDs];
  println("Array Length: " + LEDArray.length);
  gridSpacing = width < height ? width/(numLEDs + 1) : height/(numLEDs + 1);
  
  
  int index = 0;
  
  for (int x = gridSpacing; x <= (width < height ? width : height) - gridSpacing; x += gridSpacing) {
    for (int y = gridSpacing; y <= (width < height ? width : height) - gridSpacing; y += gridSpacing) {
      
      LEDArray[index++] = new LEDpoint(x,y,LEDradius);

    }
  }
  
  // GUI Code with ControlP5
  cp5 = new ControlP5(this);
  PFont font = createFont("default",20);
  
    // add a horizontal slider
  cp5.addSlider("redSlider")
     .setPosition(gridSpacing-LEDradius,gridSpacing * (numLEDs+1))
     .setSize(200,20)
     .setRange(0,255)
     .setValue(128)
     .setCaptionLabel("Red")
     .setColorBackground(color(100,100,100));
     ;
  
  // reposition the Label for controller 'slider'
  cp5.getController("redSlider").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("redSlider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  
  cp5.addSlider("greenSlider")
     .setPosition(gridSpacing-LEDradius,(gridSpacing * (numLEDs+1)) + 40)
     .setSize(200,20)
     .setRange(0,255)
     .setValue(128)
     .setCaptionLabel("Green")
     .setColorBackground(color(100,100,100));
     ;
  
  // reposition the Label for controller 'slider'
  cp5.getController("greenSlider").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("greenSlider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  
    cp5.addSlider("blueSlider")
     .setPosition(gridSpacing-LEDradius,(gridSpacing * (numLEDs+1)) + 80)
     .setSize(200,20)
     .setRange(0,255)
     .setValue(128)
     .setCaptionLabel("Blue")
     .setColorBackground(color(100,100,100));

     ;
  
  // reposition the Label for controller 'slider'
  cp5.getController("blueSlider").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("blueSlider").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  

}

void draw() {
    background(0.0,0.0,0.0);

  for(LEDpoint LED : LEDArray) {

     LED.collidedWith(mouseX,mouseY);
     LED.drawPoint();
     
  }
  
  // Draw Palette
  fill(redSlider,greenSlider,blueSlider);
  noStroke();
  rect((gridSpacing*(numLEDs-1))+LEDradius,gridSpacing * (numLEDs+1), 100, 100,15);
  
}

class LEDpoint {
    
  int r;
  int g;
  int b;
  int x;
  int y;
  int originx = 0 ;
  int originy = 0 ; // origin is upper left corner instead of center
  boolean selected = false;
  int radius;
  
  LEDpoint() {
      r=0;
      g=0;
      b=0;
      x=0;
      y=0;
  }
  
    LEDpoint(int xpoint,int ypoint, int rad) {
      r=50;
      g=50;
      b=50;
      x=xpoint;
      y=ypoint;
      radius = rad;
      // Set top left origin of shape
      originx = x - rad;
      originy = y - rad;
  }
  
    LEDpoint(int xpoint,int ypoint, int red, int gre, int blu, int rad) {
      r=red;
      g=gre;
      b=blu;
      x=xpoint;
      y=ypoint;
      radius = rad;
      // Set top left origin of shape
      originx = x - rad;
      originy = y - rad;

  }
  
  void setColor(int red,int green, int blue) {
   
    r=red;
    g=green;
    b=blue;  
    
  }
  
  void setLocation(int xpoint, int ypoint) {
      x=xpoint;
      y=ypoint;
  }
  
  void collidedWith(int xpoint, int ypoint) {
    if(xpoint >= originx && xpoint <= originx + (radius * 2) &&
       ypoint >= originy && ypoint <= originy + (radius * 2)) {
         this.select();
          if (mousePressed) {
             this.r = redSlider;
             this.g = greenSlider;
             this.b = blueSlider; 
          }

       } else {
        this.deselect(); 
       }
  }
  


  
  void select() {
    this.selected = true;
  }
  
  void deselect() {
    this.selected = false;
  }
  
  void drawPoint() {
      if (selected) {
          stroke(255^this.r,255^this.g,255^this.b);
      } else {
          stroke(this.r,this.g,this.b);
      }
      
      fill(this.r,this.g,this.b);
      ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
      

  }
  
}

public void redSlider(int r) {
   cp5.getController("redSlider").setColorForeground(color(r,0,0));   
   cp5.getController("redSlider").setColorActive(color(r,0,0));

   redSlider = r;
}

public void greenSlider(int g) {
   cp5.getController("greenSlider").setColorForeground(color(0,g,0));   
   cp5.getController("greenSlider").setColorActive(color(0,g,0));

   greenSlider = g;
}

public void blueSlider(int b) {
   cp5.getController("blueSlider").setColorForeground(color(0,0,b));
   cp5.getController("blueSlider").setColorActive(color(0,0,b));

   blueSlider = b;
}



