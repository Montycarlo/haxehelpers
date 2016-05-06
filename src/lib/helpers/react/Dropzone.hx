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
	@:optional var binCb:String->Void;
	@:optional var b64Cb:String->Void;
	@:optional var cleartxtCb:String->Void;
	@:optional var jsonCb:Dynamic->Void;
}

class Dropzone extends ReactComponentOfProps<DropzoneProps>{

	override public function componentDidMount(){
		if(untyped Browser.window.FileReader == null) return Browser.alert("USE A REAL BROWSER.");
		var zone = Browser.document.getElementById("dropzone");
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
			pre = "data:text/plain;base64,";
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
				throw "Failed to parse input file: Invalid JSON.";
			}
			props.jsonCb(j);
		}
	}

  override public function render(){
    return jsx('<div id="dropzone" style={{background:"black",width:"300px",height:"300px"}}>
			hello!
		</div>');
  }
}
