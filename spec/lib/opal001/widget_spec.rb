require 'spec_helper'

RSpec.define Opal001::Widget do
  it "foo" do
    Opal001::Widget.new(nil, nil).render
  end
end