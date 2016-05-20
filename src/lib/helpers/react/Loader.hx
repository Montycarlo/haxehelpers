package helpers.react;

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;
import haxe.Json;

private typedef LoaderProps = { 
	@:optional var id:String;
}
private typedef LoaderState = {
	var c:Int;
	var m:Int;
	var msg:String;
	var pStyle:Dynamic;
}

class Loader extends ReactComponentOfPropsAndState<LoaderProps, LoaderState>{

	override public function componentWillMount(){
		setState({c:0,m:1, msg:"",pStyle:{}});
	}

	public function setMax(m:Int) state.m = m;
	public function update(c:Int, msg:String) {
		state.c = c;
		state.msg = msg;
		state.pStyle = {
			"transition":"width .1s ease",
			width:'${percent()}%'
		};
		forceUpdate();
	}

	public function updateLeft(left:Int, msg:String) update(state.m - left, msg);
	inline private function percent() return Math.round(state.c/state.m*100);

  override public function render(){
		var id = props.id == null ? "loader" : props.id;
    return jsx('
			<div id=$id className="loader">
				<div className="progress-wrapper">
					<div className="progress-bar progress-bar-success" role="progressbar"
				  aria-valuenow="${percent()}" aria-valuemin="0" aria-valuemax="100" style=${state.pStyle}/>
				</div>
				<div>${percent()}%</div>
				<div>${state.msg}%</div>
			</div>');
  }
}
