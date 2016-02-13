module Game
  class Properties
    def self.bomb_count
      settings['bomb_count']
    end

    def self.rows
      settings['rows']
    end

    def self.columns
      settings['columns']
    end

    def self.boundary
      settings['rows'] - 1
    end

    private

    def self.settings
      @settings ||= YAML.load_file('settings.yml')['level']['easy']
    end
  end
end
