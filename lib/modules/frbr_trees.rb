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

module FrbrTrees


  # builds an array object that represents a frbr hierarchy from Work thorugh Manifestation
  # bln_primary = true reuturns only primary works
  # bln_primary = false returns only secondary works
  def build_frbr_tree(bln_primary)
  	@arr_frbr_tree = Array.new
  	if bln_primary
  		@works = Work.where("work_frbr = ?", bln_primary).order("work_name ASC")
  	else
  		@works = Work.where("work_frbr = ?", bln_primary).order("work_siglum ASC")
  	end
  	@works.each do |work_item|
  		@arr_work_item = Array.new
  		@arr_expressions_master = Array.new
  		if bln_primary
  			@expressions = Expression.where("work_id = ?", work_item.id).order("expression_name ASC")
  		else
  			@expressions = Expression.where("work_id = ?", work_item.id).order("expression_siglum ASC")
  		end
  		@expressions.each do |expression_item|
  			@arr_expression_item = Array.new
  			@arr_manifestation_master = Array.new
  			@exp_man_joins = ExpressionsHasManifestations.where("expression_id = ?", expression_item.id)
  			@exp_man_joins.each do |exp_main_join_item|
  				@arr_manifestation_item = Array.new
  				@manifestations = Manifestation.where("id = ?", exp_main_join_item.manifestation_id).order("manifestation_name ASC")
  				@manifestations.each do |man_item|
  					@arr_items_master = Array.new
  					@items = Item.where("manifestation_id = ?", man_item.id)
  					@items.each do |item_item|
  						@arr_items_item = Array.new
  						str_item_item = "I_" + item_item.id.to_s + ": " + item_item.item_siglum
  						@arr_items_item.push(item_item.id)
  						@arr_items_item.push(str_item_item)
  						@arr_items_master.push(@arr_items_item)
  					end
  					str_man_item = "M_" + man_item.id.to_s + ": " + man_item.manifestation_name + " (" + man_item.manifestation_siglum + ")"
  					@arr_manifestation_item.push(man_item.id.to_s)
  					@arr_manifestation_item.push(str_man_item)
  					@arr_manifestation_item.push(@arr_items_master)
  					@arr_manifestation_master.push(@arr_manifestation_item)
 
  				end
  				
  			# end @exp_man_joins loop
  			end
  			
  			str_expression_item = "E_" + expression_item.id.to_s + ": " + expression_item.expression_name + " (" + expression_item.expression_siglum + ")"
  			@arr_expression_item.push(expression_item.id)
  			@arr_expression_item.push(str_expression_item)
  			@arr_expression_item.push(@arr_manifestation_master)
  			@arr_expressions_master.push(@arr_expression_item)

  		# end @expressions loop
  		end
  		if bln_primary
  			str_work_itme = "W_" + work_item.id.to_s + ": " + work_item.work_name + " (" + work_item.work_siglum + ")"
  		else
  			str_work_itme = "(" + work_item.work_siglum + ") " + work_item.work_name + ": W_" + work_item.id.to_s
  		end
		@arr_work_item.push(work_item.id.to_s)
		@arr_work_item.push(str_work_itme)
		@arr_work_item.push(@arr_expressions_master)
		@arr_frbr_tree.push(@arr_work_item)
	
	#end @works loop
  	end
  	
  	return @arr_frbr_tree
  end
  
  
  
  
  # builds an array object that represents a reverse frbr hierarchy from item thorugh work
  # int_digital_edition_id: the id of the digitial edition to run the hierarchy for
  # bln_primary: true = returns only primary works / false = returns all works
  def build_up_frbr_tree(int_digital_edition_id, bln_primary)
  	@arr_frbr_tree = Array.new
  	
  	
  	@items = ItemsHasDigitalEditions.where("digital_edition_id = ?", int_digital_edition_id).order("item_has_digital_edition_primary ASC")
  	@items.each do |items_item|
  		int_assoc_man = 0
  		@item = Item.where("id = ?", items_item.item_id)
  		@item.each do |item_item|
  				int_item_id = item_item.id
				str_item_name = "I_" + item_item.id + ": " + item_item.item_siglum
				int_assoc_man = item_item.manifestation_id
  		end
  		@arr_manifestation_master = Array.new
  		@manifestations = Manifestation.where("id = ?", int_assoc_man).order("manifestation_name ASC")
  		@manifestations.each do |man_item|
  			@arr_expressions_master = Array.new
  			@exp_man_joins = ExpressionsHasManifestations.where("manifestation_id = ?", man_item.id)
  			@exp_man_joins.each do |exp_join_item|
  			
  				# here is where I have to put in the logic whether to display all expressions and works
  				# or just the primary ones
  				if (bln_primary)
  					@expressions = Expression.joins(:works).where("expressions.id = ?", exp_join_item.expression_id).order("expression_name ASC")
  				else
  					@expressions = Expression.where("id = ?", exp_join_item.expression_id).order("expression_siglum ASC")
  				end
  				@expressions.each do |expression_item|
  				
  				
  					@arr_works_master = Array.new
  					if (bln_primary)
  						@works = Work.where("work_frbr = 1 AND id = ?", expression_item.work_id).order("work_name ASC")
  					else
  						@works = Work.where("id = ?", expression_item.work_id).order("work_siglum ASC")
  					end
  					@works.each do |work_item|
  						@arr_work_item = Array.new
  						if bln_primary
  							str_work_item = "W_" + work_item.id.to_s + ": " + work_item.work_name + " (" + work_item.work_siglum + ")"
  						else
  							str_work_item = "(" + work_item.work_siglum + ") " + work_item.work_name + ": W_" + work_item.id.to_s
  						end
  						@arr_work_item.push(work_item.id)
  						@arr_work_item.push(str_work_item)
  						@arr_works_master.push(@arr_work_item)
  					end

  					@arr_expression_item = Array.new
  					str_expression_item = "E_" + expression_item.id.to_s + ": " + expression_item.expression_name + " (" + expression_item.expression_siglum + ")"
  					@arr_expression_item.push(expression_item.id)
  					@arr_expression_item.push(str_expression_item)
  					@arr_expression_item.push(@arr_works_master)
  					@arr_expressions_master.push(@arr_expression_item)
  					
  				end

  			end
  			
  			
  			
  			
  			@arr_manifestation_item = Array.new
  			str_manifestation_name = "M_" + man_item.id.to_s + ": " + man_item.manifestation_name + " (" + man_item.manifestation_siglum + ")"
  			@arr_manifestation_item.push(man_item.id)
  			@arr_manifestation_item.push(str_manifestation_name)
  			@arr_manifestation_item.push(@arr_expressions_master)

  		end

  		#fill the items array and push to tree master
		if (items_item.item_has_digital_edition_primary)
			int_item_primary = 1
		else
			int_item_primary = 0
		end
		str_item_name = "I_" + item_item.id.to_s + ": " + item_item.item_siglum
		@arr_item_item = Array.new
		@arr_item_item.push(int_item_id)
		@arr_item_item.push(str_item_name)
		@arr_item_item.push(int_item_primary)
		@arr_item_item.push(@arr_manifestation_master)
  		arr_frbr_tree.push(@arr_item_item)
  	end
  	
  	return @arr_frbr_tree
  end


end