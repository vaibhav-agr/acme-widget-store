class DeliveryCharge
  def initialize(rules)
    # sort in reverse order
    # rule hash { min_amount: 50.0, charge: 2.95 }
    @rules = rules.sort_by { |rule| -rule[:min_amount] }
  end

  def calculate(total)
    applicable_rule = @rules.find { |rule| total >= rule[:min_amount] }
    applicable_rule[:charge]
  end
end
