package helpers.react.forms;

import api.react.ReactMacro.jsx;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfState;
import api.react.React;

private class FormState{}

typedef FormItemProps = {
	@optional var onSubmit:Dynamic->Void;
	@optional var children:Dynamic;
}

class Form extends ReactComponentOfPropsAndState<FormItemProps, FormState>{

	private function submitHandler(e:Dynamic){
		if(props.onSubmit != null) {
			e.preventDefault();
			props.onSubmit(e);
		}
	}

	override public function render(){
		return jsx('
			<form onSubmit=${submitHandler}>
				${this.props.children}
				<button className="btn btn-primary">Submit</button>
			</form>
		');
	}

}
