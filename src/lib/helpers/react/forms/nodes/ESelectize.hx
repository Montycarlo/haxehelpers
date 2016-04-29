package helpers.react.forms.nodes;

import api.react.ReactComponent.ReactComponentOfPropsAndState;
import api.react.ReactMacro.jsx;
import helpers.react.forms.nodes.Label;
import helpers.react.forms.model.Field;
import helpers.react.forms.Form;
import epidev.Selectize;

private typedef InputProps = {
	@optional public var bind:Field<String>;

	//SelectizeProps
	var ops:Array<ISelectizeOption>;
	@optional var formkey:String;
	@optional var startEmpty:Bool;
	@optional var create:Bool;
	@optional var placeholder:String;
	@optional var label:String;
	@optional var onChange:String->Void;
}
private class InputState{
	public var value:Field<String>;
	public function new(){}
}

class ESelectize extends ReactComponentOfPropsAndState<InputProps, InputState>{

	override public function componentWillMount(){
		state = new InputState();
		state.value = props.bind != null ? props.bind : new Field<String>();
	}

	private function getFormkey():String 
		return (props.formkey == null ? props.label : props.formkey);

	private function onChange(value):Void{
		state.value.set(value);
		hideError();
		setState(state);
		if(props.onChange != null) props.onChange(value);
	}
	private inline function hideError():Void state.value.clean();

  override public function render(){
    return jsx('
<div className="form-group" key=${getFormkey()}>
<Selectize onChange=${onChange} 
	ops=${props.ops}
	formkey=${props.formkey}
	startEmpty=${props.startEmpty}
	create=${props.create}
	placeholder=${props.placeholder}
	label=${props.label}
/>
${state.value.errors}
</div>');
  }

}
