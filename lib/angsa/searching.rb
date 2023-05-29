module Angsa
  module Searching
    def apply_search(records, params)
      return records unless params[:search]
    
      conditions, values, associations = build_search_conditions_values_and_associations(columns, records, params)
  
      associations.each do |association|
        records = records.joins(association.to_sym)
      end
  
      records.where(conditions.join(' OR '), values)
    end

    def build_search_conditions_values_and_associations(columns, records, params)
      conditions = []
      values = {}
      associations = []
    
      columns.each do |column|
        next unless column[:searchable]  # Skip columns that aren't searchable
    
        source_parts = column[:source].split('.')
        if source_parts.size == 1
          # This is an attribute of the Course model
          if column[:type] == :string
            conditions << "LOWER(#{records.all.table_name}.#{source_parts.first}) LIKE :search"
          end
        else
          # This is an attribute of an associated model
          association, attribute = source_parts
          if column[:type] == :string
            conditions << "LOWER(#{association.pluralize}.#{attribute}) LIKE :search"
            associations << association
          end
        end
      end
    
      values[:search] = "%#{params[:search].downcase}%"
      
      return conditions, values, associations.uniq
    end
  end
end