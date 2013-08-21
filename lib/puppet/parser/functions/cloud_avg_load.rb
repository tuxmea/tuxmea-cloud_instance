# cloud_avg_load function needs args:
# arg[0] - node (array)
Puppet::Parser::Functions.newfunction(:cloud_avg_load, :type => :rvalue) do |args|
    puppet_confdir = File.read Puppet.settings[:confdir]
    puppet_ssldir = File.read Puppet.settings[:ssldir]
    puppetdb_configfile = "#{puppet_confdir}/puppetdb.conf"
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



