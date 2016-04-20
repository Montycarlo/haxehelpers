package helpers.react.forms;

import api.react.ReactMacro.jsx;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfState;
import api.react.React;

interface FormItem{
	
}

private class FormState{}

class FormItemProps{}

class Form extends ReactComponentOfState<FormState>{

	override public function render(){
		return jsx('
			<form>
				${this.props.children}
				<button className="btn btn-primary">Submit</button>
			</form>
		');
	}

}
