package helpers.react.forms.nodes;

import api.react.ReactMacro.jsx;
import helpers.react.forms.nodes.Input;

/* https://facebook.github.io/react-native/docs/textinput.html */
class IntegerInput extends Input{

	override public function componentWillMount(){
		super.componentWillMount();
		state.type = "number";
	}

}
