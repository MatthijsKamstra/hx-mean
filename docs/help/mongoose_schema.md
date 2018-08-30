# Mongoose Schema

Some difference between the original JS code and the Haxe code.

```js
var schema = new Schema({
	name: String,
	age: Number,
	children: [child]
});
```






<https://mongoosejs.com/docs/api.html#schema_Schema.Types>

- String
- Number
- Boolean | Bool
- Array
- Buffer
- Date
- ObjectId | Oid
- Mixed


just quote it and it works fine

```haxe
	schema = new Schema({
		uid : String,
		street_number : 'Number',
		postal_code : String,
		ismember : 'Boolean',
	});
```
