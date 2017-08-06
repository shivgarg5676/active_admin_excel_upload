module ActiveAdminExcelUpload
  module ExcelParsable
    extend ActiveSupport::Concern

    class_methods do
      def excel_create_record(row, index, header)
        ActionCable.server.broadcast "excel_channel_#{current_admin_user.id}", message: "processing for #{row}"
        object = Hash[header_downcase.zip row]
        record = self.new(object)
        if record.save
          ActionCable.server.broadcast "excel_channel_#{current_admin_user.id}", message: "Successfully cureated record for #{row}, id: #{record.id}"
        else
          ActionCable.server.broadcast "excel_channel_#{current_admin_user.id}", message: "Could not create record for #{row}, error: #{record.errors}"
        end
      end
      def process_sheet(sheet,current_admin_user)
        xlsx = Roo::Spreadsheet.open(sheet)
        sheet = xlsx.sheet(xlsx.sheets.index(self.table_name))
        header = sheet.row(1)
        header_downcase = header.map(&:parameterize).map(&:underscore)
        ActionCable.server.broadcast "excel_channel_#{current_admin_user.id}", message: "Start processing sheet #{self.table_name}"
        sheet.parse.each_with_index do |row, index|
          begin
            excel_create_record(row,index,header)
          rescue StandardError => e
            ActionCable.server.broadcast "excel_channel_#{current_admin_user.id}", message: "Exception while processing #{row}, Exception: #{e.message}"
          end
        end
      end
    end
  end
end
