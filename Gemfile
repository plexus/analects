source 'https://rubygems.org'

group :development, :test do
  gem 'devtools', git: 'https://github.com/rom-rb/devtools.git'
  eval_gemfile 'Gemfile.devtools'
end

if ENV['LOCAL']
  source = ->(s) { { path: ENV['HOME'] + "/github/#{s}" } }
else
  source = ->(s) { { github: "plexus/#{s}" } }
end

gem 'rmmseg'   , source.('rmmseg')
gem 'ting'     , source.('ting')

gemspec
