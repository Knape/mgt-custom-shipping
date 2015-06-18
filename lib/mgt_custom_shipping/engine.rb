module MgtCustomShipping
  class Engine < Rails::Engine
    isolate_namespace Spree
    engine_name 'mgt_custom_shipping'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer 'spree.register.calculators' do |app|
      require 'spree/calculator/shipping/custom_shipping'
      app.config.spree.calculators.shipping_methods << Spree::Calculator::Shipping::CustomShipping
    end
  end
end
