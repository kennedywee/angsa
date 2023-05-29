module Angsa
  module Sorting
    def apply_sorting(records, params)
      if params[:order] && params[:dir]
        sort = columns.find { |column| column[:name].to_s == params[:order] }
        if sort
          if sort[:source].include?('.')
            # This is an attribute of an associated model
            association, attribute = sort[:source].split('.')
            records = records.joins(association.to_sym).order("#{association.pluralize}.#{attribute} #{params[:dir]}")
          else
            # This is an attribute of the Course model
            records = records.order("#{sort[:source]} #{params[:dir]}")
          end
        end
      end
      records
    end
  end
end