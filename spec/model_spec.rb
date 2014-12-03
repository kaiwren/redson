require "spec_helper"

describe Redson::Model do
  let(:model) { Redson::Model.new }
  
  it "knows how to prase keys from Rails style nested name attribute strings" do
    to_keys = model.parse_keys("student[name][age]")
    expect(to_keys).to eq(["student", "name", "age"])
  end
  
  context "api calls" do
    it "append .json to api_paths that don't have it to keep Rails happy because Content-Type set by jquery-opal is insufficient" do
      model.api_path = "/api"
      expect(model.api_path).to eq("/api.json")
    end
    
    it "leaves api_path that ends with .json unmodified" do
      model.api_path = "/api.json"
      expect(model.api_path).to eq("/api.json")
    end
    
    it "raises a ModelApiPathNotSetError if a save is triggered without an api_path" do
      expect {
        model.save
      }.to raise_error(Redson::Error::ModelApiPathNotSetError)
    end
    
    it "does not raise an error if a save is triggered with an api_path being set" do
      model.api_path = "/api"
      expect {
        model.save
      }.not_to raise_error
    end
  end
  
  context "observers" do
    it "are notified when an event they have registered for is raised" do
      
    end
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
