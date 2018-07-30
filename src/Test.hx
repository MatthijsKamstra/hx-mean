package;

import js.node.Fs;

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
		// Fs.readFile('/views/mtt/_layout', function (err, content) {
		// 	if (err) return callback(err)
		// 	// this is an extremely simple template engine
		// 	var rendered = content.toString().replace('#title#', '<title>' + options.title + '</title>')
		// 	.replace('#message#', '<h1>' + options.message + '</h1>')
		// 	return callback(null, rendered)
		// })

		return 'mtt';
	}



}