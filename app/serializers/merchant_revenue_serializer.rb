class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
    attributes :revenue do |object|
      (object.revenue.to_f/100).round(2).to_s
    end

end
