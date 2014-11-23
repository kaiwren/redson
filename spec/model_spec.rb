require "spec_helper"

describe Redson::Model do
  let(:model) { Redson::Model.new }
  
  it "knows how to prase keys from Rails style nested name attribute strings" do
    to_keys = model.parse_keys("student[name][age]")
    expect(to_keys).to eq(["student", "name", "age"])
  end
  
  context "attributes" do
    it "allows an attribute to be written to and read from it" do
      model['age'] = '5'
      expect(model['age']).to eq('5')
    end

    it "allows nested attributes to be written to and read from it" do
      model['student[age]'] = '5'
      expect(model['student']['age']).to eq('5')
    end
  end
end
