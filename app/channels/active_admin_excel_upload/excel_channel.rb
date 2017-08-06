module ActiveAdminExcelUpload
  class ExcelChannel < ApplicationCable::Channel
    def subscribed
      # stream_from "some_channel"
      stream_from "excel_channel_#{current_admin_user.id}"
      # stream_from :excel_channel
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    def speak
    end
  end
end
