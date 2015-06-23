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

          puts package.inspect

          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'
          puts 'end this package once'

          line_items = package.order.line_items
          # total_price, total_weight, shipping = compute_total_price, compute_total_weight, 0

          cost = 0
          puts cost
          puts 'first'

          line_items.each do |item|
            if (item.variant.sku.length > 4)
              cost = self.preferred_with_frame
              puts cost
              puts 'if frame'
            else
              cost = self.preferred_without_frame
              puts cost
              puts 'in withoutframe'
            end
          end

          if (package.order.ship_address.address2.include? "pickup: true")
            cost = 0
            puts 'if free shipping'
          end

          puts cost
          puts 'end'
          cost.to_f
        end

        def compute_from_price(package)
          
        end

      end
    end
  end
end
