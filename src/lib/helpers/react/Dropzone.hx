package helpers.react;

import api.react.ReactComponent;
import api.react.ReactMacro.jsx;
import js.Browser;
import js.html.FileReader;
import haxe.Json;

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
	@:optional var cleartxtCb:String->Void;
	@:optional var jsonCb:Dynamic->Void;
}
private typedef DropzoneState = {
	var id:String;
}

@:final class DropzoneFile{
  public var name(default,null):String;
  public var size(default,null):Int;
  public var content(default,null):String;
  public function new(name:String, size:Int, content:String){
    this.name = name;
    this.size = size;
    this.content = content;
  }
}

class Dropzone extends ReactComponentOfProps<DropzoneProps>{

	override public function componentWillMount(){
		setState({id:'dropzone${Std.random(10000)}'});
	}

	override public function componentDidMount(){
		if(untyped Browser.window.FileReader == null) return Browser.alert("Use a real browser.");
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
      js.Browser.console.log(f);
			var reader = new FileReader();
			reader.onloadend = function(e) onFileLoad(e, reader, f.name, f.size);
			reader.readAsText(f);
		}
		return cancel(e);
	}

	private function onFileLoad(e, reader:FileReader, name:String, size:Int):Void{
		var r:String = reader.result;
    if(props.cleartxtCb != null) props.cleartxtCb(new DropzoneFile(name, size, r));
    if(props.jsonCb != null) {
      var j;
			try{
				j = Json.parse(r);
			}catch(e:Dynamic){
				throw "Failed to parse input file: Invalid JSON.";
			}
      props.jsonCb(j);
    }
	}

  override public function render(){
		var msg = props.msg != null ? props.msg : "Drag and drop your file here.";
		var img = props.img != null ? jsx('<img src=${props.img} />') : null;
    return jsx('<div id=${state.id} className="dropzone">$msg$img</div>');
  }
}
