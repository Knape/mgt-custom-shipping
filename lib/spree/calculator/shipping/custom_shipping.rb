module Spree
  class Calculator
    module Shipping
      class CustomShipping < Spree::ShippingCalculator

        preference :with_frame,     :integer,  default: 0
        preference :without_frame,  :integer,  default: 0
        preference :many_posters,   :integer,  default: 0
        preference :split_base,     :integer,  default: 0
        preference :split,          :integer,  default: 0

        def self.description
          'MGT'
        end

        # As order_or_line_items we always get line items, as calculable we have
        # Coupon, ShippingMethod or ShippingRate.
        def compute_package(package)

          line_items = package.order.line_items
          
          puts 'package'

          split = preferred_split_base
          cost = 0
          poster_count = 0

          if  (line_items.length >= 2)
            split = self.preferred_split
          end

          line_items.each do |item|
            if (item.variant.sku.length > 4)
              cost = (self.preferred_with_frame / split)
              break
            else
              cost = (self.preferred_without_frame / split)
            end
          end

          line_items.each do |item|

            if (item.variant.sku.length > 4)
              poster_count = 0
              break
            end

            if (item.variant.sku.length <= 4)
              poster_count += item.quantity;
            end
          end

          if (poster_count >= 2)
            cost = self.preferred_many_posters / split
          end

          if (package.order.ship_address.address2.include? "pickup: true")
            cost = 0
          end

          return cost
        end

      end
    end
  end
end
