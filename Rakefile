desc "Builds the site to ../gammons.github.io"
task :publish do
  system "middleman build --build-dir=../gammons.github.io/"
  system "cd ../gammons.github.io && git add * && git commit -a -m 'new build' && git push"
end

desc "run middleman"
task :run do
  system "docker-compose up"
end

desc "Create a new article"
task :new do
  system "docker-compose run middleman middleman article #{ARGV.last}"
end

task :default => :run
