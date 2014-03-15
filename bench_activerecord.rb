require_relative 'model'
require_relative 'info'

selects = [
  '*',
  'sample_binary',
  'sample_boolean',
  'sample_date',
  'sample_datetime',
  'sample_decimal',
  'sample_float',
  'sample_integer',
  'sample_string',
  'sample_text',
  'sample_time',
  'sample_timestamp',
]

Benchmark.bmbm do |x|
  x.report("100_000x Column.string_to_time") do
    100_000.times do |i|
      ActiveRecord::ConnectionAdapters::Column.string_to_time("Wed, 04 Sep 2013 03:00:00 EAT")
    end
  end

  selects.each do |select|
    x.report("5000x SELECT #{select}, 1 record") do
      5_000.times do |i|
        Product.select(select).where(:id => i).first
      end
    end

    x.report("5000x SELECT #{select}, 1 record - get attributes") do
      5_000.times do |i|
        Product.select(select).where(:id => i).first.attributes
      end
    end
  end

  selects.each do |select|
    x.report("30x SELECT #{select}, 5000 records") do
      30.times do |i|
        Product.select(select).to_a
      end
    end

    x.report("30x SELECT #{select}, 5000 records - get attributes") do
      30.times do |i|
        Product.select(select).to_a.each do |record|
          record.attributes
        end
      end
    end
  end
end
