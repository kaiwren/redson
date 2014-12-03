require "spec_helper"

describe Redson::View do
  class Redson::Spec::SampleViewForSpec < Redson::View
    def initialize
      initialize_observable
    end
  end
  
  let(:div_element) { Element.new('div') }
  let(:view) do
    Redson::SampleViewForSpec.new(
      Redson::Model.new,
      div_element,
      div_element
    )
  end
  
end
