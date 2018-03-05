#!/usr/bin/env bundle exec rails runner

FileUtils.mkdir_p('tmp/dumpall')

def save_to_file(name, data)
  f = File.new("tmp/dumpall/#{name}.json", 'w')
  f.write(JSON.pretty_generate(data))
  f.close
end

COUNT = User.all.count

# User.first(3).each do |user|
User.all.each_with_index do |user, index|
  p = Borrow::CustomerOrders.new(user: user)
  save_to_file(user.id, p.dump)
  puts "total: #{COUNT}; done: #{index + 1}"
end
