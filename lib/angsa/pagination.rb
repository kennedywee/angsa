module Angsa
  module Pagination
    def apply_pagination(records, params)
      limit = params[:limit] || 10
      offset = params[:offset] || 0
      
      records.limit(limit).offset(offset)
    end
  end
end