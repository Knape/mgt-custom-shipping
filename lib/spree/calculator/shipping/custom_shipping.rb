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

          puts line_items.inspect

          cost = 0
          frames = 0

          line_items.each do |item|
            if (item.variant.sku.length > 4)
              cost = (self.preferred_with_frame / 2)
              break
            else
              cost = (self.preferred_without_frame / 2)
            end
          end

          puts package.order.ship_address.inspect

          line_items.each do |item|
            puts ''
            puts item.inspect
            puts ''
            puts ''

            if (item.variant.sku.length <= 4)
              frames +=item.quantity;
            end
          end

          if (frames >= 2)
            cost = 0
          end

          if (package.order.ship_address.address2.include? "pickup: true")
            cost = 0
          end
          puts ''
          puts ''
          puts ''

          cost.to_f
        end

      end
    end
  end
end
