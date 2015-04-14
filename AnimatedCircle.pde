class Cursor {
    int t;
    int amp = 100;
    float freq = 0.05;
    float decay = 0.1;
    
    // Stops when animation is complete
    boolean done = false;
    
    double radiusOffset;
    int circleRadius;
    int stroke;
    int circleX;
    int circleY;
    
    int r;
    int g;
    int b;
    
    double upperBound;
    double lowerBound;
    double previous;
    boolean positive=true;
    
    Cursor(int amp, float freq, float decay, int circleRadius, int stroke) {
      
      this.amp = amp;
      this.freq = freq;
      this.decay = decay;
      this.circleRadius = circleRadius;
      this.circleX = circleX;
      this.circleY = circleY;
      this.stroke = stroke;      
      this.upperBound = amp/2;
      this.lowerBound = -amp/2;
      this.t=0;
      this.r=0;
      this.g=0;
      this.b=0;
      
    }
    
    void setColor(int r, int g, int b) {
       this.r=r;
       this.g=g;
       this.b=b; 
    }
    
    void resetTimer() {
       t=0; 
       done=false;
       positive=true;
      this.upperBound = amp/2;
      this.lowerBound = -amp/2;
    }
    
    void setXY(int x, int y) {
      circleX=x;
      circleY=y; 
    }
    
    void draw() {
      
             radiusOffset = (amp*Math.sin(t*freq*Math.PI*2)/Math.exp(t*decay))/3;
              //radiusOffset = amp*Math.sin(t*speed);
     
            
            // increment time until animation has stopped
            // println("done? ",done);
            if(!done) {
                t++;
            }
            
          if(radiusOffset-previous < 0){
            // If slope was positive and just turned negative, store that upperbound
            if(positive) {
                upperBound = radiusOffset;
                positive = false;
            }
          } 
          
          
          else if (radiusOffset-previous > 0) {
            // If slope was negative and just turned positive, store that lowerbound
      
            if(!positive) {
                lowerBound = radiusOffset;
                positive = true; 
            }
          }
          previous = radiusOffset;
          // println("Radius Offset: ",radiusOffset);
          if ( ( lowerBound > -20.0 ) && ( upperBound < 20.0 ) && ( radiusOffset < 0.1 ) && ( radiusOffset > -0.1 ) ) {
                     // println("Activated at upper: ", upperBound);
                     // println("Activated at lower: ", lowerBound);

                     fill(r, g, b);
                     ellipse(circleX, circleY, (int)(circleRadius), (int)(circleRadius));
                     // println("outerRadius: ",circleRadius+radiusOffset);
            
                     
                     fill(r, g, b);
                     ellipse(circleX, circleY, (int)(circleRadius-stroke), (int)(circleRadius-stroke));
                     println("t end: ", t);
                    done = true;
          } else {

      
               fill(r, g, b);
               ellipse(circleX, circleY, (int)(circleRadius+radiusOffset), (int)(circleRadius+radiusOffset));
      
               
               fill(r, g, b);
               ellipse(circleX, circleY, (int)(circleRadius-stroke+radiusOffset), (int)(circleRadius-stroke+radiusOffset));
          }
      
    }
    
    
}

