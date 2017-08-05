$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin_excel_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin_excel_upload"
  s.version     = ActiveAdminExcelUpload::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ActiveAdminExcelUpload."
  s.description = "TODO: Description of ActiveAdminExcelUpload."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.5"

  s.add_development_dependency "pg"
end
