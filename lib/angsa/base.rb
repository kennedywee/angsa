# frozen_string_literal: true

require_relative 'pagination'
require_relative 'sorting'
require_relative 'searching'

module Angsa
  class Base
    include Pagination
    include Sorting
    include Searching

    attr_reader :params, :model
    def initialize(params, model)
      @params = params
      @model = model
    end

    def columns
      raise NotImplementedError, 'columns is not implemented in derived class'
    end

    def associations
      columns.map { |column| column[:source].to_s.split('.').first if column[:source].to_s.include?('.') }.compact.uniq
    end

    def data_model
      records = model.all
      records = records.includes(*associations) if associations.any?
      apply_search(records, params)
    end
    
    def data
      records = data_model
      records = apply_sorting(records, params)
      records = apply_pagination(records, params)
      extract_records(records)
    end
    
    def extract_records(records)
      records.map do |record|
        columns.map do |column|
          source = column[:source].split('.')
          [column[:name], source.size == 1 ? record.send(source.first) : record.send(source.first).send(source.last)]
        end.to_h
      end
    end

    def as_json(*)
      {
        total: total_count,
        data: data,
      }
    end

    def total_count
      data_model.count
    end

    def print_columns
      puts columns
    end
  end
end

