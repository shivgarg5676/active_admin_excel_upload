module ActiveAdminExcelUpload
  module Authenticable
    def self.included(base)
      base.send(:identified_by,:current_admin_user)
      base.include(InstanceMethods)
    end
    module InstanceMethods
      def connect
        self.current_admin_user = find_verified_user
      end
      private
        def find_verified_user
          if request.env['warden'].user
            request.env['warden'].user
          else
            reject_unauthorized_connection
          end
        end
    end
  end
end
