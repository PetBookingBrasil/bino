class Agents::RunrunitService
  def self.post(formatted_objects, destiny_type)
    formatted_objects.each do |obj|
      body = { task: obj[:body] }
      resource = 'api/v1.0/tasks'

      # Uncomment these 3 lines below

      # response = Resources::Runrunit.perform_request(body: body, resource: resource, method: :post)
      # BinoPackage.find_by(external_source_id: obj[:id])
                 # .update(external_destiny_id: JSON.parse(response)[:id], status: :sent)
    end
  end
end
