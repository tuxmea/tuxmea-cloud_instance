# Function cloud_avg_load
# needs args: arg[0] - node (array)
# fetches load facts data from puppetdb
# parses data and calculates average
# returns average
require 'net/https'
require 'uri'
Puppet::Parser::Functions.newfunction(:cloud_avg_load, :type => :rvalue) do |args|
    load = Array.new()
    # set some basic configuration parameters
    # we need to find puppetdb.conf wich is located differently on PE and Open Source.
    # we need to find where the certificates are (can be individual configuration)
    puppet_confdir = File.read Puppet.settings[:confdir]
    puppet_ssldir = File.read Puppet.settings[:ssldir]
    puppet_certname = File.read Puppet.settings[:certname]
    puppetdb_configfile = "#{puppet_confdir}/puppetdb.conf"
    # scan puppetdb.conf for server and port
    # TODO: handle defaults if file is absent or value is not set
    IO.foreach(puppetdb_configfile) do |line|
        if line.match(/server/)
            puppetdb_server = line.split('=').[1]
        end
        if line.match(/port/)
            puppetdb_port = line.split('=').[1]
        end
    end
    # we need to run something similiar to the following:
    # curl -H "Accept: application/json" -X GET https://<puppetdb_server>:<puppetdb_port>/v2/facts/load --cacert <puppet_ssldir>/certs/ca.pem --cert <puppet_ssldir>/certs/<puppet master certname>.pem --key <puppet_ssldir>/private_keys/<puppet master certname>.pem
    #
    # build up URI and https call
    uri = URI.parse("https://#{puppetdb_server}:#{puppetdb_port}/v2/facts/load")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.cert = File.read("#{puppet_ssldir}/certs/#{puppet_certname}.pem")
    http.key = File.read("#{puppet_ssldir}/private_keys/#{puppet_certname}.pem")
    http.ca_file = File.read("#{puppet_ssldir}/certs/ca.pem")
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    if resonse.code == "200"
        result = JSON.parse(response.body)
        result.each do |node|
            load.push(node['load'])
        end
        # sum up
        sum = load.inject{|sum,x| sum + x}
        # elements
        num = load.size
        puts sum / num
    end
end

