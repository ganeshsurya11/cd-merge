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
class ExpressionsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  include DeleteObject

  # GET /expressions
  # GET /expressions.json
  def index
    @expressions = Expression.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expressions }
    end
  end

  # GET /expressions/1
  # GET /expressions/1.json
  def show
    @expression = Expression.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expression }
    end
  end

  # GET /expressions/new
  # GET /expressions/new.json
  def new
    @parent_id = params[:parent]
    
    if URI(request.referer).path == '/expressions'
    	@works = Work.where("id > 0").order("work_siglum ASC")
  	else
  		@works = Work.where("work_frbr = ?", true).order("work_name ASC")
  	end
    
    @woks_collection_master = Array.new
    @works.each do |w|
    	str_work_string = w.work_name + " (" + w.work_siglum + ")"
    	@works_item = [str_work_string, w.id]
    	@woks_collection_master.push(@works_item)
    end
    
    @expression = Expression.new
    
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expression }
    end
  end

  # GET /expressions/1/edit
  def edit
    @expression = Expression.find(params[:id])
       
    @parent_id = params[:parent]
    
    if URI(request.referer).path == '/expressions'
    	@works = Work.where("id > 0").order("work_siglum ASC")
  	else
  		@works = Work.where("work_frbr = ?", true).order("work_name ASC")
  	end
    
    @woks_collection_master = Array.new
    @works.each do |w|
    	str_work_string = w.work_name + " (" + w.work_siglum + ")"
    	@works_item = [str_work_string, w.id]
    	@woks_collection_master.push(@works_item)
    end

    @primary = false
    this_work_parent = Work.find(@expression.work_id)
    if (this_work_parent.work_frbr?)
      @primary = true
    end


    
  end

  # POST /expressions
  # POST /expressions.json
  def create
    @expression = Expression.new(params[:expression])

    respond_to do |format|
      if @expression.save
        format.html { redirect_to @expression, notice: 'Expression was successfully created.' }
        format.json { render json: @expression, status: :created, location: @expression }
      else
        format.html { render action: "new" }
        format.json { render json: @expression.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expressions/1
  # PUT /expressions/1.json
  def update
    @expression = Expression.find(params[:id])

    respond_to do |format|
      if @expression.update_attributes(params[:expression])
        format.html { redirect_to @expression, notice: 'Expression was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expression.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expressions/1
  # DELETE /expressions/1.json
  def destroy
    @expression = Expression.find(params[:id])
    @expression.destroy

    respond_to do |format|
      format.html { redirect_to expressions_url }
      format.json { head :no_content }
    end
  end

  #GET /expressions/1/delobj
  def delexp
    this_id = params[:id]
    int_del_return = delete_expression(this_id)
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
