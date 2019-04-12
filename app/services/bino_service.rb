# frozen_string_literal: true

# This is the main class of Bino Service, responsible for transport
# packages from source and transport to destiny
class BinoService
  SOURCE_TYPES = [:ticket].freeze
  DESTINY_TYPES = [:cards].freeze
  ALLOWED_AGENTS = %i[Runrunit Zendesk].freeze

  def initialize(source, destiny, source_type, destiny_type, object_id = nil)
    @source = source
    @destiny = destiny
    @source_type = source_type
    @destiny_type = destiny_type
    @object_id = object_id
  end

  def transport
    raise 'Rejected type' unless valid_source_and_destiny_type?
    raise 'Invalid Agent' unless valid_agents?

    source_class = "Agents::#{@source.capitalize}Service".constantize
    destiny_class = "Agents::#{@destiny.capitalize}Service".constantize
    formatted_source_objects = source_class.get(@destiny, @object_id,
                                                @source_type, @destiny_type)
    return unless formatted_source_objects.present?

    destiny_class.post([formatted_source_objects.first], @destiny_type)
  end

  private

  def valid_source_and_destiny_type?
    SOURCE_TYPES.include?(@source_type) &&
      DESTINY_TYPES.include?(@destiny_type)
  end

  def valid_agents?
    ALLOWED_AGENTS.include?(@source) &&
      ALLOWED_AGENTS.include?(@destiny)
  end
end
