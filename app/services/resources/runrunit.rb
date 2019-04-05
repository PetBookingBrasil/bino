require 'rest-client'
class Resources::Runrunit

  def self.perform_request(body:, resource:, method:)
    resource_url = "#{ENV['RUNRUNIT_URL']}/#{resource}"

    headers = { 'App-key': ENV['RUNRUNIT_API_KEY'], 'User-Token': ENV['RUNRUNIT_USER_TOKEN'],
                'Content-Type': 'application/json', Host: ENV['HOST'] }.as_json
    request = RestClient::Request.new(method: method, url: resource_url, payload: body, headers: headers)

    begin
      response = request.execute
      return response.body
    rescue RestClient::RequestTimeout
      raise Errno::ETIMEDOUT
    rescue RestClient::ExceptionWithResponse => e
      return e.http_body
    end

  end

end
