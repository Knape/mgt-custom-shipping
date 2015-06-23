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
          
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'
          puts 'run this package once'

          compute_from_price(total(package))

        end

        def compute_from_price(package)
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

          return total
        end

      end
    end
  end
end
