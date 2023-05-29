class <%= model_class_name %> < Angsa::Base
  def initialize(params)
    super(params, <%= model_name %>)
  end

  def columns
    [
      # TODO: Declare your columns here with the provided params
      # { name: :id, source: 'id', searchable: false, type: :integer },
      # { name: :name, source: 'name', searchable: true, type: :string },
      # { name: :available, source: 'available', searchable: true, type: :boolean },

      # Actions: Important! Declare either id or slug
      # { name: :id, source: 'id', searchable: false, type: :integer },
      # { name: :slug, source: 'slug', searchable: false, type: :integer },
    ]
  end
end