ActiveAdminExcelUpload.configure do |config|
  config.use_default_connecion_authentication = true
  config.connection_identifier = :current_admin_user
end
