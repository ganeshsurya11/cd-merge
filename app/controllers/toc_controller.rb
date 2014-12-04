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
class TocController < ApplicationController
  #include /lib/modules/edition_base_links.rb
  include EditionBaseLinks

  #set the layout
  layout "application"


  # GET /edition/1/toc/1

  def showtoc

    # @concordance_entries = ConcordanceEntry.where("digital_edition_id = ?", params[:id]).order("concordance_entry_token ASC").page( params[:page]).per(20)

    # @concordance_entries = DigitalEditionHasConcordanceEntryTotal.joins(ConcordanceEntry).where("digital_edition_id = ?", params[:id]).order("concordance_entry_token ASC").page( params[:page]).per(20)

   # @concordance_entries = DigitalEditionHasConcordanceEntryTotal.joins("JOIN concordance_entries ON concordance_entries.id = digital_edition_has_concordance_entry_totals.id").where("digital_edition_id = ?", params[:id]).order("concordance_entry_token").page( params[:page]).per(20)

    @sort_link = "/edition/" + params[:id] + "/toc"

    #setup the title link
    @title_nav_links = makeTitleLink(params[:id])

    @digedid = params[:id]

    if params[:t]
     str_order_field = "line_digital_edition_order"
     @sort_text = "Order by Poem"


   else
     str_order_field = "expression_siglum"
     @sort_link = @sort_link + "/1"
     @sort_text = "Order by Page"

   end

    @titles = Expression.uniq.joins(:lines).where("digital_edition_id = ?", params[:id]).order(str_order_field).page( params[:page]).per(20)

    #get the navlinks
    @edition_nav_links =  makeLinks(params[:id])

    render :show

  end



end