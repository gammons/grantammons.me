desc "Builds the site to ../gammons.github.io"
task :build do
  system "middleman build --build-dir=../gammons.github.io/"
  system "cd ../gammons.github.io && git add * && git commit -a -m 'new build' && git push"
end

task :default => :build
