class Bino

  def initialize(source, destiny, source_type, destiny_type, object_id = nil)
    @source = source
    @destiny = destiny
    @source_type = source_type
    @destiny_type = destiny_type
    @object_id = object_id
  end

  def send
    # Assumindo que o source e o destiny são classes instanciadas (Service / Agent)
    formatted_source_objects = @source.get(object_id, source_type, destiny_type)

    @destiny.post(formatted_source_objects)
  end

end
