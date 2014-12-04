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
class TransController < ApplicationController
  before_filter :authenticate_user!
  # GET /holding_institutions
  # GET /holding_institutions.json



  # GET /trans/:id/fedit
  # GET /trans/:id/fedit.json
  def fedit
    # @holding_institution = HoldingInstitution.new
    @transcription = Transcription.find(params[:id])
    @this_id = params[:id]
	  @parent_id = @transcription.page_id

    respond_to do |format|
      format.html {render layout: false} # fedit.html.erb
      # format.json { render json: @holding_institution }
    end
  end

  def newtrans
    @transcription = Transcription.new
    @parent = params[:parent]
    @page = Page.find(@parent)
    @dig_ed = @page.digital_edition_id

    @expressions = Expression.where("id > 0").order("expression_siglum ASC")
    @expressions_master = Array.new
    @expressions.each do |ex|
      str_ex_string =  "(" + ex.expression_siglum + ") " + ex.expression_name
      if (str_ex_string.length > 55)
        str_ex_string = str_ex_string[0..54]+"..."
      end
      if (ex.work.work_frbr == false)
        @ex_item = [str_ex_string, ex.id]
        @expressions_master.push(@ex_item)
      end
    end

    respond_to do |format|
      format.html {render layout: false} # newtrans.html.erb
      # format.json { render json: @page }
    end
  end

end
