# frozen_string_literal: true

module Agents
  class Base
    def initialize(params = {})
      @source = params[:source]
      @destiny = params[:destiny]
      @source_type = params[:source_type]
      @destiny_type = params[:destiny_type]
      @formatted_objects = params[:formatted_objects]
    end

    def post_item
      raise NotImplementedError
    end

    def get
      raise NotImplementedError
    end

    def post
      @formatted_objects.each do |obj|
        response = post_item(task: obj[:body])
        update_package_status(obj[:id], JSON.parse(response)['id'])
      end
    end

    def last_date_for_source_and_package_type(source, package_type)
      BinoPackage.where(source: source, package_type: package_type, status: :sent)
                 .first
                 .try(:updated_at)
                 .try(:strftime, '%Y-%m-%d') || Date.today.try(:strftime, '%Y-%m-%d')
    end

    private

    def update_package_status(external_source_id, external_destiny_id, status = :sent)
      BinoPackage.find_by(external_source_id: external_source_id)
                 .update(external_destiny_id: external_destiny_id, status: status)
    end
  end
end
