require 'benchmark'
require 'bigdecimal'
require 'jdbc/postgres'
require 'java'
require_relative 'info'

Jdbc::Postgres.load_driver

Java::org.postgresql.Driver
url = 'jdbc:postgresql://10.33.33.10:5493/jdbc_benchmark'
$conn = java.sql.DriverManager.get_connection(url, 'postgres', 'postgres')
$column_types = {}
$column_labels = {}

def query(sql)
  results = []

  statement = $conn.create_statement
  result_set = statement.execute_query(sql)
  meta_data = result_set.meta_data
  column_count = meta_data.column_count

  if($column_types.empty?)
    column_count.times do |i|
      index = i + 1
      $column_types[index] = meta_data.column_type_name(index)
      $column_labels[index] = meta_data.column_label(index)
    end
  end

  while(result_set.next) do
    result = {}
    column_count.times do |i|
      index = i + 1
      value = result_set.object(index)

      case($column_types[index])
      when 'date'
        cal = java.util.Calendar.getInstance();
        cal.setTime(value);
        value = Date.new(cal.get(java.util.Calendar::YEAR), cal.get(java.util.Calendar::MONTH), cal.get(java.util.Calendar::DAY_OF_MONTH))
      when 'time'
        value = Time.at(value.time / 1000.0)
      when 'timestamp'
        value = Time.at(value.time / 1000.0)
      when 'numeric'
        value = BigDecimal.new(value.to_s)
      when 'bytea'
        value = String.from_java_bytes(value)
      end

      result[$column_labels[index]] = value
    end

    results << result
  end

  statement.close

  results
end

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
  selects.each do |select|
    x.report("5000x SELECT #{select}, 1 record") do
      5_000.times do |i|
        query("SELECT #{select} FROM products WHERE id = #{i} LIMIT 1")
      end
    end
  end

  selects.each do |select|
    x.report("30x SELECT #{select}, 5000 records") do
      30.times do |i|
        query("SELECT #{select} FROM products")
      end
    end
  end
end

$conn.close
