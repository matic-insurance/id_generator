module IdGenerator
  class Configuration
    attr_accessor :context_id

    def initialize(context_id: 0)
      @context_id = context_id
    end
  end
end