# jQuery



```haxe

// imports
import js.Browser.*;
import js.jquery.JQuery;


// code
JQuery.ajax({
	url: "/endpoint/test",
}).done(function(data:String) {
	console.log('loaded: ${data}');
});
```


