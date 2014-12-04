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
class ExpressionTypesController < ApplicationController
  # GET /expression_types
  # GET /expression_types.json
  def index
    @expression_types = ExpressionType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expression_types }
    end
  end

  # GET /expression_types/1
  # GET /expression_types/1.json
  def show
    @expression_type = ExpressionType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expression_type }
    end
  end

  # GET /expression_types/new
  # GET /expression_types/new.json
  def new
    @expression_type = ExpressionType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expression_type }
    end
  end

  # GET /expression_types/1/edit
  def edit
    @expression_type = ExpressionType.find(params[:id])
  end

  # POST /expression_types
  # POST /expression_types.json
  def create
    @expression_type = ExpressionType.new(params[:expression_type])

    respond_to do |format|
      if @expression_type.save
        format.html { redirect_to @expression_type, notice: 'Expression type was successfully created.' }
        format.json { render json: @expression_type, status: :created, location: @expression_type }
      else
        format.html { render action: "new" }
        format.json { render json: @expression_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expression_types/1
  # PUT /expression_types/1.json
  def update
    @expression_type = ExpressionType.find(params[:id])

    respond_to do |format|
      if @expression_type.update_attributes(params[:expression_type])
        format.html { redirect_to @expression_type, notice: 'Expression type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expression_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expression_types/1
  # DELETE /expression_types/1.json
  def destroy
    @expression_type = ExpressionType.find(params[:id])
    @expression_type.destroy

    respond_to do |format|
      format.html { redirect_to expression_types_url }
      format.json { head :no_content }
    end
  end
end
