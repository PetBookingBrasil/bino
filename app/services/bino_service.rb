# frozen_string_literal: true

# This is the main class of Bino Service, responsible for transport
# packages from source and transport to destiny
class BinoService
  SOURCE_TYPES = [:ticket].freeze
  DESTINY_TYPES = [:tasks].freeze
  ALLOWED_AGENTS = %i[Runrunit Zendesk].freeze

  def initialize(source, destiny, source_type, destiny_type, object_id = nil)
    @source = source
    @destiny = destiny
    @source_type = source_type
    @destiny_type = destiny_type
    @object_id = object_id
  end

  def transport
    raise 'Invalid type for source or destiny' unless valid_source_and_destiny_type?
    raise 'Invalid Agent for destiny or source' unless valid_agents?

    puts "Starting transportation from #{@source} (#{@source_type}) to #{@destiny} (#{@destiny_type})."
    objects_to_send = get_objects_from_source
    return puts 'No data to transport' unless objects_to_send.present?
    create_packages_for_objects(objects_to_send)
    post_objects_for_destiny(objects_to_send)
  end

  private

  def get_objects_from_source
    puts "Loading objects from #{@source}"
    "Agents::#{@source.capitalize}Service".constantize.new(
      destiny: @destiny,
      object_id: @object_id,
      source_type: @source_type,
      destiny_type: @destiny_type).get
  end

  def post_objects_for_destiny(objects_to_send)
    puts "Posting #{objects_to_send.size} objects to #{@destiny}"
    "Agents::#{@destiny.capitalize}Service".constantize.new(
      formatted_objects: objects_to_send,
      destiny_type: @destiny_type).post
  end

  def create_packages_for_objects(objects_to_send)
    puts "Creating my packages..."
    objects_to_send.each do |t|
      package_params = {
        source: @source,
        destiny: @destiny,
        external_source_id: t[:id],
        package_type: @destiny_type,
        status: :waiting
      }
      existent_package = BinoPackage.find_by(package_params.except(:status))
      BinoPackage.create(package_params) unless existent_package
    end
  end

  def valid_source_and_destiny_type?
    SOURCE_TYPES.include?(@source_type.to_sym) &&
      DESTINY_TYPES.include?(@destiny_type.to_sym)
  end

  def valid_agents?
    ALLOWED_AGENTS.include?(@source.to_sym) &&
      ALLOWED_AGENTS.include?(@destiny.to_sym)
  end
end
