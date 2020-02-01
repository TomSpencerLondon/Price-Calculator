# typed: false
require './lib/price_calculator'

RSpec.describe PriceCalculator do
  let(:subject) do
    described_class
  end

  let(:amount) do
    BigDecimal(100)
  end

  it 'calculates regular fees' do
    expect(subject.apply_rules(rules: 'REGULAR_SET', base_price: amount)).to eq 106.05
  end
end