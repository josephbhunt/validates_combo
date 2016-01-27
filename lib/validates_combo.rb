module ActiveModel
  module Validations
    class ValidatesCombo < ActiveModel::Validator
      attr_accessor :record

      DEFAULTS = {
        attributes: [],      #required
        message: "is not valid"
      }

      COMBO_DEFAULTS = {require_all: [], require_only: [], require_other: false, prohibit: []}

      def validate(record)
        @record = record
        opts = DEFAULTS.merge(options)
        opts[:attributes] = opts[:attributes].map(&:to_sym)

        if opts[:allow].map {|combo| 
          combo = COMBO_DEFAULTS.merge(combo)
          combo[:require_all] = combo[:require_all].map(&:to_sym)
          combo[:require_only] = combo[:require_only].map(&:to_sym)
          combo[:prohibit] = combo[:prohibit].map(&:to_sym)
          valid_combo?(combo, opts[:attributes])
        }.exclude?(true)
          @record.errors[:parameter_combination] << "[#{present_params(opts[:attributes]).join(', ')}] #{opts[:message]}."
        end
      end

      def valid_combo?(combo, attributes)
        valid_combo = has_required_all?(combo[:require_all]) &&
        has_require_only?(combo[:require_only], attributes) &&
        has_required_other?(combo, attributes) &&
        excludes_prohibited?(combo[:prohibit])
      end

      def present_params(searchable)
        searchable.select{|attribute| @record.send(attribute).present?}
      end

      def has_required_all?(require_all)
        return true if require_all.blank?
        require_all.map{|attribute| @record.send(attribute).present?}.uniq == [true]
      end

      def has_require_only?(require_only, attributes)
        return true if require_only.blank?
        attributes.select{|attribute| @record.send(attribute).present?} == require_only
      end

      def has_required_other?(combo, attributes)
        return true unless combo[:require_other]
        (attributes - combo[:require_all] - combo[:prohibit]).map{|attribute| @record.send(attribute).present?}.any?
      end

      def excludes_prohibited?(prohibited)
        return true if prohibited.blank?
        prohibited.map{|attribute| @record.send(attribute).present?}.uniq == [false]
      end
    end
  end
end
