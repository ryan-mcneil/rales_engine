class MerchantTotalRevenueSerializer
  include FastJsonapi::ObjectSerializer
    attributes :total_revenue do |object|
      (object.total_revenue.to_f/100).round(2).to_s
    end

end
