module ActiveAdminExcelUpload
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates ActiveAdminExcelUpload initializer for your application"

      def copy_initializer
        template "active_admin_excel_uplaod_initializer.rb", "config/initializers/active_admin_excel_uplaod.rb"

        puts "Install complete! Truly Outrageous!"
      end
    end
  end
end
