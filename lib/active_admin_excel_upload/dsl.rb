module ActiveAdminExcelUpload
  module DSL
    def excel_importable
      action_item :only => :index do
          link_to 'Upload Excel', :action => 'upload_csv'
      end

      collection_action :upload_csv do
        render "admin/csv/upload_excel"
      end
      collection_action :show_excel_upload_result do
        render "admin/csv/excel_result"
      end

      collection_action :import_excel, :method => :post do
        file_name = DateTime.now.to_s + params[:dump][:file].original_filename
        tmp = params[:dump][:file].tempfile
        final_path = Rails.root.join('tmp', file_name)
        FileUtils.move tmp.path, final_path
        ExcelParserJob.perform_later(self.resource_class.to_s,final_path.to_s,self.send(ActiveAdmin.application.current_user_method))
        redirect_to :action => :show_excel_upload_result, :notice => "CSV imported successfully!"
      end
    end
  end
end
