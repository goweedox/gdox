module DocumentationsHelper
	def add_screenshot(form_builder)
		button_to_function "Add Screenshot", :id  => "add_screenshot" do |page|
		  form_builder.fields_for :screenshots, Screenshot.new, :child_index => 'NEW_RECORD' do |screenshot_form|
		    html = render(:partial => 'screenshot', :locals => { :f => screenshot_form })
		    page << "$('add_screenshot').insert({ before: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
		  end
		end
	end

	def delete_screenshot(form_builder)
		if form_builder.object.new_record?
		  link_to_function("Cancel", "this.up('fieldset').remove()")
		else
		  form_builder.hidden_field(:_delete) +
		  link_to_function("Cancel", "this.up('fieldset').hide(); $(this).previous().value = '1'")
		end
	end
end
