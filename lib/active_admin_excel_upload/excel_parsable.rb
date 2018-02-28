module ActiveAdminExcelUpload
  module ExcelParsable
    extend ActiveSupport::Concern

    class_methods do
      def publish_to_channel(channel_name,message)
        message = "[#{self.to_s}]#{message}"
        ActionCable.server.broadcast channel_name, message: message
      end

      def excel_create_record(row, index, header,channel_name)
        self.publish_to_channel(channel_name, "processing for #{row}")
        object = Hash[header.zip row]
        record = self.new(object)
        if record.save
          self.publish_to_channel(channel_name,"Successfully created record for #{row}, id: #{record.id}")
        else
          self.publish_to_channel(channel_name,"Could not create record for #{row}, error: #{record.errors.messages}")
        end
      end


      def excel_process_sheet(sheet,current_admin_user)
        xlsx = Roo::Spreadsheet.open(sheet)
        sheet = xlsx.sheet(xlsx.sheets.index(self.table_name))
        header = sheet.row(1)
        channel_name = "excel_channel_#{current_admin_user.id}"
        header_downcase = header.map(&:parameterize).map(&:underscore)
        self.publish_to_channel(channel_name,"Start processing sheet #{self.table_name}")
        sheet.parse.each_with_index do |row, index|
          begin
            self.excel_create_record(row,index,header_downcase,channel_name)
          rescue StandardError => e
            self.publish_to_channel(channel_name,"Exception while processing #{row}, Exception: #{e.message}")
          end
        end
        self.publish_to_channel(channel_name, "End processing sheet #{self.table_name}")
      end
    end
  end
end
