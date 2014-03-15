puts "RUBY_PLATFORM: #{RUBY_PLATFORM}"
puts "RUBY_VERSION: #{RUBY_VERSION}"

if(defined?(ActiveRecord))
  puts "ActiveRecord.version: #{ActiveRecord.version.to_s}"

  if(RUBY_PLATFORM == 'java')
    puts "arjdbc.datetime.raw: #{ActiveRecord::ConnectionAdapters::JdbcConnection.raw_date_time?.inspect}"
  end
end

puts "\n"
