package;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef Library = {
	name:String, type:String,
	version:String, dir:String,
	ref:String, url:String
}

class Setup {
	public static function main():Void {
		// Create a folder to prevent messing with hmm libraries
		if (!FileSystem.exists(".haxelib"))
			FileSystem.createDirectory(".haxelib");

		// brief explanation: first we parse a json containing the library names, data, and such
		final libs:Array<Library> = Json.parse(File.getContent('./hmm.json')).dependencies;

		// now we loop through the data we currently have
		for (data in libs) {
			// and install the libraries, based on their type
			switch (data.type) {
				case "install", "haxelib": // for libraries only available in the haxe package manager
					var version:String = data.version == null ? "" : data.version;
					if (!FileSystem.exists(".haxelib/" + data.name) || (FileSystem.exists(".haxelib/" + data.name + "/.current") ? File.getContent(".haxelib/" + data.name + "/.current") != data.version : true))
            Sys.command('haxelib --quiet install ${data.name} ${version}');
				case "git": // for libraries that contain git repositories
					var ref:String = data.ref == null ? "" : data.ref;
          if (!FileSystem.exists(".haxelib/" + data.name) || (FileSystem.exists(".haxelib/" + data.name + "/.current") ? File.getContent(".haxelib/" + data.name + "/.current") != "git" : true))
					  Sys.command('haxelib --quiet git ${data.name} ${data.url} ${data.ref}');
				default: // and finally, throw an error if the library has no type
					Sys.println('[PSYCH ENGINE SETUP]: Unable to resolve library of type "${data.type}" for library "${data.name}"');
			}
		}

		// after the loop, we can leave
		Sys.exit(0);
	}
}
