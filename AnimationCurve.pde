class AnimationCurve {
    boolean done;
    int t;
    int amp;
    float freq;
    float decay;
    int finalRest;
    double sineDecay;
    int currentPosition;
    int animationSelector=0;
    
    double upperBound;
    double lowerBound;
    double previous;
    boolean positive=true;

    AnimationCurve(int amp, float freq, float decay, int finalRest, int animationSelector) {
      this.amp = amp;
      this.freq = freq;
      this.decay = decay;
      this.finalRest = finalRest;
      this.upperBound = amp/2;
      this.lowerBound = -amp/2;
      this.t=0;
      this.animationSelector = animationSelector;
      this.done = false;
    }
    
    boolean iterate() {
                        
            // increment time until animation has stopped
            
            if (animationSelector == 0 ) {
                  done = bounceToNewLevel();
            }
            
            if(!done) {
                t++;
            }
    
          return done;

  }
  
  int currentPosition() {
       return this.currentPosition;
  }
    
    boolean bounceToNewLevel() {
                    
          sineDecay = (amp*Math.sin(t*freq*Math.PI*2)/Math.exp(t*decay));
          currentPosition =  (t==0) ? 0 : ( (int)(((finalRest*t)-(finalRest-1))/t) + (int)(sineDecay) );
          
          if(sineDecay-previous < 0){
            
              // If slope was positive and just turned negative, store that upperbound
              
              if(positive) {
                  upperBound = sineDecay;
                  positive = false;
              }
            
          } 
          
          
          else if (sineDecay-previous > 0) {
            // If slope was negative and just turned positive, store that lowerbound
      
            if(!positive) {
                lowerBound = sineDecay;
                positive = true; 
            }
          }
          previous = sineDecay;
          
          if ( ( lowerBound > -20.0 ) && ( upperBound < 20.0 ) && ( sineDecay < 0.1 ) && ( sineDecay > -0.1 ) ) {

            done = true;
            
          } 
        
        return done;
    }
  
}
