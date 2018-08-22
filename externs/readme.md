# Source original externs

mongoDb and mongoose: <https://github.com/wiggin77/HxMongoNode>

socket.io: <https://github.com/gogoprog/hxsocketio>

express.js: <https://github.com/abedev/hxexpress>


-----

# hxsocketio

Haxe externs for [socket.io](socket.io).

## Basic usage

### Requirements

  * Only Haxe JavaScript target supported
  * Socket.io npm modules

### Server

```haxe
import js.node.socketio.*;

class ServerTest
{
    static public function main()
    {
        var server = new Server();

        server.listen(8000);

        server.on(
            'connection',
            function(socket:Socket)
            {
                socket.emit('message', { content: 'Hello World!' });

                socket.on('message',
                    function (data)
                    {
                        // Do something
                    });
            }
        );
    }
}
```

### Client

Both browser and Node.js JavaScript are supported.

```haxe
import js.node.socketio.*;

class ClientTest
{
    static public function main()
    {
        var client = new Client("http://localhost:8000/");

        client.on('message',
            function (data)
            {
                // Do something
            });
    }
}
```