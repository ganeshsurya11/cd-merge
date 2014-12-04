# encoding: utf-8

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

class ApplicationController < ActionController::Base
  protect_from_forgery
	config.log_level = :debug
  
  def current_user
  	if session[:user_id]
  		@current_user ||= User.find_by_id!(session[:user_id])
  	end
  end
  helper_method :current_user
  
  

  def authenticate_user!
    if current_user.nil?
    	redirect_to :controller => 'sessions', :action => 'new', :notice => 'You must login first!'
    end
  end


  
  # start and end dates being submitted via multiple fields that need to be combined into a sql style
  # string based date field of format 0000-00-00 (YYYY-MM-DD)
  def standardise_dates

    str_object_name = params[:object_name]
    str_fields_to_process = params[:event_date_select_fields]
    arr_fields_to_process = str_fields_to_process.split(/,/)
    
    arr_fields_to_process.each do |ft|

		str_year_field_name = ft + "(year)"
		str_month_field_name = ft + "(month)"
		str_day_field_name  = ft + "(day)"
	
		if params[:temp][:"#{str_year_field_name}"].blank?
			str_date_string = ""
		else
			str_year_temp = params[:temp][:"#{str_year_field_name}"]
			if params[:temp][:"#{str_month_field_name}"].blank?
				str_month_temp = "00"
			else
				str_month_temp = params[:temp][:"#{str_month_field_name}"]
			end
			if params[:temp][:"#{str_day_field_name}"].blank?
				str_day_temp = "00"
			else
				str_day_temp = params[:temp][:"#{str_day_field_name}"]
			end
			str_date_string = str_year_temp + "-" + str_month_temp + "-" + str_day_temp
		
		end
		
		params[:"#{str_object_name}"][:"#{ft}"] = str_date_string
	
	end
	
  end

  def load_sidebar
    @nav_cats = NavCategory.where("id IN (SELECT DISTINCT nav_category_id FROM digital_editions)").order("nav_category_order ASC");

    str_cat_string = ""
    bln_done_one = false
    @nav_cats.each do |working_cat|
      if bln_done_one
        str_cat_string = str_cat_string + ","
      end
      str_cat_string = str_cat_string + " " + working_cat.id.to_s
      bln_done_one = true
    end

    if str_cat_string.length < 1
      str_cat_string = "0"
    end

    str_sql_where = "nav_category_id IN (" + str_cat_string + ") AND digital_edition_active LIKE 't'"
    # for mysql implementation use below
    # str_sql_where = "nav_category_id IN (" + str_cat_string + ") AND digital_edition_active LIKE 't'"

    @has_editions = DigitalEdition.where(str_sql_where).order("nav_category_id ASC, digital_edition_order ASC");



  end
 
end