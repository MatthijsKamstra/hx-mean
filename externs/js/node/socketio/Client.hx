package externs.js.node.socketio;

/**
 * Externs for Socket.io 2.0
 * Project: https://socket.io/docs/server-api/
 * Definitions by: 	Gauthier Billot <https://github.com/gogoprog>
 * 					Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/gogoprog/hxsocketio>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
@:native("typeof io == 'undefined' ? require('socket.io-client') : io")
extern class Client extends Socket
{
    @:selfCall
    public function new(?server:String, ?options:ClientOptions);
}

typedef ClientOptions = {
    ?query:String
}
