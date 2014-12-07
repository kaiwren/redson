module Redson
  module Form
    class Widget < Redson::Widget
      def initialize(target_element = nil)
        super(target_element)
        model.register_observer(
                self, :on => :created
              ).register_observer(
                self, :on => :updated
              ).register_observer(
                self, :on => :unprocessable_entity
              )
      end

      def model_created_handler(event)
        bubble_up(event)
      end

      def model_updated_handler(event)
        bubble_up(event)
      end

      def model_unprocessable_entity_handler(event)
        bubble_up(event)
      end
    end
  end
end