require 'spec_helper'

RSpec.define Redson::Widget do
  it "foo" do
    Redson::Widget.new(nil, nil).render
  end
end