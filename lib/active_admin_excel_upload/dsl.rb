module ActiveAdminExcelUpload
  module DSL
    def excel_importable
      action_item :only => :index do
          link_to 'Upload Excel', :action => 'upload_excel'
      end

      collection_action :upload_excel do
        render "admin/excel/upload_excel"
      end
      collection_action :excel_upload_result do
        render "admin/excel/excel_result"
      end
      collection_action :import_excel, :method => :post do
        final_path = ActiveAdminExcelUpload.move_file_to_rails_tmp(params)
        ExcelParserJob.perform_later(self.resource_class.to_s,final_path.to_s,self.send(ActiveAdmin.application.current_user_method))
        redirect_to :action => :excel_upload_result,:model => self.resource_class.to_s
      end
    end
  end
end
