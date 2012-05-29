module ApplicationHelper
	def logo
		"Taskmanager"
	end

	def title
		base_title = "Taskmanager"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end

