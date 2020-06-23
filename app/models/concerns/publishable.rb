module Publishable
  extend ActiveSupport::Concern

  included do
    attr_accessor :publish
    belongs_to :state, dependent: :destroy
    scope :published, -> { joins(:state).where('states.state = ?', State.states[:published]) }

    after_initialize :create_state
    after_save :set_published

    delegate :published?, :published!, :unpublished!, to: :state
  end

  private

    def create_state
      self.state = State.new unless state.present?
    end

    def set_published
      return if publish.nil?

      if publish == true
        published!
      else
        unpublished!
      end
    end
end
