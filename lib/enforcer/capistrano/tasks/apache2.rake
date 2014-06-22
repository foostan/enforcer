desc 'Passing check service+apache2'
task 'pass:service:apache2', :node_name do |task, args|
  puts "Passing check service:apache2 of #{args.node_name}"
end

desc 'Failing check service:apache2'
task 'fail:service:apache2', :node_name do |task, args|
  puts "Failing check service:apache2 of #{args.node_name}"
end

