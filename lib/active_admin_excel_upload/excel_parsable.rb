module ActiveAdminExcelUpload
  module ExcelParsable
    extend ActiveSupport::Concern

    class_methods do
      def excel_create_record(row, index, header,channel_name)
        ActionCable.server.broadcast channel_name, message: "processing for #{row}"
        object = Hash[header.zip row]
        record = self.new(object)
        if record.save
          ActionCable.server.broadcast channel_name, message: "Successfully cureated record for #{row}, id: #{record.id}"
        else
          ActionCable.server.broadcast channel_name, message: "Could not create record for #{row}, error: #{record.errors.messages}"
        end
      end
      def process_sheet(sheet,current_admin_user)
        xlsx = Roo::Spreadsheet.open(sheet)
        sheet = xlsx.sheet(xlsx.sheets.index(self.table_name))
        header = sheet.row(1)
        channel_name = "excel_channel_#{current_admin_user.id}"
        header_downcase = header.map(&:parameterize).map(&:underscore)
        ActionCable.server.broadcast channel_name, message: "Start processing sheet #{self.table_name}"
        sheet.parse.each_with_index do |row, index|
          begin
            self.excel_create_record(row,index,header_downcase,channel_name)
          rescue StandardError => e
            ActionCable.server.broadcast channel_name, message: "Exception while processing #{row}, Exception: #{e.message}"
          end
        end
        ActionCable.server.broadcast channel_name, message: "End processing sheet #{self.table_name}"
      end
    end
  end
end
