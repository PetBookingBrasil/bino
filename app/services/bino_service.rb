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

    objects_to_send = get_objects_from_source
    return unless objects_to_send.present?
    create_packages_for_objects(objects_to_send)
    post_objects_for_destiny(objects_to_send)
  end

  private

  def get_objects_from_source
    source_class = "Agents::#{@source.capitalize}Service".constantize.new(
      destiny: @destiny,
      object_id: @object_id,
      source_type: @source_type,
      destiny_type: @destiny_type)
    source_class.get
  end

  def post_objects_for_destiny(objects_to_send)
    destiny_class = "Agents::#{@destiny.capitalize}Service".constantize.new(
      formatted_objects: objects_to_send.first,
      destiny_type: @destiny_type)
    destiny_class.post
  end

  def create_packages_for_objects(objects_to_send)
    objects_to_send.each do |t|
      BinoPackage.create(source: @source,
                         destiny: @destiny,
                         external_source_id: t.id,
                         package_type: @destiny_type,
                         status: :waiting)
    end
  end

  def valid_source_and_destiny_type?
    SOURCE_TYPES.include?(@source_type.to_sym) &&
      DESTINY_TYPES.include?(@destiny_type.to_sym)
  end

  def valid_agents?
    ALLOWED_AGENTS.include?(@source) &&
      ALLOWED_AGENTS.include?(@destiny)
  end
end
