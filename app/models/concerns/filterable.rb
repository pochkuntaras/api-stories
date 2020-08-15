module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(params)
      params.to_unsafe_h.inject(all) do |result, (key, value)|
        next result unless respond_to?(key)

        if value.try(:true?) || value.equal?(true)
          result.public_send(key)
        else
          return result if value.blank? || value.try(:false?)
          result.public_send(key, value)
        end
      end
    end
  end
end
