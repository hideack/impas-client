require 'benchmark'
require 'CSV'
require 'impas-client'

client = Impas::Client.new

if ARGV.length != 2
  puts "Usage:"
  puts "ruby parse_tsv.rb [Parse target file] [Impas group key]"
  exit
end

puts "Parse start. Target:#{ARGV[0]}"

puts Benchmark::CAPTION
puts Benchmark.measure{
  CSV.foreach(ARGV[0], :col_sep=>"\t") do |row|
    client.add_url ARGV[1], row[1], row[0]
  end
}

