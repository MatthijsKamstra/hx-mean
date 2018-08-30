package;

import js.Node;
import js.node.Fs;
import js.node.Path;

class Test {
	public function new(arg) {
		// your code
	}

	public static function template(templateName:String) : String
	{
		switch (templateName) {
			case 'mtt':
				trace ('mtt');
				return Test.mtt();
			default : trace ("case '"+templateName+"': trace ('"+templateName+"');");
				return "xx";
		}


	}

	public static function mtt() : String
	{
		// hack Haxe because it uses dce and this disappears
		[].iterator();

		//
		var users : Array<Dynamic> = [{name:"Mark", age:30}, {name:"John", age:45}];
		var layout : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_layout.mtt'), 'utf8');
		var index : String = Fs.readFileSync(Path.join(Node.__dirname, '/views/mtt/_index.mtt'), 'utf8');

		var indexTemplate = new haxe.Template(index);
		var userOutput = indexTemplate.execute({users: users});

		// var userTemplate = new haxe.Template("::foreach users:: ::name::(::age::) ::end::");
		// var userOutput = userTemplate.execute({users: _users});


		var layoutTemplate = new haxe.Template(layout);
		var output = layoutTemplate.execute({
			content : userOutput,
			title : 'Haxe templating'
		});

		return output;
	}



}