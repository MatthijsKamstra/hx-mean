package template;

import js.Node;
import js.node.Fs;
import js.node.Path;

import js.Node.console;

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
	public static function engine(filePath : String, options : {}, callback:haxe.Constraints.Function)  {
		// trace('Template.engine ( ${filePath} , ${options}, ${callback})');

		// hack haxe because it uses dce and this disappears
		[].iterator();

		var layout : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_layout.mtt'), 'utf8');
		var index : String = Fs.readFileSync(filePath, 'utf8');

		var contentTemplate = new haxe.Template(index);
		var templateOutput = contentTemplate.execute(options);

		var obj = {
			content : templateOutput
		};

		for( ff in Reflect.fields(obj) ){
			Reflect.setField (options, ff, Reflect.field(obj, ff));
		}

		var layoutTemplate = new haxe.Template(layout);
		var output = layoutTemplate.execute(options);

		// trace(output);

		// return output;

		return callback(null, output);
	}

}
