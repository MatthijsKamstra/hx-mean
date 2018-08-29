# Export to js

Normally Haxe will export all its js code to one file, which is fine.

But that is probably not what you want when you work with not Haxe developers.

So its possible to convert Haxe code into CommonJs or ES6.


## HxGenJs

<https://github.com/kevinresol/hxgenjs>

install via haxelib

```bash
haxelib install hxgenjs
```

# how

Run

```bash
haxe buld_hxgenjs.hxml
```

Will create a `bin_gen` folder with the server (Haxe) code to CommonJs or ES6 for your Node.js project

