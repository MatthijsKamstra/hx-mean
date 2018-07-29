import js.node.Fs

class Test {
	public function new(arg) {
		// your code
	}

	public static function template(templateName:String) : Void
	{
		switch (templateName) {
			case 'mtt':
				trace ('mtt');
				Test.mtt();
			default : trace ("case '"+templateName+"': trace ('"+templateName+"');");
		}
	}

	public static function mtt() : Void
	{
		// Fs.readFile('/views/mtt/_layout', function (err, content) {
		// 	if (err) return callback(err)
		// 	// this is an extremely simple template engine
		// 	var rendered = content.toString().replace('#title#', '<title>' + options.title + '</title>')
		// 	.replace('#message#', '<h1>' + options.message + '</h1>')
		// 	return callback(null, rendered)
		// })
	}



}