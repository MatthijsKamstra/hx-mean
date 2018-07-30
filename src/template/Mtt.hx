package template;

import js.Node;
import js.node.Fs;
import js.node.Path;

class Mtt {

	public function new(arg) {
		// your code
	}

	/**
	 * [Description]
	 * @param filePath
	 * @param options
	 * @param callback
	 * @return String
	 */
	public static function engine(filePath : String, options : {}, callback:haxe.Constraints.Function) : String {

		trace('Template.engine ( ${filePath} , ${options}, ${callback})');

		// hack haxe because it uses dce and this disappears
		[].iterator();

		//
		var users : Array<Dynamic> = [{name:"Mark", age:30}, {name:"John", age:45}];
		var layout : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_layout.mtt'), 'utf8');
		var index : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_index.mtt'), 'utf8');
		// var index : String = Fs.readFileSync(filePath, 'utf8');

		var indexTemplate = new haxe.Template(index);
		var userOutput = indexTemplate.execute({users: users});

		// var userTemplate = new haxe.Template("::foreach users:: ::name::(::age::) ::end::");
		// var userOutput = userTemplate.execute({users: _users});

		var obj = {
			content : userOutput
		};

		for( ff in Reflect.fields(obj) ){
			Reflect.setField (options, ff, Reflect.field(obj, ff));
		}

		var layoutTemplate = new haxe.Template(layout);
		var output = layoutTemplate.execute(options);

		return output;
	}

}
