#!/usr/bin/env ruby
require 'yaml'
require 'pry'

STRICT_MODE = true
ENGINES = ['leihs_admin']

def task_hash(name, exec)
  h = {
    'name' => name,
    'scripts' => {
      'test' => {
        'body' =>
          "set -euxundefinedexport PATH=~/.rubies/$RUBY/bin:$PATHundefinedmkdir -p logundefined#{exec}"
      }
    }
  }
  h
end

def task_for_feature_file(file_path, _timeout = 200)
  name = file_path.match(%r{features\/(.*)\.feature}).captures.first
  exec =
    "DISPLAY=undefined:$XVNC_PORTundefined bundle exec cucumber -p default #{if STRICT_MODE
      '--strict '
    else
      nil
    end}\"#{file_path}\""
  task_hash(name, exec)
end

def create_feature_tasks(filepath, feature_files)
  File.open(filepath, 'w') do |f|
    string = { 'tasks' => feature_files.map { |f| task_for_feature_file(f) } }
    f.write(string.to_yaml)
  end
end

leihs_feature_files =
  Dir.glob('features/**/*.feature') - Dir.glob('features/personas/*.feature') -
    Dir.glob('features/**/*.feature.disabled') -
    Dir.glob('engines/**/features/*')
filepath = 'cider-ci/tasks/all-features.yml'
create_feature_tasks(filepath, leihs_feature_files)

ENGINES.each do |engine|
  engine_feature_files = Dir.glob("engines/#{engine}/features/**/*.feature")
  filepath = "cider-ci/tasks/#{engine}-features.yml"
  create_feature_tasks(filepath, engine_feature_files)
end
