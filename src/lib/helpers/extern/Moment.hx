package helpers.extern; 

@:native("moment")
extern class Moment{

	public function new(?x:String, ?y:String);

	public function format(x:String):String;

	public function fromNow():String;

	public function startOf(x:String):Moment;
	public function endOf(x:String):Moment;

	public function add(x:Int, y:String):Moment;
	public function subtract(x:Int, y:String):Moment;

	public function calendar():String;

	public function locale():String;
	
}
