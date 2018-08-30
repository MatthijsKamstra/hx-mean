# package.json

When working with NPM you will use `package.json`.


When working with Haxe you will have at least one of them.
But in this project there are two:

- `/package.json` (in the root folder)
- `/bin/package.json` (in the "export" folder)

Why are there two?

## /bin/package.json

The `/bin/package.json` is what you normally would do when working with node.js, it contains all the packages you want to use.

For example:

```json
...
	"dependencies": {
    	"bcrypt": "^3.0.0",
    	"body-parser": "^1.18.3",
		...
```

You use this to install these dependencies:

```bash
npm run install
```

But because I use Haxe to compile we don't need scripts in the `package.json`.


## package.json

The `/package.json` is used to automate things.

```json
	"devDependencies": {
		"livereload": "^0.7.0",
		"node-sass": "^4.9.3",
		"nodemon": "^1.18.4",
		"npm-run-all": "^4.1.3",
		"onchange": "^2.0.0"
	}
```

Because I use these scripts a lot, I have installed them globally (`-g`)

```bash
npm run install -g
```

That also means you don't have an extra `node_modules` in the root. :)

And its the location for the automation scripts

```json
...
	"scripts": {
		"start": "node server/server.js",

		...
```

