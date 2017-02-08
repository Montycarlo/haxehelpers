package helpers.react;

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;

private typedef AccordianProps = {> ReactComponentProps,
	var showMsg:String;
	var hideMsg:String;
}
private typedef AccordianState = {
	var contracted:Bool;
}

class Accordian extends ReactComponentOfPropsAndState<AccordianProps, AccordianState>{

	override public function componentWillMount(){
		setState({contracted:true});
	}

	private function toggle(){
		state.contracted = !state.contracted;
		forceUpdate();
	}

	public function hide():Void
		if(!state.contracted) toggle();

  override public function render(){
    var display = state.contracted ? {"display":"none"} : {};
		var btnMsg = state.contracted ? props.showMsg : props.hideMsg;
    return jsx('
    <div>
			<div className="btn btn-default" onClick=$toggle>$btnMsg</div>
      <div style=$display className="accordian">
        ${props.children}
      </div>
    </div>
    ');
  }

}
