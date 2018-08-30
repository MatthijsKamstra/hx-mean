# Request

Because `params` are typed as `{}`

You can't (without Haxe compiler complaining) ask for `req/params.id`


## Example code

```haxe
	router.get('/id/:id', function(req:Request, res:Response) {
		// var id = req.params.id; // Computer says NO! // { } has no field id
		// var id = untyped req.params.id;
		// var id = req.param('id'); // Deprecated
		var id = Reflect.getProperty(req.params,'id');
		var json = { id : id, status:'ok'}
		res.json(json);
	});
```


### how?

**methode 1:** `untyped`

this is useally the fasted way, but this way you will not get typechecking

If you want to get a Haxe developer mad, use this one (I do this a lot....)

```haxe
	var id = untyped req.params.id;
```

**methode 2:** function call

Deprecated


```haxe
	var id = req.param('id'); // Deprecated
```


**methode 2:** Reflect


The [Reflect](https://api.haxe.org/Reflect.html) API is a way to manipulate values dynamically through an abstract interface in an untyped manner. Use with care.

Essential it's **methode 1** but the nice Haxe way

```haxe
	var id = Reflect.getProperty(req.params,'id');
```

