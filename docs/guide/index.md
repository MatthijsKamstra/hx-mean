# How to start

you can do some amazing automation with NPM.

I collected them in `package.json`

```bash
npm run start:lazy
```

it assumes a lot:

This will start:

- mongodb
- open mongobooster
- open browser (<http://localhost:8000/>)
- watch css/hx
- nodemon

**problems:**

usually it fails because `mongod` (mongodb) is already running... in my case

## Saver start


```bash
npm run watch
```

- starts livereload
- start nodemon (also watches for changes to `server.js`/node file)
- watches for change to css/scss files
- watches for change to Haxe files

