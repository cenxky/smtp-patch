## SMTP Patch

Enhance Ruby net/smtp library to be never interrupted by errors while mail sending to multiple recipients.

### Purpose

Sometimes, when you are sending mail to multiple recipients, once there is at last 1 error in address of recipients, such as email address is not existed, or some recipients have blacklisted your mail address, the whole sending progress will be failed. No matter what your Ruby framework or Ruby gem you used.

Because this is a problem of Ruby baisc library `net/smtp`. In the `SMTP` class you can find this function [`rcptto_list`](https://github.com/ruby/ruby/blob/master/lib/net/smtp.rb#L840) which transfer recipient email addresses to Mail server one by one and deliver the mail data at last. Unfortunately, during the process, if any SMTP error raised by address transfering, the whole sending process will be halt at once. That is to say all the recipients will not receive the mail. Technically based on it's current logic, if the error is `SMTPAuthenticationError`, the email will be still sent, but it's not enough.

This patch is to fix this problem to keep mail be always sent and raise errors(if existed) at last.

BTW, some other languages' SMTP library, such as `smtplib` in Python, `nodemailer` in Nodejs are working without the problem. :sweat_smile:

### Installation

Add the gem to your Gemfile:

    gem 'smtp-patch'

Install the gem with bundler:

    bundle install

## Usage

Once you are using this patch in your project, the mail will always be sent when you are sending a mail to multiple recipients. Meaningwhile, during the sending, if there are errors happened, the errors will not raise at once but raise after email sent out. You can catch the errors like below:

```ruby
begin
  recipients = %w(jjlin@example.com jaychou@example.com)
  Mailer.test_email(recipients).deliver_now! # Rails Mailer example
rescue => e
  puts e.class #=> Net::SMTPErrors
  puts e.message #=> failed to deliver for {"jjlin@example.com"=>#<Net::SMTPFatalError: 554 RCPT (jjlin@example.com) dosn't exist>}.
  puts e.errors #=> { "jjlin@example.com" => #<Net::SMTPFatalError: 554 RCPT (jjlin@example.com) dosn't exist> }
end
```

## License

Released under the [MIT](http://opensource.org/licenses/MIT) license. See LICENSE file for details.
