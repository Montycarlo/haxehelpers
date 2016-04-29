package helpers.react.forms.nodes; 

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;
import helpers.react.forms.nodes.Label;
import helpers.react.forms.model.Field;
import helpers.extern.Moment;

private typedef DatePickerProps = {
	@optional public var formkey:String;
	@optional public var label:String;
	@optional public var bind:Field<Moment>;
}
private class DatePickerState{
	public var value:Field<Moment>;
	public function new(){}
}

@:native("DatePicker")
extern class DatePicker_{
	/* https://hacker0x01.github.io/react-datepicker/ */
}

class DatePicker extends ReactComponentOfPropsAndState<DatePickerProps, DatePickerState>{
	
	override public function componentWillMount(){
		state = new DatePickerState();
		state.value = props.bind != null ? props.bind : new Field<Moment>();
	}

	private function getFormkey():String 
		return (props.formkey == null ? props.label : props.formkey);

	private function onChange(date):Void{
		state.value.set(date);
		hideError();
		setState(state);
	}
	private inline function hideError():Void state.value.clean();

  override public function render(){
    return jsx('
		<div className="form-group" key=${getFormkey()}>
			<Label text=${props.label} />
			<DatePicker_
				selected=${state.value.value}
				onChange=${onChange} />
			${state.value.errors}
		</div>');
  }
}
