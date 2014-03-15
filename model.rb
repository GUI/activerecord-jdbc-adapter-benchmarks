require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => (RUBY_PLATFORM == 'java') ? 'jdbcpostgresql' : 'postgresql',
  :host => '10.33.33.10',
  :port => 5493,
  :username => 'postgres',
  :password => 'postgres',
  :database => 'jdbc_benchmark'
)

class Product < ActiveRecord::Base
end

unless(ActiveRecord::Base.connection.table_exists?(:products))
  Product.connection.drop_table(:products)
  Product.connection.create_table(:products) do |t|
    t.binary :sample_binary
    t.boolean :sample_boolean
    t.date :sample_date
    t.datetime :sample_datetime
    t.decimal :sample_decimal, :precision => 12, :scale => 4
    t.float :sample_float
    t.integer :sample_integer
    t.string :sample_string
    t.text :sample_text
    t.time :sample_time
    t.timestamp :sample_timestamp
  end

  5_000.times do |i|
    Product.create!({
      :id => i,
      :sample_binary => Random.new.bytes(1024),
      :sample_boolean => false,
      :sample_date => Date.today,
      :sample_datetime => Time.now,
      :sample_decimal => BigDecimal.new('18202824.2345'),
      :sample_float => 829.8203749235,
      :sample_integer => 2723,
      :sample_string => 'Hello, Goodbye',
      :sample_text => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo, mauris eu pulvinar porta, nunc est fringilla lorem, sit amet mattis massa libero id tellus. Praesent pretium, turpis et vestibulum accumsan, eros turpis rutrum diam, a elementum magna mi ut nisi. Sed sed porttitor urna, sed fringilla lectus. Nunc aliquam, arcu et vulputate vulputate, turpis massa auctor sem, in venenatis ligula tellus ut mi. Aenean pulvinar ligula tellus, vel commodo augue cursus a. In dictum diam ut ligula placerat, eget faucibus augue fermentum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse eget ligula in turpis vulputate eleifend eu et felis. Nam nec mattis lorem.',
      :sample_time => Time.now,
      :sample_timestamp => Time.now,
    })
  end
end
