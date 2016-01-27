$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "validates_combo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "validates_combo"
  s.version     = ValidatesCombo::VERSION
  s.authors     = ["Joseph Hunt"]
  s.email       = ["josephb.hunt@gmail.com"]
  s.homepage    = ""
  s.summary     = "ValidatesCombo provides a simple way to specify all of the valid combinations of parameters that can be assigned to a model."
  s.description = <<- TEXT
    ValidatesCombo validates combinations of model attributes.
  TEXT
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "sqlite3"
end
