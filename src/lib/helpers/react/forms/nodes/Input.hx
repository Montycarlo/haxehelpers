package helpers.react.forms.nodes;

import api.react.ReactComponent.ReactComponentOfPropsAndState;
import api.react.ReactMacro.jsx;
import helpers.react.forms.nodes.Label;

private typedef InputProps = {
	@optional public var type:String;
	@optional public var label:String;
}

private class InputState{
	public var type:String;
	public var label:Null<String>;
	public function new(){}
}

class Input extends ReactComponentOfPropsAndState<InputProps, InputState>{

	public function new() super();

	override public function componentWillMount(){
		state = new InputState();
		state.type  = props.type  != null ? props.type:'text';
		state.label = props.label;
	}

  override public function render(){
    return jsx('
		<div className="form-group" key=${props.label}>
			<Label text=${state.label} />
			<input
				type=${state.type}
			></input>
		</div>');
  }

}
