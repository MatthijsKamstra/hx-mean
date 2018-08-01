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



