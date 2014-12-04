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
class ManifestationsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  include DeleteObject

  # GET /manifestations
  # GET /manifestations.json
  def index
    @manifestations = Manifestation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manifestations }
    end
  end

  # GET /manifestations/1
  # GET /manifestations/1.json
  def show
    @manifestation = Manifestation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manifestation }
    end
  end

  # GET /manifestations/new
  # GET /manifestations/new.json
  def new
    @parent = @manifestation = params[:parent]
    @manifestation = Manifestation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @manifestation }
    end
  end

  # GET /manifestations/1/edit
  def edit
    @manifestation = Manifestation.find(params[:id])
    @parent = 0
  end

  # POST /manifestations
  # POST /manifestations.json
  def create
    @manifestation = Manifestation.new(params[:manifestation])
    if (params[:parent])
      int_parent_id = params[:parent].to_i
    else
      int_parent_id = 0
    end
    if (int_parent_id > 0)
      @expression = Expression.find(int_parent_id)
      if (@expression.work.work_frbr)
        int_is_primary = 1
      else
        int_is_primary = 0
      end
    end
    respond_to do |format|
      if @manifestation.save
        if (int_parent_id && int_parent_id > 0)
          ExpressionsHasManifestations.create(expression_id: int_parent_id, manifestation_id: @manifestation.id, expression_has_manifestation_primary: int_is_primary)
        end

        format.html { redirect_to @manifestation, notice: 'Manifestation was successfully created.' }
        format.json { render json: @manifestation, status: :created, location: @manifestation }
      else
        format.html { render action: "new" }
        format.json { render json: @manifestation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manifestations/1
  # PUT /manifestations/1.json
  def update
    @manifestation = Manifestation.find(params[:id])

    respond_to do |format|
      if @manifestation.update_attributes(params[:manifestation])
        format.html { redirect_to @manifestation, notice: 'Manifestation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manifestation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manifestations/1
  # DELETE /manifestations/1.json
  def destroy
    @manifestation = Manifestation.find(params[:id])
    @manifestation.destroy

    respond_to do |format|
      format.html { redirect_to manifestations_url }
      format.json { head :no_content }
    end
  end

  #GET /manifestations/1/delobj
  def delman
    this_id = params[:id]
    int_del_return = delete_manifestation(this_id)
    str_return_url = "/admin/"
    if (int_del_return > 0)
      ret_hash = { :created => "yes", :success => "yes", :redirect => str_return_url}
      render json: ret_hash, status: :created
    else
      ret_hash = { :created => "yes", :success => "no"}
      render json: ret_hash, status: :created
    end
  end

end
