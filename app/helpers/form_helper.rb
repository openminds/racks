module FormHelper
	def show_errors_for(form_model)
		if form_model.errors.any?
			title = content_tag :h2, pluralize(form_model.errors.count, "error") + "prohibited this #{form_model.class} from being saved:"
			error_tags = form_model.errors.full_messages.collect{|msg| content_tag(:li, msg)}
			error_messages = content_tag(:ul, error_tags.collect{|tag| tag}.join.html_safe)
			errorhtml = content_tag :div, title + error_messages ,:id => "error_explanation"
			concat(errorhtml)
		end
	end
end