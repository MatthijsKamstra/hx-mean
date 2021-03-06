package externs.js.node.socketio;

extern class Namespace extends Socket
{
    public function use(?func:Socket->Dynamic->Void):Void;
}

/**
 * Haxe externs for Socket.io 2.0
 * Project: https://socket.io/docs/server-api/
 * Definitions by: 	Gauthier Billot <https://github.com/gogoprog>
 * 					Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/gogoprog/hxsocketio>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
@:jsRequire("socket.io")
extern class Server extends Namespace
{
    public var sockets:Namespace;

    public function new(?a:Dynamic, ?b:Dynamic);

    public function serveClient(v:Bool):Server;
    public function path(v:String):Server;
    public function adapter(v:Dynamic):Server;
    public function origins(v:String):Server;
    public function attach(srv_or_port:Dynamic, ?opts:Dynamic):Server;
    public function listen(srv_or_port:Dynamic, ?opts:Dynamic):Server;
    public function of(namespace:String):Namespace;
    public function close():Void;
}
