class BinoService

  def initialize(source, destiny, source_type, destiny_type, object_id = nil)
    @source = source
    @destiny = destiny
    @source_type = source_type
    @destiny_type = destiny_type
    @object_id = object_id
  end

  def transport
    source_class = "Agents::#{@source.capitalize}Service".constantize
    destiny_class = "Agents::#{@destiny.capitalize}Service".constantize

    formatted_source_objects = source_class.get(@destiny, @object_id, @source_type, @destiny_type)

    if formatted_source_objects.present?
      destiny_class.post(formatted_source_objects, @destiny_type)
    end
  end

end
