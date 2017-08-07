module ActiveAdminExcelUpload
  class ExcelChannel < ::ApplicationCable::Channel
    def subscribed
      # stream_from "some_channel"
      if ActiveAdminExcelUpload.configuration.use_default_connecion_authentication
        stream_from "excel_channel_#{current_admin_user.id}"
      else
        stream_from "excel_channel_#{self.send(ActiveAdminExcelUpload.configuration.connection_identifier).send(:id)}"
      end
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    def speak
    end
  end
end
