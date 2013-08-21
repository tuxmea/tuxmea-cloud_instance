Facter.add('load') do
    setcode 'cat /proc/loadavg | cut -d ' ' -f1'
end
