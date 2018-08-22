# Hx-Mean

![](img/banner.png)

MongoDB(M), Express(E), React(R), NodeJS(N).


>
Pre-requisites
You need to have a basic understanding of all the four technologies that make up the MERN stack. You should also have npm (Node Package Manager) installed. This is NOT a tutorial on MongoDB, Express, React or NodeJS.



## Desciption project

I wanted to build my MEAN stack in Haxe. So I build this example project to see if its doable.


- [Haxe](http://www.haxe.org) The Cross-platform Toolkit for transpiling to javascript [more](READ_HAXE.MD)
- [Bootstrap v4.0.0](https://getbootstrap.com/) for css framework
- [Fontawesome v5](https://fontawesome.com) for nice icons
- [Vue.js](https://vuejs.org/) a progressive framework for building user interfaces.
- [Vue router](https://github.com/vuejs/vue-router) The official router for Vue.js
- [sass](http://sass-lang.com/) CSS with superpowers
- [LiveReload chrome extension](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en)
- [hx-html](https://github.com/MatthijsKamstra/hx-html) experimental html template creation
- Swig [docs](http://node-swig.github.io/swig-templates/docs/) [Haxe extern](https://github.com/clemos/haxe-js-kit/blob/develop/js/npm/Swig.hx)




## Json definition aka AST

Easy way to make AST files for `.json`

<http://matthijskamstra.github.io/hxjsondef/>

## Install

Normally you can install with

```bash
haxelib install
```

But some stuff that doesn't install automaticly by haxelib.
You can fix that with the following commands

```bash
# haxe-js-kit for externs
haxelib git js-kit https://github.com/clemos/haxe-js-kit.git haxelib

# I sometimes use my personal set haxe-externs
haxelib git hxexterns https://github.com/MatthijsKamstra/hxexterns.git

# cutting edge vue.js externs
haxelib git vue https://github.com/MatthijsKamstra/Vue.hx.git
```




## Files

```
- package.json (I only use this for `watch`)
+ bin
	- package.json (here are your files node.js needs to work)
```


# run


This will start:

- mongodb
- open mongobooster
- open browswer
- watch css/hx
- nodemon

```
npm run start:lazy
```


```
npm run watch
```



# misc

```
→ mongod --version
db version v3.6.3
git version: 9586e557d54ef70f9ca4b43c26892cd55257e1a5
OpenSSL version: OpenSSL 1.0.2o  27 Mar 2018
allocator: system
modules: none
build environment:
    distarch: x86_64
    target_arch: x86_64
```

http://mongoosejs.com/docs/compatibility.html

-  MongoDB Server 3.6.x: mongoose 5.x, or >=4.11.0 with useMongoClient and usePushEach
- MongoDB Server 4.0.x: mongoose >=5.2.0


# How does it work?

MongoDB works with Mongoose

Express

Node.js

Some prefer a different templating system.


# Templating

- Use static files
- Server generated templates
- Client generated templates

# Server generated templates

Use templates to generate them on the server and send the template to the client

- Swig [docs](http://node-swig.github.io/swig-templates/docs/) [Haxe extern](https://github.com/clemos/haxe-js-kit/blob/develop/js/npm/Swig.hx)
- Jade (is now called Pug) [Haxe extern](https://github.com/clemos/haxe-js-kit/blob/develop/js/npm/Jade.hx)
- ejs [Haxe extern](https://github.com/clemos/haxe-js-kit/blob/develop/js/npm/Ejs.hx)
- Mustache

# Client generated Templating

- react
- vue.js
- (Angular)



# Haxe specific templating

- Haxe default templating <http://api.haxe.org/haxe/Template.html>
- https://github.com/nadako/hxmustache
- https://github.com/haxetink/tink_template
- https://github.com/benmerckx/ithril
- https://github.com/ciscoheat/mithril-hx






# externs

https://github.com/clemos/haxe-js-kit/tree/develop/js/npm/mongoose


https://github.com/clemos/haxe-js-kit/tree/develop/js/npm/socketio


https://github.com/clemos/haxe-js-kit/tree/develop/js/npm/express





https://github.com/MatthijsKamstra/hxexterns



https://github.com/wiggin77/HxMongoNode




https://github.com/abedev/hxexpress


# ts

https://www.npmjs.com/package/@types/express

https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/express




https://microsoft.github.io/TypeSearch/





https://www.npmjs.com/package/@types/mongoose


https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/mongoose





