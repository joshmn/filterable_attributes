require 'spec_helper'

RSpec.describe FilterableAttributes do
  result = UserSerializer.new(nil).as_json

  result.keys.each do |key|
    if key.to_s.start_with?("unfiltered")
      it "#{key} should not be filtered #{key}" do
        expect(key.to_s).to eq(result[key])
      end
    else
      it "#{key} should be filtered" do
        expect(key).to_not eq(result[key])
      end
    end
  end
end
