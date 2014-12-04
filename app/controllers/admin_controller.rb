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
class AdminController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  include FrbrTrees
  
  def index

  	if params[:sub]
  		@frbr_list_type = false
  	else
  		@frbr_list_type = true
  	end
  
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
  	
  	str_sql_where = "nav_category_id IN (" + str_cat_string + ")"
  	
  	@has_editions = DigitalEdition.where(str_sql_where).order("nav_category_id ASC, digital_edition_order ASC");
  	
  	
  	@frbr_tree = build_frbr_tree(@frbr_list_type)
  	
 	respond_to do |format|
		  format.html # index.html.erb
		  format.json { render json: @nav_cats }
	end 	
  	
  end
  
  def show
  
  		# @digital_editions = DigitalEdition.all
  		#@nav_cats = NavCategory.all.order("nav_category_order ASC");
  		#@nav_cats = NavCategory.where("id IN (SELECT DISTINCT nav_category_id FROM digital_editions)").order("nav_category_order ASC");
  		#@nav_cats = NavCategory.all;

		respond_to do |format|
		  format.html # index.html.erb
		  format.json { render json: @current_user }
		end

  end
  
  def login
  end
  
end













