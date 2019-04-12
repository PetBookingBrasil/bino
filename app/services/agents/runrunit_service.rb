module Agents
  class RunrunitService
    API_BASE_URL='api/v1.0/'

    def self.post(formatted_objects, destiny_type)
      formatted_objects.each do |obj|
        body = { task: obj[:body] }
        resource = API_BASE_URL + destiny_type

        # Uncomment these 3 lines below
        response = Resources::Runrunit.new.perform_request(body: body, resource: resource, method: :post)
        BinoPackage.find_by(external_source_id: obj[:id])
                   .update(external_destiny_id: JSON.parse(response)["id"], status: :sent)
      end
    end
  end
end
