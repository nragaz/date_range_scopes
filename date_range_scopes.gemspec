Gem::Specification.new do |s|
  s.name = "date_range_scopes"
  s.summary = "Automatically add scopes for day, week, month and year ranges to Active Record models."
  s.description = "Automatically add scopes for day, week, month and year ranges to Active Record models."
  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.version = "0.0.1"
  
  s.add_dependency 'rails', '~> 3'
  
  s.add_development_dependency 'sqlite3'
end
