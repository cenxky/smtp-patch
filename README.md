## SMTP Patch

Enhance Ruby net/smtp library to be never interrupted by errors while mail sending to multiple recipients.

### Installation

Add the gem to your Gemfile:

    gem 'smtp-patch'

Install the gem with bundler:

    bundle install

## Usage

By default, the mail will always be sent when you are sending a mail to multiple recipients. However, during the sending, if there are errors happened, the errors will not raise at once but raise after email sent out. You can catch the errors like below:

```ruby
begin
  Mailer.test.deliver_now!
rescue => e
  puts e.class #=> Net::SMTPErrors
  puts e.message #=> failed to deliver for {"abc@example.com"=>#<Net::SMTPFatalError: 554 RCPT (abc@example.com) dosn't exist>}.
  puts e.errors #=> { "abc@example.com" => #<Net::SMTPFatalError: 554 RCPT (abc@example.com) dosn't exist> }
end
```

## License

Released under the [MIT](http://opensource.org/licenses/MIT) license. See LICENSE file for details.
