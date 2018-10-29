module IdGenerator
  class Configuration
    attr_reader :context_id

    def initialize(context_id: 0)
      self.context_id = context_id
    end

    def context_id=(context_id)
      raise(IdGenerator::Errors::InvalidContextId, 'Invalid context id') unless context_id_valid?(context_id)

      @context_id = context_id
    end

    protected

    def context_id_valid?(context_id)
      return false unless context_id.is_a?(Integer)
      return false unless context_id.between?(0, 255)

      true
    end
  end
end
