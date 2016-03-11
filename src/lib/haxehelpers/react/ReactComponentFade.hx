package haxehelpers.react;

import api.react.ReactComponent;
import haxe.Timer;

class ReactComponentFade extends ReactComponent{

  private var alphaV:Float;
  private var delay:Int;
  private var timeStep:Int;
  private var __timer:Timer;

  private function new(alphaV:Float, delay:Int, timeStep:Int){
    super();
    this.alphaV = alphaV;
    this.delay = delay;
    this.timeStep = timeStep;
    state = {alpha:1}
  }

  private function __getStyles():Dynamic return {}; 
  private function getStyles(){
    var s = __getStyles();
    s.opacity = state.alpha;
    return s;
  }

  private function fade(){
    setState({alpha:state.alpha -alphaV});
    if(state.alpha <= 0) {
      __timer.stop();
      props.cb();
    }   
  }

  override public function componentDidMount():Void{
    var f = function(){
      this.__timer = new Timer(timeStep);
      this.__timer.run = fade;
    }   
    Timer.delay(f, delay);
  }

}

