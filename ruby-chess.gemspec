files = Dir.glob(Dir.pwd + '/**/*.rb')
files.collect! {|file| file.sub(Dir.pwd + '/', '')}
files -= files.select {|file| file =~ /scripts/}
files.push('LICENSE', 'README.md', 'rakefile')

Gem::Specification.new do |s|
  s.name        = 'ruby-chess'
  s.version     = '0.0.0'
	s.date        = "#{Time.now.strftime("%Y-%m-%d")}"
	s.homepage    = 'https://github.com/jphager2/chess'
  s.summary     = 'Chess game logic in Ruby'
  s.description = 'A gem to play chess'
  s.authors     = ['jphager2']
  s.email       = 'jphager2@gmail.com'
  s.files       = files 
  s.executables << 'ruby-chess.rb'
  s.license     = 'MIT'
end
