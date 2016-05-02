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
// Forwarded fields
	@optional public var className:String;
	@optional public var dateFormat:String;
	@optional public var dateFormatCalendar:String;
	@optional public var disabled:Bool;
	@optional public var startDate:Dynamic;
	@optional public var endDate:Dynamic;
	@optional public var includeDates:Array<Dynamic>;
	@optional public var excludeDates:Array<Dynamic>;
	@optional public var filterDate:Dynamic->Bool;
	@optional public var id:String;
	@optional public var isClearable:Bool;
	@optional public var locale:String;
	@optional public var maxDate:Dynamic;
	@optional public var minDate:Dynamic;
	@optional public var name:String;
	@optional public var onBlur:Void->Void;
	@optional public var onChange:Moment->Void;
	@optional public var onFocus:Void->Void;
	@optional public var placeholderText:String;
	@optional public var popoverAttachment:String;
	@optional public var popovertargetAttachment:String;
	@optional public var popoverTargetOffset:String;
	@optional public var readOnly:Bool;
	@optional public var renderCalendarTo:Dynamic;
	@optoinal public var required:Bool;
	@optional public var selected:Moment;
	@optoinal public var showYearDropdown:Bool;
	@optional public var tabIndex:Int;
	@optional public var tetherConstraints:Array<Dynamic>;
	@optional public var title:String;
	@optoinal public var todayButton:String;
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
