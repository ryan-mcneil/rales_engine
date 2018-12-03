class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
    attributes :revenue do |object|
      (object.revenue/100.00).to_s
    end

end
