require "spec_helper"

describe Redson::Observable do
  class Redson::Spec::SampleObservable
    include Redson::Observable
    
    def initialize
      initialize_observable
    end
  end
  
  class Redson::Spec::SampleObserver
    def observable_updated_handler(event)
      Kernel.raise "observable_updated_handler called"
    end
    
    def sample_observable_updated_handler(event)
      Kernel.raise "sample_observable_updated_handler called"
    end

    def sample_observable_created_handler(event)
      Kernel.raise "sample_observable_created_handler called"
    end
  end
  
  let(:observable) { Redson::Spec::SampleObservable.new }
  let(:observer) { Redson::Spec::SampleObserver.new }
  
  it "knows how to scope event names" do
    expect(Redson::Observable.scoped_event_name("foo")).to eq("redson.foo")
  end

  it "knows how to generated default event handlers based on the observer's class and the event name" do
    expect(observable.generate_default_handler_name_for(:updated)).to eq("sample_observable_updated_handler")
  end

  it "allows a registered observer to be notified at a specified method" do
    observable.register_observer(observer, :on => :updated, :notify => :observable_updated_handler)
    expect {
      observable.notify_observers(:updated)
    }.to raise_error("observable_updated_handler called")
  end

  it "allows a registered observer to be notified at a default method by convention" do
    observable.register_observer(observer, :on => :updated)
    expect {
      observable.notify_observers(:updated)
    }.to raise_error("sample_observable_updated_handler called")
  end

  it "ensures a registered observer is not notified about events it has not registered for" do
    observable.register_observer(observer, :on => :created)
    expect {
      observable.notify_observers(:updated)
    }.not_to raise_error
  end
  
  it "allows a registered observer to be observe more than one event" do
    observable.register_observer(observer, :on => :updated)
    observable.register_observer(observer, :on => :created)

    expect {
      observable.notify_observers(:created)
    }.to raise_error("sample_observable_created_handler called")
  end
  
  it "allows a registered observer to be notified at a default method by convention" do
    observable.register_observer(observer, :on => :updated)
    expect {
      observable.notify_observers(:updated)
    }.to raise_error("sample_observable_updated_handler called")
  end

  pending "raises an error when an observer registers for a non existent event" do
    expect { 
      observable.register_observer(observer, :on => :non_existent_event)
    }.to raise_error(Redson::Error::NoSuchEventError, "No such event is emitted: non_existent_event")
  end
end
