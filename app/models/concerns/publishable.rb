module Publishable
  extend ActiveSupport::Concern

  included do
    belongs_to :state, dependent: :destroy

    after_initialize :create_state

    scope :published, -> { joins(:state).where('states.state = ?', State.states[:published]) }

    delegate :published?, :published!, :unpublished!, to: :state
  end

  private

    def create_state
      self.state = State.new unless state.present?
    end
end
