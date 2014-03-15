## JRuby 1.7.11 + ActiveRecord 4.0.4

```sh
$ RBENV_VERSION=jruby-1.7.11 ruby cast.rb
RUBY_PLATFORM: java
RUBY_VERSION: 1.9.3
ActiveRecord.version: 4.0.4
arjdbc.datetime.raw: nil

Begin find
  Entered string_to_time
  Entered string_to_time
End find

Begin sample_datetime
  sample_datetime: Time
End sample_datetime

Begin custom_sample_datetime
  sample_datetime: Time
End custom_sample_datetime
```

## JRuby 1.7.11 + ActiveRecord 4.0.4 + arjdbc.datetime.raw=true

```sh
$ RBENV_VERSION=jruby-1.7.11 JRUBY_OPTS="-J-Darjdbc.datetime.raw=true" ruby cast.rb
RUBY_PLATFORM: java
RUBY_VERSION: 1.9.3
ActiveRecord.version: 4.0.4
arjdbc.datetime.raw: true

Begin find
End find

Begin sample_datetime
  Entered string_to_time
  sample_datetime: Time
End sample_datetime

Begin custom_sample_datetime
  sample_datetime: Time
End custom_sample_datetime
```

## MRI Ruby 2.1.1 + ActiveRecord 4.0.4

```sh
$ RBENV_VERSION=2.1.1 ruby cast.rb
RUBY_PLATFORM: x86_64-darwin12.0
RUBY_VERSION: 2.1.1
ActiveRecord.version: 4.0.4

Begin find
End find

Begin sample_datetime
  Entered string_to_time
  sample_datetime: Time
End sample_datetime

Begin custom_sample_datetime
  sample_datetime: Time
End custom_sample_datetime
```
