package externs.js.node.socketio;

/**
 * Haxe externs for Socket.io 2.0
 * Project: https://socket.io/docs/server-api/
 * Definitions by:  Gauthier Billot <https://github.com/gogoprog>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/gogoprog/hxsocketio>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
extern class Socket
{
    public var rooms:Array<String>;
    public var id:String;

    @:overload(function (name:String, ?data:Dynamic, ?callback:Dynamic->Void):Void{})
    @:overload(function (name:String, ?callback:Dynamic->Void):Void{})
    public function emit(name:String, ?data:Dynamic):Void;
    public function join(name:String, ?callback:Dynamic):Socket;
    public function leave(name:String, ?callback:Dynamic):Socket;
    public function to(room:String):Socket;

    @:overload(function (event:String, ?func:Void->Void):Void{})
    @:overload(function (event:String, ?func:Dynamic->Dynamic->Void):Void{})
    public function on(event:String, ?func:Dynamic->Void):Void;


    @:overload(function (event:String, ?func:Void->Void):Void{})
    @:overload(function (event:String, ?func:Dynamic->Dynamic->Void):Void{})
    public function once(event:String, ?func:Dynamic->Void):Void;
}
