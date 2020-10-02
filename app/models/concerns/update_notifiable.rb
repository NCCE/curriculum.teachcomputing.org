module UpdateNotifiable
  extend ActiveSupport::Concern

  included do
    after_commit :notify_update
  end

  private

    def notify_update
      UpdateNotifier.new(self).run
    end
end
