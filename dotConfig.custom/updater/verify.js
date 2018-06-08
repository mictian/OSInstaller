
var	exec = require('child_process').exec;

module.exports = {
	updater_cmd: "apt-get --just-print upgrade"

,	re_new_versions_extracter: /Inst\s([\w,\-,\d,\.,~,:,\+]+)\s\[([\w,\-,\d,\.,~,:,\+]+)\]\s\(([\w,\-,\d,\.,~,:,\+]+)\)? /gi

,	checkVersions: function (cb)
	{
		var self = this;

		exec(self.updater_cmd, function (error, stdout, stdin)
		{
			if (error)
			{
				cb(error);
			}

			var myArray = []
			,	output = {
					stringResult: ''
				,	newVersions: []
				};

			while ((myArray = self.re_new_versions_extracter.exec(stdout)) !== null)
			{
				output.newVersions.push({
					program: myArray[1]
				,	currentVersion:  myArray[2]
				,	newVersion: myArray[3]
				});

				output.stringResult += 'Program ' + myArray[1] + ' installed version: ' + myArray[2] + ' new version: ' + myArray[3] + '\n';
			}

			output.areUpdatedAvailable = !!output.newVersions.length;

			cb(null, output);
		});
	}
}