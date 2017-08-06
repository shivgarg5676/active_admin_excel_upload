module ActiveAdminExcelUpload
  class Railtie < Rails::Railtie
    initializer "active_admin_excel_upload_railtie.configure_rails_initialization" do
      ActiveAdmin::DSL.send(:include, ActiveAdminExcelUpload::DSL)
      ApplicationCable::Connection.send(:include, ActiveAdminExcelUpload::Authenticable)
      ActiveRecord::Base.send(:include, ActiveAdminExcelUpload::ExcelParsable)
    end
  end
end
