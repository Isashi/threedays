module ApplicationHelper

	#return the full title based on the specific page
	def full_title(page_title = "")
		base_title = "3days travel"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end
end
