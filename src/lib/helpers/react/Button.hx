package helpers.react;

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;

private typedef ButtonProps = {> ReactComponentProps,
	var label:String;
	var onClick:Void->Void;
	@:optional var visible:Bool;
	@:optional var className:String;
}
private typedef ButtonState = {}

class Button extends ReactComponentOfPropsAndState<ButtonProps, ButtonState>{

	override public function componentWillMount(){
		setState({});
	}

  override public function render(){
		if(!props.visible) return null;
		var className = props.className == null ? "btn btn-default" : props.className;
    return jsx('
		<div className=${className} onClick=${props.onClick}>${props.label}</div>
    ');
  }

}
