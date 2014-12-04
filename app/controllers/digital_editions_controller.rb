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
class DigitalEditionsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  include FrbrTrees
  include DeleteObject
  
  # GET /digital_editions
  # GET /digital_editions.json
  def index
    @digital_editions = DigitalEdition.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @digital_editions }
    end
  end

  # GET /digital_editions/1
  # GET /digital_editions/1.json
  def show
    @digital_edition = DigitalEdition.find(params[:id])
    @desc_snippet = @digital_edition.digital_edition_description
    if @desc_snippet.length > 50
      @desc_snippet = @desc_snippet[0..49] + "..."
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @digital_edition }
    end
  end

  # GET /digital_editions/new
  # GET /digital_editions/new.json
  def new
    @digital_edition = DigitalEdition.new
    @bln_is_edit = false
    if params[:parent]
    	str_sql_item_where = "manifestation_id = " + params[:parent]
    else 
    	str_sql_item_where = "id > 0"
    end

    @manifestations = Manifestation.where("id > 0").order("manifestation_name ASC")
    @manifestations_master = Array.new
    @manifestations.each do |mn|
      str_mn_string =  "(" + mn.manifestation_siglum + ") " + mn.manifestation_name
      @mn_item = [str_mn_string, mn.id]
      @manifestations_master.push(@mn_item)
    end

    @items = Item.where(str_sql_item_where).order("item_siglum ASC")
    @items_master = Array.new
    @items.each do |it|
    	@holding_institution = HoldingInstitution.find(it.holding_institution_id)
	   	str_it_string =  "(" + it.item_siglum + ") " + @holding_institution.holding_institution_name + " [" + it.item_shelfmark + "]"
	    @it_item = [str_it_string, it.id]
	    @items_master.push(@it_item)
    end

    @navcategories = NavCategory.where("id > 0").order("nav_category_name ASC")
    @navcat_master = Array.new
    @navcategories.each do |nm|
      @mn_item = [nm.nav_category_name, nm.id]
      @navcat_master.push(@mn_item)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @digital_edition }
    end
  end

  # GET /digital_editions/1/edit
  def edit
    @digital_edition = DigitalEdition.find(params[:id])
    if params[:notice]
      @notice = params[:notice]
    else
      @notice = ""
    end
    @this_id = @digital_edition.id
    str_sql_where = "digital_edition_id= " + params[:id]
  	@page = Page.where(str_sql_where)
    @pages_count = @page.count
    @manifestation = Manifestation.find(@digital_edition.manifestation_id)
    str_sql_exp_where = "manifestation_id = " + @manifestation.id.to_s + " AND expression_has_manifestation_primary = 1"
    int_primary_expression_id = 0
  	@expressions = ExpressionsHasManifestations.where(str_sql_exp_where)
  	@expressions.each do |pex|
  		int_primary_expression_id = pex.expression_id
  	end
  	@expression = Expression.find(int_primary_expression_id)
  	@work = Work.find(@expression.work_id)

    @manifestations = Manifestation.where("id > 0").order("manifestation_name ASC")
    @manifestations_master = Array.new
    @manifestations.each do |mn|
      str_mn_string =  "(" + mn.manifestation_siglum + ") " + mn.manifestation_name
      @mn_item = [str_mn_string, mn.id]
      @manifestations_master.push(@mn_item)
    end
  	
    @items = Item.where("manifestation_id = ?", @digital_edition.manifestation_id).order("item_siglum ASC")
    @items_master = Array.new
    @items.each do |it|
    	@holding_institution = HoldingInstitution.find(it.holding_institution_id)
	   	str_it_string =  "(" + it.item_siglum + ") " + @holding_institution.holding_institution_name + " [" + it.item_shelfmark + "]"
	    @it_item = [str_it_string, it.id]
	    @items_master.push(@it_item)
    end

    @navcategories = NavCategory.where("id > 0").order("nav_category_name ASC")
    @navcat_master = Array.new
    @navcategories.each do |nm|
      @mn_item = [nm.nav_category_name, nm.id]
      @navcat_master.push(@mn_item)
    end
    
    str_get_expressions_where = "expressions_has_manifestations.manifestation_id = " + @digital_edition.manifestation_id.to_s + " AND expressions_has_manifestations.expression_has_manifestation_primary = 0"
    @contains = ExpressionsHasManifestations.joins(:expression).where(str_get_expressions_where).order("expressions.expression_siglum ASC").page( params[:page]).per(20)
    
    
    @bln_is_edit = true
    @frbr_tree = build_up_frbr_tree(params[:id], true)
  end

  # POST /digital_editions
  # POST /digital_editions.json
  def create
    @digital_edition = DigitalEdition.new(params[:digital_edition])

    respond_to do |format|
      if @digital_edition.save
        format.html { redirect_to @digital_edition, notice: 'Digital edition was successfully created.' }
        format.json { render json: @digital_edition, status: :created, location: @digital_edition }
      else
        format.html { render action: "new" }
        format.json { render json: @digital_edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /digital_editions/1
  # PUT /digital_editions/1.json
  def update
    @digital_edition = DigitalEdition.find(params[:id])

    respond_to do |format|
      if @digital_edition.update_attributes(params[:digital_edition])
        format.html { redirect_to @digital_edition, notice: 'Digital edition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @digital_edition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /digital_editions/1
  # DELETE /digital_editions/1.json
  def destroy
    @digital_edition = DigitalEdition.find(params[:id])
    @digital_edition.destroy

    respond_to do |format|
      format.html { redirect_to digital_editions_url }
      format.json { head :no_content }
    end
  end


  # GET /digital_editions/1/getitem
  # GET /digital_editions/1/getitem.json
  def getitem

    int_parent = params[:parent]
    @items = Item.where("manifestation_id = ?", int_parent).order("item_siglum ASC")
    @items_master = Array.new
    @items.each do |it|
      @holding_institution = HoldingInstitution.find(it.holding_institution_id)
      str_it_string =  "(" + it.item_siglum + ") " + @holding_institution.holding_institution_name + " [" + it.item_shelfmark + "]"
      @it_item = [str_it_string, it.id]
      @items_master.push(@it_item)
    end


    respond_to do |format|
      format.html { render json: @items_master }
      format.json { render json: @items_master }
    end
  end


  #GET /digital_editions/1/delobj
  def deledition
    this_id = params[:id]
    int_del_return = delete_digital_edition(this_id)
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
