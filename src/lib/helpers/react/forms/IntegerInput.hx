package helpers.react.forms;

import api.react.ReactMacro.jsx;
import helpers.react.forms.Input;

/* https://facebook.github.io/react-native/docs/textinput.html */
class IntegerInput extends Input{

	override public function componentWillMount(){
		super.componentWillMount();
		state.type = "number";
	}

}
