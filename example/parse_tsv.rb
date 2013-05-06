require 'benchmark'
require 'CSV'
require 'impas-client'
require 'parallel'

client = Impas::Client.new({api_url:'http://impas-hideack.sqale.jp/'})

if ARGV.length != 3
  puts "Usage:"
  puts "ruby parse_tsv.rb [Parse target file] [Impas group key] [client threads]"
  exit
end

puts "CSV Parse start. Target:#{ARGV[0]}"

targetUrls = []
CSV.foreach(ARGV[0], :col_sep=>"\t") do |row|
  targetUrls << row
end

puts "CSV Parse finished."
puts "Impas post start."

puts Benchmark::CAPTION
puts Benchmark.measure{
  Parallel.each(targetUrls, in_threads: ARGV[2].to_i) do |row|
    client.add_url ARGV[1], row[1], row[0]
  end
}

