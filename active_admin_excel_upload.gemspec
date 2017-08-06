$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin_excel_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin_excel_upload"
  s.version     = ActiveAdminExcelUpload::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.5"
  s.add_dependency "coffee-rails"

  s.add_development_dependency "pg"
end
