# typed: true
require 'sorbet-runtime'

class PriceCalculator
  extend T::Sig
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

  sig do
   params({
     first_name: String,
     middle_name: T.nilable(String),
     last_name: String,
     age: Integer,
     email_address: T.nilable(String),
     is_email_verified: T::Boolean,

   }).returns(Hash)
  end
  def self.create(first_name:, middle_name:, last_name:, age:, email_address:, is_email_verified:)
    {
      first_name: first_name,
      middle_name: middle_name,
      last_name: last_name,
      email_address: email_address,
      is_email_verified: is_email_verified
    }
  end

  sig {params(x: Integer).returns(String)}
  def bar(x)
    x.to_s
  end
end