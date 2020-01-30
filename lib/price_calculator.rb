class PriceCalculator
  # List of our individual pricing rules
  TAX           = ->(val) { val + val*0.05 }
  FEE           = ->(val) { val + 1 }
  PREMIUM       = ->(val) { val + 10 }
  DISCOUNT      = ->(val) { val * 0.90 }
  ROUND_TO_CENT = ->(val) { val.round(2) }
  # One presenter
  PRESENT       = ->(val) { val.to_f }

  # Pre-define some rule sets for some pricing scenarios
  REGULAR_SET    = [FEE, TAX, ROUND_TO_CENT, PRESENT]
  PREMIUM_SET    = [FEE, PREMIUM, TAX, ROUND_TO_CENT, PRESENT]
  DISCOUNTED_SET = [FEE, DISCOUNT, TAX, ROUND_TO_CENT, PRESENT]

  def self.apply_rules(rules:, base_price:)
    self.const_get(rules).inject(:>>).call(base_price)
  end

end