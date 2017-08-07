require "active_admin_excel_upload/engine"
require "activeadmin"
require "active_admin_excel_upload/dsl"
require "active_admin_excel_upload/railtie"
require "active_admin_excel_upload/authenticable"
require "active_admin_excel_upload/excel_parsable"
module ActiveAdminExcelUpload
  class << self
   attr_accessor :configuration
  end

  def self.configure
   self.configuration ||= Configuration.new
   yield(configuration)
   if configuration.use_default_connecion_authentication
     ApplicationCable::Connection.send(:include, ActiveAdminExcelUpload::Authenticable)
   end
  end

  class Configuration
   attr_accessor :use_default_connecion_authentication
   attr_accessor :connection_identifier
   def initialize
     @use_default_connecion_authentication = true
     @connection_identifier = :current_admin_user
   end
  end
end
