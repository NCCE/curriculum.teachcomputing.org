class ActiveStorage::BlobsController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob
  after_action :track_download

  def show
    expires_in ActiveStorage.service_urls_expire_in
    redirect_to @blob.service_url(disposition: params[:disposition])
  end

  private

    def track_download
      attachment = @blob.attachments.first
      AggregateDownload.increment_attachment_download(attachment)
    end
end
