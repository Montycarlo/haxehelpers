package helpers.react.forms.model; 

class Field<T>{

	public var value:T;
	public var errors:Array<String>;

	public function new(?x:T){
		value = x;
		errors = new Array<String>();
	}

	public function set(x):Field<T>{
		value = x;
		return this;
	}

	public function get():T{
		return value;
	}

	public function clean():Void{
		errors = [];
	}

}
