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
class ItemsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  include DeleteObject
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new
    if params[:parent]
    	@parent_id = params[:parent]
    else
    	@parent_id = 0
    end
    
    @holding_id = 0
    
    @manifestations = Manifestation.where("id > 0").order("manifestation_siglum ASC")
    
    @manifestation_collection_master = Array.new
    @manifestations.each do |m|
    	str_man_string = "(" + m.manifestation_siglum + ") " + m.manifestation_name
    	@manifestation_item = [str_man_string, m.id]
    	@manifestation_collection_master.push(@manifestation_item)
    end
    
    @holding_institutions = HoldingInstitution.where("id > 0").order("holding_institution_name ASC")
    @holding_i_collection_master = Array.new
    @holding_i_collection_master.push(["", ""])
    @holding_institutions.each do |hi|
    	str_hi_string =  hi.holding_institution_name + " (" + hi.holding_institution_siglum + ")"
    	@hi_item = [str_hi_string, hi.id]
    	@holding_i_collection_master.push(@hi_item)
    end 
    @holding_i_collection_master.push(["Add New", 0])
    
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    
    @parent_id = 0
    @holding_id = 0
   # @item.each do |this_item|
    	@parent_id = @item.manifestation_id
    	@holding_id = @item.holding_institution_id
   # end
    
    
	@manifestations = Manifestation.where("id > 0").order("manifestation_siglum ASC")
    @manifestation_collection_master = Array.new
    @manifestations.each do |m|
    	str_man_string = "(" + m.manifestation_siglum + ") " + m.manifestation_name
    	@manifestation_item = [str_man_string, m.id]
    	@manifestation_collection_master.push(@manifestation_item)
    end
    
    @holding_institutions = HoldingInstitution.where("id > 0").order("holding_institution_name ASC")
    @holding_i_collection_master = Array.new
    @holding_i_collection_master.push(["", ""])
    @holding_institutions.each do |hi|
    	str_hi_string =  hi.holding_institution_name + " (" + hi.holding_institution_siglum + ")"
    	@hi_item = [str_hi_string, hi.id]
    	@holding_i_collection_master.push(@hi_item)
    end 
    @holding_i_collection_master.push(["Add New", 0])    
    
    
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  #GET /digital_editions/1/delobj
  def delitem
    this_id = params[:id]
    int_del_return = delete_item(this_id)
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




