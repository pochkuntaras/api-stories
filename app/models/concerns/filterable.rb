module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(params)
      params.to_unsafe_h.inject(all) do |result, (key, value)|
        next result if !respond_to?(key) || value.blank?
        result.public_send(key, value)
      end
    end
  end
end
