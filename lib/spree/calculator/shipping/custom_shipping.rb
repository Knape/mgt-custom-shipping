module Spree
  class Calculator
    module Shipping
      class CustomShipping < Spree::ShippingCalculator

        preference :with_frame,        :decimal,  default: 0
        preference :without_frame,     :decimal,  default: 0

        def self.description
          'MGT'
        end

       

        # As order_or_line_items we always get line items, as calculable we have
        # Coupon, ShippingMethod or ShippingRate.
        def compute_package(package)

          line_items = package.order.line_items
          # total_price, total_weight, shipping = compute_total_price, compute_total_weight, 0

          total = 0

          line_items.each do |item|
            if (item.variant.sku.length > 4)
              total = self.preferred_with_frame
            else
              test = self.preferred_without_frame
            end
          end

          if (package.order.ship_address.address2.include? "pickup: true")
            total = 0
          end

          total

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
