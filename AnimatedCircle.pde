class AnimatedCircle {
    
    
    int radius;
    int circleX;
    int circleY;
    int currentRadius;
    
    int r;
    int g;
    int b;
    
    int prevR;
    int prevG;
    int prevB;
    
    AnimationCurve circleAnimator; 
    
    
    AnimatedCircle(int radius, int circleX, int circleY, int r, int g, int b) {
      
      this.circleX = circleX;
      this.circleY = circleY;
      this.radius = radius;
      circleAnimator = new AnimationCurve( 100, 0.05, 0.1, radius, 0);
      this.r=r;
      this.g=g;
      this.b=b;
      this.prevR=r;
      this.prevG=g;
      this.prevB=b;
      
    }
    
    void draw() {
             
             delay(0);
             
             if(circleAnimator.stopped()) {
               fill(this.prevR,this.prevG,this.prevB);
               ellipse(circleX, circleY, this.radius, this.radius);
             }

             println("red: ",r);
             println("green: ",g);
             println("blue: ",b);

             fill(this.r, this.g, this.b);
             circleAnimator.iterate();
             currentRadius = circleAnimator.currentPosition();
             ellipse(circleX, circleY, (int)(currentRadius), (int)(currentRadius));
    }
    
    void setColor(int r, int g, int b) {
       this.prevR=this.r;
       this.prevG=this.g;
       this.prevB=this.b;
       this.r=r;
       this.g=g;
       this.b=b; 
    }
    
    void resetTimer() {
        circleAnimator.resetTimer();
    }
    
    void setXY(int x, int y) {
      circleX=x;
      circleY=y; 
    }
    
    
    
}
