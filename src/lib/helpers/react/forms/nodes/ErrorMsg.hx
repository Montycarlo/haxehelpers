package helpers.react.forms.nodes;

import api.react.ReactComponent.ReactComponentOfProps;
import api.react.ReactMacro.jsx;

private class InputProps{
	@:optional public var msg:String;
}

class ErrorMsg extends ReactComponentOfProps<InputProps>{

	override public function componentWillMount(){}

  override public function render(){
		if(props.msg == "" || props.msg == null) return null;
    return jsx('<div className="input-error">${props.msg}</div>');
  }

}
