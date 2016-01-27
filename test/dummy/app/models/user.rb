class User < ActiveRecord::Base

  validate :valid_search_combo
  
  def valid_search_combo
    validates_with ValidatesCombo, {
      attributes: attributes.keys,
      allow: [
        {require_all: [:last_name]},
        {require_all: [:shoe_size], require_other: true},
        {require_all: [:first_name, :height]},
        {require_only: [:eye_color, :height]},
        {require_all: [:height, :weight], prohibit: [:hair_color, :eye_color]}
      ]
    }
  end
end
