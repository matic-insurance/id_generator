module IdGenerator
  class Config
    class Error < StandardError
    end

    class << self
      attr_accessor :project_id
    end
  end
end
