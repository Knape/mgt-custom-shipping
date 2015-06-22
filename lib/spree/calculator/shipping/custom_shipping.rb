module Spree
  class Calculator
    module Shipping
      class CustomShipping < Spree::ShippingCalculator

        preference :with_frame,        :decimal,  default: 0
        preference :without_frame,     :decimal,  default: 0
        # preference :max_item_weight, :decimal, default: 18
        # preference :max_item_width,  :decimal, default: 60
        # preference :max_item_length, :decimal, default: 120
        # preference :max_price,       :decimal, default: 120
        # preference :handling_max,    :decimal, default: 50
        # preference :handling_fee,    :decimal, default: 10
        # preference :default_weight,  :decimal, default: 1

        class << self
          def description
            Spree.t(:custom_shipping)
          end

          def register
            super
          end
        end

        # def item_oversized?(variant)
        #   sizes = [
        #     variant.width  ? variant.width  : 0,
        #     variant.depth  ? variant.depth  : 0,
        #     variant.height ? variant.height : 0
        #   ].sort.reverse

        #   return true if sizes[0] > preferred_max_item_length # Longest side.
        #   return true if sizes[1] > preferred_max_item_width  # Second longest side.
        #   false
        # end

        # Determine if weight or size goes over bounds.
        # def available?(package)
        #   package.order.variants.each do |variant|
        #     return false if item_within_bounds?(variant.weight) # 18
        #     return false if item_oversized?(variant)
        #   end
        #   true
        # end

        # As order_or_line_items we always get line items, as calculable we have
        # Coupon, ShippingMethod or ShippingRate.
        def compute_package(package)

          line_items = package.order.line_items
          # total_price, total_weight, shipping = compute_total_price, compute_total_weight, 0

          test = 0

          line_items.each do |item|
            if (item.variant.sku.length > 4)
              test = with_frame
            else
              test = without_frame
            end
          end

          if (package.order.ship_address.address2.include? "pickup: true")
            test = 0
          end

          return test

          # [shipping, prices[compute_index(total_weight)], handling_fee(total_price)].compact.sum
        end

        # private

        # def compute_total_weight
        #   line_items.map do |item|
        #     weight = item.variant.weight > 0 ? item.variant.weight : preferred_default_weight
        #     item.quantity * weight
        #   end.reduce(:+)
        # end

        # def compute_total_price
        #   line_items.map { |item| item.price * item.quantity }.reduce(:+)
        # end

        # def compute_index(total_weight)
        #   index = weights.length - 2
        #   while index >= 0
        #     break if total_weight > weights[index]
        #     index -= 1
        #   end
        #   index + 1
        # end

        # def item_within_bounds?(weight)
        #   weight && weight > preferred_max_item_weight
        # end

        # def handling_fee(total_price)
        #   preferred_handling_max < total_price ? 0 : preferred_handling_fee
        # end

        # def prices
        #   @prices ||= preferred_price_table.split.map(&:to_f)
        # end

        # def weights
        #   @weights ||= preferred_weight_table.split.map(&:to_f)
        # end
      end
    end
  end
end
