# Enforcer

Enforce tasks defined by capistrano to consul cluster by attender notification.

## Installation

Add this line to your application's Gemfile:

    gem 'enforcer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enforcer

## Usage
### Build test environment
Create the following servers by Vagrant
- Consul Server * 1 (include apache2 and ntp)
- Consul Client * 1 (include apache2 and ntp)
```
> git clone git@github.com:foostan/enforcer.git
> cd enforcer
> vagrant up
```

### Setup
```
> bundle install
```

### Attender
```
> bundle exec attender 192.168.33.101
- server-01 service:apache2 # stop apache2 in server-01
- server-01 service:ntp     # stop ntp in server-01
+ server-01 service:apache2 # start apache2 in server-01
+ server-01 service:ntp     # start ntp in server-01
- client-01 serfHealth      # host down client-01
+ client-01 serfHealth      # host up client-01
```

### Enforcer
```
> bundle exec attender 192.168.33.101 | bundle exec bin/ax
** Invoke test (first_time)
** Execute test
** Invoke load:defaults (first_time)
** Execute load:defaults
** Invoke fail:service:apache2 (first_time)
** Execute fail:service:apache2
Failing check service:apache2 of client-01

** Invoke test
** Invoke pass:service:apache2 (first_time)
** Execute pass:service:apache2
Passing check service:apache2 of client-01
```

### Edit tasks
```
> editor lib/enforcer/capistrano/tasks/*.rake
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/enforcer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
