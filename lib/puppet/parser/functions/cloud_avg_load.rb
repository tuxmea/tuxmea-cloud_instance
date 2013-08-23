# Function cloud_avg_load
# needs args: arg[0] - node (array)
# fetches load facts data from puppetdb
# parses data and calculates average
# returns average
Puppet::Parser::Functions.newfunction(:cloud_avg_load, :type => :rvalue) do |args|
    Puppet::Parser::Functions.autoloader.loadall
    array = function_query_nodes( ['fqdn~=".*"','load'] )
    array.inject { |sum, x| sum.to_f + x.to_f }.fo_f / array.size.to_f
end

