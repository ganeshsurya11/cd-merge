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
class HoldingInstitutionsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  # GET /holding_institutions
  # GET /holding_institutions.json
  def index
    @holding_institutions = HoldingInstitution.all
    @referer =  params[:referer]

    if @referer.nil?
      @referer = 0
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @holding_institutions }
    end
  end

  # GET /holding_institutions/1
  # GET /holding_institutions/1.json
  def show
    @holding_institution = HoldingInstitution.find(params[:id])
    @referer =  params[:referer]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @holding_institution }
    end
  end

  # GET /holding_institutions/new
  # GET /holding_institutions/new.json
  def new
    @holding_institution = HoldingInstitution.new
    @referer =  params[:referer]
    @ref_page = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @holding_institution }
    end
  end

  # GET /holding_institutions/1/edit
  def edit
    @holding_institution = HoldingInstitution.find(params[:id])
    @referer =  params[:referer]
    @ref_page = request.referer
  end

  # POST /holding_institutions
  # POST /holding_institutions.json
  def create
    @holding_institution = HoldingInstitution.new(params[:holding_institution])
    @referer =  params[:referer]

    respond_to do |format|
      if @holding_institution.save

        if (@referer and @referer.to_i > 0)
          str_redirect_link =  "/holding_institutions/"+@holding_institution.id.to_s+"/ref/"+@referer
        else
          str_redirect_link =  "/holding_institutions/"+@holding_institution.id.to_s
        end

        format.html { redirect_to str_redirect_link, notice: 'Holding institution was successfully created.' }
        format.json { render json: @holding_institution, status: :created, location: @holding_institution }
      else
        format.html { render action: "new" }
        format.json { render json: @holding_institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /holding_institutions/1
  # PUT /holding_institutions/1.json
  def update
    @holding_institution = HoldingInstitution.find(params[:id])
    @referer =  params[:referer]

    if (@referer and @referer.to_i > 0)
      str_redirect_link =  "/holding_institutions/"+@holding_institution.id.to_s+"/ref/"+@referer
    else
      str_redirect_link =  "/holding_institutions/"+@holding_institution.id.to_s
    end

    respond_to do |format|
      if @holding_institution.update_attributes(params[:holding_institution])
        format.html { redirect_to str_redirect_link, notice: 'Holding institution was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @holding_institution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holding_institutions/1
  # DELETE /holding_institutions/1.json
  def destroy

    # TODO: Still need to fix destroy so that it destroys the entire FRBR associative tree on confirm

    @holding_institution = HoldingInstitution.find(params[:id])
    @holding_institution.destroy

    respond_to do |format|
      format.html { redirect_to holding_institutions_url }
      format.json { head :no_content }
    end
  end
end
