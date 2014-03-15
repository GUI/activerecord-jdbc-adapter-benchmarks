require_relative 'model'
require_relative 'info'

class ActiveRecord::ConnectionAdapters::Column
  class << self
    def string_to_time_with_logging(string)
      puts "  Entered string_to_time"
      string_to_time_without_logging(string)
    end
    alias_method_chain :string_to_time, :logging
  end
end

puts "Begin find"
product = Product.where(:id => 1).select('sample_datetime, sample_datetime AS custom_sample_datetime').first
puts "End find\n\n"

puts "Begin sample_datetime"
puts "  sample_datetime: #{product.sample_datetime.class}"
puts "End sample_datetime\n\n"

puts "Begin custom_sample_datetime"
puts "  sample_datetime: #{product.sample_datetime.class}"
puts "End custom_sample_datetime"
