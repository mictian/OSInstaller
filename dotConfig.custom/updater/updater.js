//#! /usr/local/bin/node

var nodemailer = require('nodemailer')
,	update_verifier = require('./verify')


var	mail_transport = nodemailer.createTransport({
		service: 'Gmail'
	,	auth: {
			user: 'user@server.com'
		,	pass: 'email_password'
		}
	});

var mailTo = ['mictian42@gmail.com'];

var mailOptions = {
	from: 'Update Checker Daemon <updater.daemon@gmail.com>',
	to: mailTo.join(", "),
	subject: 'New Update Available',
	text: '',
	attachments: [
		// {
		// 	filename: file_name + '.new',
		// 	content: file_data.new.content
		// }
	]
};

update_verifier.checkVersions(function (err, result)
{
	if (err)
	{
		console.log('ERROR:', err);
		return;
	}

	if (result.areUpdatedAvailable)
	{
		mailOptions.text = result.stringResult;

		mail_transport.sendMail(mailOptions, function (error, info)
		{
			if (error)
			{
				console.log('\nError sending email', error);
			}
		});
	}
})