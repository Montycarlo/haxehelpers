package helpers.react;

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;
import js.Browser;
import js.html.FileReader;
import haxe.Json;
import haxe.io.Bytes;
import haxe.crypto.Base64;

@:enum
private abstract DragFileEvent(String) to String{
	var DRAG_OVER = 'dragover';
	var DRAG_ENTER = 'dragenter';
	var DRAG_DROP = 'drop';
}

private typedef DropzoneProps = { 
	@:optional var id:String;
	@:optional var msg:String;
	@:optional var img:String;
	@:optional var binCb:String->Void;
	@:optional var b64Cb:String->Void;
	@:optional var cleartxtCb:String->Void;
	@:optional var jsonCb:Dynamic->Void;
}
private typedef DropzoneState = {
	var id:String;
}

class Dropzone extends ReactComponentOfProps<DropzoneProps>{

	override public function componentWillMount(){
		setState({id:'dropzone${Std.random(10000)}'});
	}

	override public function componentDidMount(){
		if(untyped Browser.window.FileReader == null) return Browser.alert("USE A REAL BROWSER.");
		var zone = Browser.document.getElementById(state.id);
    zone.addEventListener(DRAG_OVER, cancel, false);
    zone.addEventListener(DRAG_ENTER, cancel, false);
    zone.addEventListener(DRAG_DROP, droppedFile, false);
	}

  inline private function cancel(e) {
    if (e.preventDefault != null) { e.preventDefault(); }
    return false;
  }

	private function droppedFile(e){
		var dt = e.dataTransfer;
		var files:Array<Dynamic> = dt.files;
		for(f in files){
			var reader = new FileReader();
			reader.onloadend = function(e) onFileLoad(e, reader);
			reader.readAsDataURL(f);
		}
		return cancel(e);
	}

	private function onFileLoad(e, reader:FileReader):Void{
		var r:String = reader.result;
		var pre:String = "";
		var rr64:String = "";
		var rr:String = "";
		if(props.binCb != null) props.binCb(r);

		if(props.b64Cb != null || props.cleartxtCb != null || props.jsonCb != null){
			pre = "data:application/json;base64,";
			if(r.indexOf(pre) != 0) throw "Failed to parse input file: Unexpected prelude.";
			rr64 = r.substring(pre.length);
			if(props.b64Cb != null) props.b64Cb(rr64);
		}

		if(props.cleartxtCb != null || props.jsonCb != null){
			try{
				var rrb = Base64.decode(rr64);
				rr = rrb.getString(0,rrb.length);
			}catch(e:Dynamic){
				throw "Failed to parse input file: Unexpected non-b64 body.";
			}
			if(props.cleartxtCb != null) props.cleartxtCb(rr);
		}

		if(props.jsonCb != null){
			var j;
			try{
				j = Json.parse(rr);
			}catch(e:Dynamic){
trace(e);
				throw "Failed to parse input file: Invalid JSON.";
			}
			props.jsonCb(j);
		}
	}

  override public function render(){
		var msg = props.msg != null ? props.msg : "Drag and drop your file here.";
		var img = props.img != null ? jsx('<img src=${props.img} />') : null;//$msg
    return jsx('<div id=${state.id} className="dropzone">$msg$img</div>');
  }
}
