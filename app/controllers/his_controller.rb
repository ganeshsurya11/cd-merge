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
class HisController < ApplicationController
  before_filter :authenticate_user!
  # GET /holding_institutions
  # GET /holding_institutions.json



  # GET /holding_institutions/new
  # GET /holding_institutions/new.json
  def new
    @holding_institution = HoldingInstitution.new
    

    respond_to do |format|
      format.html {render layout: false} # new.html.erb
      format.json { render json: @holding_institution }
    end
  end


  # POST /holding_institutions
  # POST /holding_institutions.json
  def create
    @holding_institution = HoldingInstitution.new(params[:holding_institution])

    respond_to do |format|
      if @holding_institution.save
        format.html { redirect_to @holding_institution, notice: 'Holding institution was successfully created.' }
        format.json { render json: @holding_institution, status: :created, location: @holding_institution }
      else
        format.html { render action: "new" }
        format.json { render json: @holding_institution.errors, status: :unprocessable_entity }
      end
    end
  end

end
