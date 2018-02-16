require "active_admin_excel_upload/engine"
require "activeadmin"
require "active_admin_excel_upload/dsl"
require "active_admin_excel_upload/railtie"
require "active_admin_excel_upload/authenticable"
require "active_admin_excel_upload/excel_parsable"
require "roo"
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


  # find a better place for this method
  def self.move_file_to_rails_tmp(params)
    file_name = DateTime.now.to_s + params[:dump][:file].original_filename
    tmp = params[:dump][:file].tempfile
    final_path = Rails.root.join('tmp', file_name)
    FileUtils.move tmp.path, final_path
    return final_path
  end
end
