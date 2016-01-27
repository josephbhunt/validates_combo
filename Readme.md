# ValidatesCombo

ValidatesCombo prvides a simple syntax for validating combinations of ActiveRecord attributes. I wrote it as part of a project that had a very complex search form. Due to limitations of other legacy systems I was unable to simplify the database (or change it at all). These limitations forced me to come up with a way of limiting the allowed combinations of search terms, otherwise the whole system would get bogged down as it tried to search millions of rows.

# Usage Example

For example, assume an ActiveRecord User model. Create a custom validation method.
`validate :valid_search_combo`

Use validates_with in that method definition.
```ruby
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
```
You must pass options `attributes` and `allow`. Attributes is the list of attributes that will be validated. It can be all or some of the models attributes. Allow is an array of valid combinations. There is a third optional key `message` used to sutomize the error message, just like all validations.

## Combinations
Valid combinations are expressed as hashes with the following possible options. Each combination will be checked upon validation. ValidatesCombo only checks for the presence of these attributes (i.e. not `blank?`). If the assigned attributes match any of the valid combinations, then the combination is said to be valid. If not, then the error "Parameter combination is not valid." is returned. This error message can be customized.

 * `require_all` An array of attributes that must be present for that combination
 * `require_other` A boolean that requires at least one other attributes to be assigned (not in require_all or prihibit) for that combination. False by default.
 * `require_only` An array of attributes that must be present, and no other attributes may be present for that combination. Effectively the same as a `require_all` with all other attirbutes prohibitied.
 * `prohibit` An array of attributes that must NOT be present for that combination. 
