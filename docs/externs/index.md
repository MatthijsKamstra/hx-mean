# Haxe externs

Usueally I would advise to use


[TODO]
js-kit


But I have decide to make it easier to manage the externs.

no idea when version project





but not class with the existing externs



`js.npm.express.*`

so renamed it to

`externs.js.npm.express.*`



## Better idea

I totally  stole this from the TypeScript

```haxe
/**
 * Haxe externs for express.js 4.16.3 (4.x)
 * Project: http://expressjs.com/
 * Definitions by:  Franco Ponticelli <https://github.com/fponticelli>
 *                  Matthijs Kamstra aka [mck] <https://github.com/MatthijsKamstra>
 * Definitions:     <https://github.com/abedev/hxexpress>
 *                  <https://github.com/matthijskamstra/hx-mean>
 */
```


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