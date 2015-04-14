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
  Cursor aCursor;
  boolean mouseWasPressed=false;
  
  LEDpoint() {
      r=0;
      g=0;
      b=0;
      x=0;
      y=0;
      aCursor = new Cursor(amp, freq, decay, LEDradius+36, stroke);
      aCursor.setXY(x,y);

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
      aCursor = new Cursor(amp, freq, decay, LEDradius+36, stroke);
      aCursor.setXY(x,y);

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
      aCursor = new Cursor(amp, freq, decay, LEDradius+36, stroke);
      aCursor.setXY(x,y);

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
  
  void collidedWith(int xpoint, int ypoint, int i) {
    if(xpoint >= originx && xpoint <= originx + (radius * 2) &&
       ypoint >= originy && ypoint <= originy + (radius * 2)) {
         select();
          if (mousePressed) {
              if(!mouseWasPressed) {
                aCursor.resetTimer();
                mouseWasPressed=true;
              }
            
             r = redSlider;
             g = greenSlider;
             b = blueSlider; 
             
             int rowIndex = i/numLEDs;
             println("rowIndex: " +rowIndex);

             int alternate = rowIndex % 2;
             println("alternate: " +alternate);
             
             int finalIndex;
             
             if(alternate==1) {
                 finalIndex = i;
             } else {
                finalIndex = (numLEDs - 1) - ( i - (numLEDs * rowIndex) ) + ( numLEDs * rowIndex );
             }
             
             
             // Transmit color and index
             String[] message = new String[8];
             message[0] = "i";
             message[1] = nf(finalIndex,3);
             message[2] = "r";
             message[3] = nf(r,3);
             message[4] = "g";
             message[5] = nf(g,3);
             message[6] = "b";
             message[7] = nf(b,3);
             String strMessage = join(message,"");       
             println(strMessage);
             udp.send(strMessage, ip, port );   // the message to send
             
             
          }
          mouseWasPressed=false;
          
         println("slected!"); 

       } else {
        this.deselect();
         //println("deslected!"); 
       }
  }
  


  
  void select() {
    this.selected = true;
  }
  
  void deselect() {
    this.selected = false;
    aCursor.resetTimer();
  }
  
  void drawPoint() {
      if (selected) {
          //stroke(255^this.r,255^this.g,255^this.b);
          //aCursor.setColor(255^this.r,255^this.g,255^this.b);
          aCursor.setColor(this.r,this.g,this.b);

          aCursor.draw();
      } 
      fill(this.r,this.g,this.b);
      ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
      

  }
  
}
