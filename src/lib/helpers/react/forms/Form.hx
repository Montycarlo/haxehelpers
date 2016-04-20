package helpers.react.forms;

import api.react.ReactMacro.jsx;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfState;
import api.react.React;

private class FormState{}

private class FormItem extends ReactComponent{

	override public function render(){
		return jsx('
			<div className="form-group" key=${this.props.c.props.label}>
				${this.props.c}
			</div>
		');

	}

}

class Form extends ReactComponentOfState<FormState>{

	private static function renderChild(c:ReactComponent):ReactComponent{
		return jsx('<FormItem c=$c></FormItem>');
	}

	override public function render(){
		return jsx('
				<form>
					${this.props.children.map(renderChild)}
					<button className="btn btn-primary">Submit</button>
				</form>
		');
	}

}
