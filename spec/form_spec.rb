require "spec_helper"

describe Redson::Form do
  let(:form_element) do
    Element.parse <<-EOFORM
    <form accept-charset="UTF-8" action="/students" class="new_student" id="new_student" method="post">
      <div style="display:none">
        <input name="utf8" type="hidden" value="&#x2713;" />
        <input name="authenticity_token" type="hidden" value="RD8ixyLAEOQuFDXpRJBDj9PJVCB8Pw6u+LdLvlZhuuI=" />
      </div>

      <div class="field">
        <label for="student_name">Name</label><br>
        <input id="student_name" name="student[name]" type="text" />
      </div>      
      <div class="field">
        <label for="student_age">Age</label><br>
        <input id="student_age" name="student[age]" type="text" />
      </div>
      <div class="actions">
        <input name="commit" type="submit" value="Create Student" />
      </div>
    </form>
EOFORM
  end
  
  let(:form) { Redson::Form.new(form_element) }
  
  context "initialization" do
    it "succeeds with a form element is passed to it" do
      expect(lambda {
        form
      }).to_not raise_error
    end

    it "fails with an exception when an element other than a form is passed in" do
      expect(lambda {
        Redson::Form.new(Element.new('div'))
      }).to raise_error
    end
  end
  
  it "can find inputs of type submit within it" do
    submit_element = form.submit_element
    expect(submit_element.attr("name")).to eq("commit")
    expect(submit_element.attr("value")).to eq("Create Student")
  end
  
  it "can find all inupts other than those of type submit" do
    input_element_names = form.input_elements.map{ |e| e.attr("name") }
    expect(input_element_names).to eq(["utf8", "authenticity_token",
                                       "student[name]", "student[age]"])
  end
  
  it "knows the value of its action attribue" do
    expect(form.action_attribute).to eq("/students")
  end
  
end