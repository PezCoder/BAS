module ApplicationHelper
	
	def down_arrow 
		content_tag(:small,content_tag(:span,"",:class=>'glyphicon glyphicon-menu-down'))
		#returning > "<small><span class="glyphicon glyphicon-menu-down"></span></small>"
	end
end
