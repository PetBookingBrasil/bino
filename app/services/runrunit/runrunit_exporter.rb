module Runrunit
  class RunrunitExporter
    def initialize(ticket)
      @ticket = ticket
    end

    def post(formatted_objects)
      formatted_objects.each do |obj|
        body = { task: obj }
        resource = 'api/v1.0/tasks'
        response = Runrunit::Resources.new().perform_request(body: body, resource: resource, method: :post)
        Package.find_by(source_id: obj.id).update(destiny_id: response.id)
      end
    end

  end
end
