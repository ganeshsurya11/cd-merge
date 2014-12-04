###############################################################################
#    Copyright (c) 2014, Carl Stahmer - www.carlstahmer.com                   #
#                                                                             #
#    This file is part of the Collex Edition Builder, a platform              #
#    publishing digital editions with a complete, FRBRized system of          #
#    metadata management and linked-data functionality.                       #
#                                                                             #
#    The Collex Edition Builder is free software: you can redistribute it     #
#    and/or modify it under the terms of the GNU General Public License       #
#    as published by the Free Software Foundation, either version 3 of        #
#    the License, or (at your option) any later version.                      #
#                                                                             #
#    The Collex Edition Builder is distributed in the hope that it will       #
#    be useful, but WITHOUT ANY WARRANTY; without even the implied warranty   #
#    of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                             #
#                                                                             #
#    You should have received a copy of the GNU General Public License        #
#    along with The Collex Edition Builder distribution.  If not,             #
#    see <http://www.gnu.org/licenses/>.                                      #
#                                                                             #
#    Development of this software was made possible through funding from      #
#    the National Endowment for the Humanities as well as the Institute       #
#    for Digital Humanities, Media, and Culture at Texas A&M University.      #
###############################################################################
class CustomFormBuilder < ActionView::Helpers::FormBuilder

	def event_date_select(label, *args)
    	   	
    	if object.send("#{label}").blank? || object.send("#{label}").nil?
    		intYear = 0
    		intMonth = 0
    		intDay = 0
    	else
    		strDate =  object.send("#{label}")
    		arrResult = strDate.split(/-/)
    		intYear = arrResult.fetch(0, "0").to_i
    		intMonth = arrResult.fetch(1, "0").to_i
    		intDay = arrResult.fetch(2, "0").to_i	
    	end
    	
    	# Do Month
     	#strRetHTML = "<select id=\"#{object_name}_#{label}_month\" name=\"#{object_name}[#{label}(month)]\">" 
     	strRetHTML = "<select id=\"temp_#{label}_month\" name=\"temp[#{label}(month)]\">" 
    	strRetHTML = strRetHTML + "<option value=\"\""
    	if intMonth == 0
    		strRetHTML = strRetHTML + " selected"
    	end
    	strRetHTML = strRetHTML + "></option>"
    	for im in 1..12
    		strIm = im.to_s
    		if strIm.length == 1
    			strValString = "0" + strIm
    		else
    			strValString = strIm
    		end
    		if im == 1
    			strValText = "January"
    		elsif im == 2
    			strValText = "February"
    		elsif im == 3
    			strValText = "March"
    		elsif im == 4
    			strValText = "April"
    		elsif im == 5
    			strValText = "May"
    		elsif im == 6
    			strValText = "June"
    		elsif im == 7
    			strValText = "July"
    		elsif im == 8
    			strValText = "August"
    		elsif im == 9
    			strValText = "September"
    		elsif im == 10
    			strValText = "October"
    		elsif im == 11
    			strValText = "November"
    		elsif im == 12
    			strValText = "December"
    		else 
    			strValText = "January"
    			strValString = "01"
    		end
    		strRetHTML = strRetHTML + "<option value=\"" + strValString  + "\""
    		if im == intMonth
    			strRetHTML = strRetHTML + " selected"
    		end
    		strRetHTML = strRetHTML + ">" + strValText + "</option>"
		end
    	strRetHTML = strRetHTML + "</select>" 
    	strRetHTML = strRetHTML + "&nbsp;" 

		# Do Day
     	strRetHTML = strRetHTML + "<select id=\"temp_#{label}_day\" name=\"temp[#{label}(day)]\">" 
    	strRetHTML = strRetHTML + "<option value=\"\""
    	if intDay == 0
    		strRetHTML = strRetHTML + " selected"
    	end
    	strRetHTML = strRetHTML + "></option>"
    	for idx in 1..31
    		strIdx = idx.to_s
    		if strIdx.length == 1
    			strValString = "0" + strIdx
    		else
    			strValString = strIdx
    		end
    		strRetHTML = strRetHTML + "<option value=\"" + strValString  + "\""
    		if idx == intDay
    			strRetHTML = strRetHTML + " selected"
    		end
    		strRetHTML = strRetHTML + ">" + strValString + "</option>"
		end
    	strRetHTML = strRetHTML + "</select>" 
    	strRetHTML = strRetHTML + "&nbsp;"
    	
    	# Do year Select
    	strRetHTML = strRetHTML + "<select id=\"#temp_#{label}_year\" name=\"temp[#{label}(year)]\">" 
    	# strRetHTML = strRetHTML + intYear.to_s + "-" + intMonth.to_s + "-" + intDay.to_s + ">>" + Donne::Application::EVENTS_START_DATE.to_s
    	strRetHTML = strRetHTML + "<option value=\"\""
    	if intYear == 0
    		strRetHTML = strRetHTML + " selected"
    	end
    	strRetHTML = strRetHTML + "></option>"
    	for i in Donne::Application::EVENTS_START_DATE..Donne::Application::EVENTS_END_DATE
    		strI = i.to_s
    		if strI.length == 1
    			strValString = "000" + strI
    		elsif strI.length == 2
    			strValString = "00" + strI
    		elsif strI.length == 3
    			strValString = "0" + strI
    		else
    			strValString = strI
    		end
    		strRetHTML = strRetHTML + "<option value=\"" + strValString  + "\""
    		if i == intYear
    			strRetHTML = strRetHTML + " selected"
    		end
    		strRetHTML = strRetHTML + ">" + strValString + "</option>"
		end
    	strRetHTML = strRetHTML + "</select>"  
    	strRetHTML = strRetHTML + "<input type=\"hidden\" name=\"object_name\" value=\"#{object_name}\">"

		return strRetHTML.html_safe
  	end

end