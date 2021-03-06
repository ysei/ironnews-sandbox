#! ruby -Ku

require "rinda/tuplespace"
require "drb/drb"

ts = Rinda::TupleSpace.new
DRb.start_service(nil, ts)
puts DRb.uri

File.open("uri.bat", "w") { |file|
  file.printf("@set URI=%s\n", DRb.uri)
}

loop {
  symbol, result = ts.take([:result, Hash])
  p result

  File.open("result.txt", "a") { |file|
    file.puts(result.inspect)
  }
}
