package helpers.react.forms.nodes;

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;

typedef LabelProps = {
	@optional var className:String;
	@optional var text:String;
}

class Label extends ReactComponentOfProps<LabelProps>{
	
	public function new() super();

	override public function render(){
		if(props.text == null) return null;
		return jsx('<label className=${props.className}>${props.text}</label>');
	}

}
