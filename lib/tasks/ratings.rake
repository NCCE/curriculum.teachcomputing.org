namespace :ratings do
  desc "Clears ratings with no stem achiever number and resets aggregate rating
  totals"
  task tidy: :environment do
    AggregateRating.all.each do |ar|
      ar.ratings.where(user_stem_achiever_contact_no: nil).delete_all

      ar.with_lock do
        positive_total = ar.ratings.where(positive: true).count
        negative_total = ar.ratings.where(positive: false).count

        ar.update_attributes(total_negative: negative_total, total_positive: positive_total)
      end
    end
  end
end
