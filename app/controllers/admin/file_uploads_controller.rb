module Admin
  class FileUploadsController < Admin::ApplicationController
    def destroy
      requested_resource = FileUpload.find(params[:id])
      requested_resource.destroy!
      redirect_back(fallback_location: requested_resource)
    end
  end
end
