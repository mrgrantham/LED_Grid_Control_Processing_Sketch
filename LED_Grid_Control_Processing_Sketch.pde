import controlP5.*;
import hypermedia.net.*;
 
UDP udp;  // define the UDP object
String ip       = "192.168.1.96"; // the remote IP address
int port        = 8888;        // the destination port
 
 
//boolean sketchFullScreen() { return true; }

LEDpoint LEDArray[];
int numLEDs = 7;
int LEDradius = 25;
ControlP5 cp5;
int gridSpacing;

public int redSlider, greenSlider, blueSlider;

// Selection cursor setup
  int amp = 100;
  float freq = 0.08;
  float decay = 0.1;

void setup() {

// Network setup

   udp = new UDP( this, 6000 );  // create a new datagram connection on port 6000
   //udp.log( true );         // <-- printout the connection activity
   udp.listen( true );           // and wait for incoming message  
  

  
// Window Setup

  // size(displayWidth, displayHeight);
  size(840,980);
  background(0.0,0.0,0.0);
  
  LEDArray = new LEDpoint[numLEDs * numLEDs];
  println("Array Length: " + LEDArray.length);
  gridSpacing = width < height ? width/(numLEDs + 1) : height/(numLEDs + 1);
  
  
  int index = 0;
  
  for (int y = gridSpacing; y <= (width < height ? width : height) - gridSpacing; y += gridSpacing) {
    for (int x = gridSpacing; x <= (width < height ? width : height) - gridSpacing; x += gridSpacing) {
      
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
    background( 0.0, 0.0, 0.0);
  int i = 0;
  for(LEDpoint LED : LEDArray) {

     LED.collidedWith(mouseX,mouseY,i);
     LED.drawPoint();
     i++;
  }
  
  // Draw Palette
  fill(redSlider,greenSlider,blueSlider);
  noStroke();
  rect((gridSpacing*(numLEDs-1))+LEDradius,gridSpacing * (numLEDs+1), 100, 100,15);
  
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



