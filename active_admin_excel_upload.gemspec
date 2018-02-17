$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_admin_excel_upload/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_admin_excel_upload"
  s.version     = ActiveAdminExcelUpload::VERSION
  s.authors     = ["Shiv Garg"]
  s.email       = ["shivgarg5676@hotmail.com"]
  s.homepage    = "https://github.com/shivgarg5676/active_admin_excel_upload"
  s.summary     = "Excel upload for active admin resources using background jobs and action cable"
  s.description = "active_admin_excel_upload gem brings convention over configuration for your excel uploads. This gem is designed to process your excel sheet on a active job and display the results live using action cables"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.add_dependency "coffee-rails"
  s.add_dependency "roo", "~> 2.7.0"
end
