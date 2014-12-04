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
class ManifestationTypesController < ApplicationController
  # GET /manifestation_types
  # GET /manifestation_types.json
  def index
    @manifestation_types = ManifestationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manifestation_types }
    end
  end

  # GET /manifestation_types/1
  # GET /manifestation_types/1.json
  def show
    @manifestation_type = ManifestationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manifestation_type }
    end
  end

  # GET /manifestation_types/new
  # GET /manifestation_types/new.json
  def new
    @manifestation_type = ManifestationType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @manifestation_type }
    end
  end

  # GET /manifestation_types/1/edit
  def edit
    @manifestation_type = ManifestationType.find(params[:id])
  end

  # POST /manifestation_types
  # POST /manifestation_types.json
  def create
    @manifestation_type = ManifestationType.new(params[:manifestation_type])

    respond_to do |format|
      if @manifestation_type.save
        format.html { redirect_to @manifestation_type, notice: 'Manifestation type was successfully created.' }
        format.json { render json: @manifestation_type, status: :created, location: @manifestation_type }
      else
        format.html { render action: "new" }
        format.json { render json: @manifestation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manifestation_types/1
  # PUT /manifestation_types/1.json
  def update
    @manifestation_type = ManifestationType.find(params[:id])

    respond_to do |format|
      if @manifestation_type.update_attributes(params[:manifestation_type])
        format.html { redirect_to @manifestation_type, notice: 'Manifestation type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manifestation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manifestation_types/1
  # DELETE /manifestation_types/1.json
  def destroy
    @manifestation_type = ManifestationType.find(params[:id])
    @manifestation_type.destroy

    respond_to do |format|
      format.html { redirect_to manifestation_types_url }
      format.json { head :no_content }
    end
  end
end
