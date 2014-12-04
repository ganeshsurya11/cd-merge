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
class NavCategoriesController < ApplicationController
  # GET /nav_categories
  # GET /nav_categories.json
  def index
    @nav_categories = NavCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nav_categories }
    end
  end

  # GET /nav_categories/1
  # GET /nav_categories/1.json
  def show
    @nav_category = NavCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nav_category }
    end
  end

  # GET /nav_categories/new
  # GET /nav_categories/new.json
  def new
    @nav_category = NavCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nav_category }
    end
  end

  # GET /nav_categories/1/edit
  def edit
    @nav_category = NavCategory.find(params[:id])
  end

  # POST /nav_categories
  # POST /nav_categories.json
  def create
    @nav_category = NavCategory.new(params[:nav_category])

    respond_to do |format|
      if @nav_category.save
        format.html { redirect_to @nav_category, notice: 'Nav category was successfully created.' }
        format.json { render json: @nav_category, status: :created, location: @nav_category }
      else
        format.html { render action: "new" }
        format.json { render json: @nav_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nav_categories/1
  # PUT /nav_categories/1.json
  def update
    @nav_category = NavCategory.find(params[:id])

    respond_to do |format|
      if @nav_category.update_attributes(params[:nav_category])
        format.html { redirect_to @nav_category, notice: 'Nav category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nav_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nav_categories/1
  # DELETE /nav_categories/1.json
  def destroy
    @nav_category = NavCategory.find(params[:id])
    @nav_category.destroy

    respond_to do |format|
      format.html { redirect_to nav_categories_url }
      format.json { head :no_content }
    end
  end
end
