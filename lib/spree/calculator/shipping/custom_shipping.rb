module Spree
  class Calculator
    module Shipping
      class CustomShipping < Spree::ShippingCalculator

        preference :with_frame,        :decimal,  default: 0
        preference :without_frame,     :decimal,  default: 0
        preference :many_posters,     :decimal,  default: 0

        def self.description
          'MGT'
        end

        # As order_or_line_items we always get line items, as calculable we have
        # Coupon, ShippingMethod or ShippingRate.
        def compute_package(package)

          line_items = package.order.line_items
          
          cost = 0
          poster_count = 0

          line_items.each do |item|
            if (item.variant.sku.length > 4)
              cost = (self.preferred_with_frame / 2)
              break
            else
              cost = (self.preferred_without_frame / 2)
            end
          end

          line_items.each do |item|

            if (item.variant.sku.length > 4)
              poster_count = 0
              break


            if (item.variant.sku.length <= 4)
              poster_count += item.quantity;
            end
          end

          if (poster_count >= 2)
            cost = self.preferred_many_posters / 2
          end

          if (package.order.ship_address.address2.include? "pickup: true")
            cost = 0
          end

          cost.to_f
        end

      end
    end
  end
end
