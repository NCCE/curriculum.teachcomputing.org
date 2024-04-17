module Types
  class AttachableType < Types::BaseUnion
    possible_types Types::KeyStageType

    def self.resolve_type(object, _context)
      case object
      when KeyStage
        Types::KeyStageType
      else
        raise "Unexpected Attachable Type: #{object.class}"
      end
    end
  end
end
