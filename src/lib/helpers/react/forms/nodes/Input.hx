package helpers.react.forms.nodes;

import api.react.ReactComponent.ReactComponentOfPropsAndState;
import api.react.ReactMacro.jsx;
import helpers.react.forms.nodes.Label;
import helpers.react.forms.nodes.ErrorMsg;
import helpers.react.forms.model.Field;
import helpers.react.forms.Form;

private class InputProps{
	@:optional public var formkey:String;
	@:optional public var label:String;
	@:optional public var type:String;
	@:optional public var bind:Field<String>;
	@:optional public var className:Field<String>;
	@:optional public var id:Field<String>;
}

private class InputState{
	public var type:String;
	public var label:Null<String>;
	public var value:Field<String>;
	public function new(){}
}

class Input extends ReactComponentOfPropsAndState<InputProps, InputState>{

	override public function componentWillMount(){
		state = new InputState();
		state.type  = props.type  != null ? props.type:'text';
		state.label = props.label;
		state.value = props.bind != null ? props.bind : new Field<String>();
	}

	private function getFormkey():String return (props.formkey == null ? props.label : props.formkey);

	private function onChange(e):Void{
		state.value.set(e.target.value);
		hideError();
		forceUpdate();
	}
	private inline function hideError():Void state.value.clean();

  override public function render(){
		var className = 'form-group ${props.className}';
    return jsx('
		<div id=${props.id} className=${className} key=${getFormkey()}>
			<Label text=${state.label} />
			<input
				type=${state.type}
				onChange=$onChange
				value=${state.value.value}
			></input>
			<ErrorMsg msg=${state.value.errors} />
		</div>');
  }

}
