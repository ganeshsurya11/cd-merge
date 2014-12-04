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
class LocalMarkupMappingsController < ApplicationController
  # GET /local_markup_mappings
  # GET /local_markup_mappings.json
  def index
    @local_markup_mappings = LocalMarkupMapping.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @local_markup_mappings }
    end
  end

  # GET /local_markup_mappings/1
  # GET /local_markup_mappings/1.json
  def show
    @local_markup_mapping = LocalMarkupMapping.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @local_markup_mapping }
    end
  end

  # GET /local_markup_mappings/new
  # GET /local_markup_mappings/new.json
  def new
    @local_markup_mapping = LocalMarkupMapping.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @local_markup_mapping }
    end
  end

  # GET /local_markup_mappings/1/edit
  def edit
    @local_markup_mapping = LocalMarkupMapping.find(params[:id])
  end

  # POST /local_markup_mappings
  # POST /local_markup_mappings.json
  def create
    @local_markup_mapping = LocalMarkupMapping.new(params[:local_markup_mapping])

    respond_to do |format|
      if @local_markup_mapping.save
        format.html { redirect_to @local_markup_mapping, notice: 'Local markup mapping was successfully created.' }
        format.json { render json: @local_markup_mapping, status: :created, location: @local_markup_mapping }
      else
        format.html { render action: "new" }
        format.json { render json: @local_markup_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /local_markup_mappings/1
  # PUT /local_markup_mappings/1.json
  def update
    @local_markup_mapping = LocalMarkupMapping.find(params[:id])

    respond_to do |format|
      if @local_markup_mapping.update_attributes(params[:local_markup_mapping])
        format.html { redirect_to @local_markup_mapping, notice: 'Local markup mapping was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @local_markup_mapping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /local_markup_mappings/1
  # DELETE /local_markup_mappings/1.json
  def destroy
    @local_markup_mapping = LocalMarkupMapping.find(params[:id])
    @local_markup_mapping.destroy

    respond_to do |format|
      format.html { redirect_to local_markup_mappings_url }
      format.json { head :no_content }
    end
  end
end
