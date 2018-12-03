class MerchantTotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
    attributes :total_revenue do |object|
      (object.total_revenue.to_i/100.00).to_s
    end

end
