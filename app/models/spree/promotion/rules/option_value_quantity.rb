module Spree
  class Promotion
    module Rules
      class OptionValueQuantity < Spree::PromotionRule
        QUANTITY_COMPARISONS = %w(== < <= > >=)
        preference :eligible_value, :string
        preference :quantity, default: 1
        preference :quantity_comparison, default: QUANTITY_COMPARISONS.first

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(promotable, _options = {})
          num_actionable = promotable.line_items.map { |item| actionable?(item) }.count { |r| r }
          valid_num_actionable? num_actionable
        end

        def actionable?(line_item)
          eligible_value_as_i = preferred_eligible_value.to_i
          line_item.variant.option_values.any? { |value| eligible_value_as_i == value.id }
        end

        private

        def valid_num_actionable?(num_actionable)
          num_actionable.send preferred_quantity_comparison, preferred_quantity.to_i
        end

      end
    end
  end
end