# frozen_string_literal: true

module Agents
  class RunrunitService
    API_BASE_URL = 'api/v1.0/'

    def post_item(body)
      Resources::Runrunit.new.perform_request(
        body: {task: body[:body]},
        resource: (API_BASE_URL + @destiny_type), method: :post)
    end
  end
end
