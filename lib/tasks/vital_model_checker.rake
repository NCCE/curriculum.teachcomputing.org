task vital_model_checker: :environment do
  aggregate_download_count = AggregateDownload.where(updated_at: (Time.now - 12.hours)..Time.now).count

  Sentry.capture_message('No update to AggregateDownload within the last 12 hours. Please check.') if aggregate_download_count == 0

  download_count = Download.where(created_at: (Time.now - 12.hours)..Time.now).count

  Sentry.capture_message('No Downloads recorded within the last 12 hours. Please check.') if download_count == 0

  ratings_count = Rating.where(updated_at: (Time.now - 7.days)..Time.now).count

  Sentry.capture_message('No Ratings recorded within the last 24 hours. Please check.') if ratings_count == 0
end
