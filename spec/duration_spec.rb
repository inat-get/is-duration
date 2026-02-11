require_relative 'spec_helper'

RSpec::describe IS::Duration do

  it 'parse' do
    expect(IS::Duration::parse '1m 10s').to eq(70)
    expect(IS::Duration::parse '1m 10s 500ms').to eq(70.5)
    expect(IS::Duration::parse '0.4').to eq(0.4)
    expect(IS::Duration::parse('12').class).to eq(Integer)
    expect(IS::Duration::parse nil).to eq(nil)
    expect(IS::Duration::parse 1.5).to eq(1.5)
    expect(IS::Duration::parse(123).class).to eq(Integer)
    v = IS::Duration::parse 1/5r
    expect(v).to eq(0.2)
    expect(v.class).to eq(Float)
  end

  it 'format' do
    expect(IS::Duration::format 1000).to eq('16m40s')
    expect(IS::Duration::format 1000, delim: ' ').to eq('16m 40s')
    expect(IS::Duration::format 1000000).to eq('11d13h46m40s')
    expect(IS::Duration::format 1000000, units: (:s .. :w)).to eq('1w4d13h46m40s')
    expect(IS::Duration::format 1, units: (:ms .. :s), empty: :minor, zeros: :fill).to eq('01s000ms')
    expect(IS::Duration::format 1, units: (:ns..:ns)).to eq("1000000000ns")
    expect(IS::Duration::format -5555, minus: lambda { |v| "{#{v}}" }).to eq('{1h32m35s}')
  end

end
