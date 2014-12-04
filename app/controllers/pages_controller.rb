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
class PagesController < ApplicationController
  before_filter :authenticate_user!
  include LineProcessing
  include DeleteObject
  layout "admin"

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    str_sql_trans_where = "transcriptions.page_id = " + params[:id]
	@transcriptions = Transcription.joins(:expression).joins(:work).where(str_sql_trans_where).order("transcriptions.transcription_order ASC")
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end
  
  # GET /pages/1
  # GET /pages/1.json
  def view
  	@parent = params[:parent]

    @pages = Page.where("digital_edition_id = ?", @parent).order("page_page ASC").page( params[:page]).per(20)

    respond_to do |format|
      format.html # view.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @parent = params[:parent]
    @digitaledition = DigitalEdition.find(@parent)
    @de_title = @digitaledition.digital_edition_local_title
    @pages = Page.where("digital_edition_id = ?", @parent).order("page_page DESC").first
    @diged = @digitaledition.id

    if (@pages)
      @int_page_value = @pages.page_page + 1
      if (@int_page_value == 0)
         @int_page_value = 1
      end
    else
      @int_page_value = 1
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    if params[:notice]
    	@notice = params[:notice]
    else
    	@notice = ""
    end
    @diged = @page.digital_edition_id
    @de_title = @page.digital_edition.digital_edition_local_title
    @int_page_value = @page.page_page
    @parent = @page.digital_edition_id
    str_sql_trans_where = "transcriptions.page_id = " + params[:id]
	  @transcriptions = Transcription.joins(:expression).where(str_sql_trans_where).order("transcriptions.transcription_order ASC")
	  str_sql_lines_where = "page_id = " + params[:id]
	  @lines = Line.where(str_sql_lines_where).order("line_page_order ASC")
  end
  
  # POST /pages/1/page
  def page
    if  (params[:parent] && params[:p] && params[:parent].length > 0 && params[:p].length > 0)
      str_sql_where_string = "digital_edition_id = "+params[:parent]+" AND page_page = "+params[:p]
      @page = Page.where(:digital_edition_id=>params[:parent]).where(:page_page=>params[:p]).first
      # logger.debug "Got to here"
      if (@page)
        redirect_to action: "edit", id: @page.id
      else
        redirect_to request.referer, notice: 'No Page '+params[:p]+' Found For This Edition!'
      end
    else
      redirect_to request.referer, notice: 'Enter a Valid Page Number to Search by Page!'
    end
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        # format.html { redirect_to @page, notice: 'Page was successfully created.' }
        # format.json { render json: @page, status: :created, location: @page }

        format.html { redirect_to action: "edit", id: @page.id, notice: 'Page was successfully created.' }
        format.json { head :no_content }


      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        # format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.html { redirect_to action: "edit", id: params[:id], notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  # GET /pages/i/delobj
  def delpage
    page_id = params[:id]
    @page = Page.find(page_id)
    int_del_page_return = delete_page(page_id)
    str_return_url = "/digital_editions/"+@page.digital_edition_id.to_s+"/edit?notice=Page%20Deleted"
    if (int_del_page_return > 0)
      ret_hash = { :created => "yes", :success => "yes", :redirect => str_return_url}
      render json: ret_hash, status: :created
    else
      ret_hash = { :created => "yes", :success => "no"}
      render json: ret_hash, status: :created
    end
  end


  def deletetrans
    logger.debug "Deletion Transcription ID: "+params[:transid]
    @transcription = Transcription.find(params[:transid])
    int_page_id = @transcription.page_id
    int_transcription_id = @transcriptionl.id
    @transcription.destroy

    arr_prev_page_data = get_prev_page_last_line_data(int_page_id)
    do_page_lines(arr_prev_page_data[0], arr_prev_page_data[1], arr_prev_page_data[2], int_page_id)

    str_redirect_link = "/pages/"+@transcription.int_page_id.to_s+"/edit?notice=New%20Transcription%20With%20ID%20"+int_transcription_id.to_s+"%20Deleted"

    respond_to do |format|
      format.html { redirect_to str_redirect_link }
      format.json { head :no_content }
    end
  end


  # loops through all pages in the system and builds the TEI for the page
  def make_all_pages_tei
    @pages = Page.where("id > 0")
    @pages.each do |p|
      dopagetei(p.id)
    end

  end


end
