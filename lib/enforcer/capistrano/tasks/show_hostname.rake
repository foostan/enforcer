desc "Show server' hostname"
task :show_hostname do
  on release_roles :all do
    execute 'hostname'
  end
end