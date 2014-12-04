# encoding: utf-8

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

class TranscriptionsController < ApplicationController
  include LineProcessing

  # figure out the correct associated surrogate id that passes through the manifestations table
  # before_filter :get_surrogate_association, :only => [ :create, :update ]
  
  # GET /transcriptions
  # GET /transcriptions.json
  def index
    @transcriptions = Transcription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transcriptions }
    end
  end

  # GET /transcriptions/1
  # GET /transcriptions/1.json
  def show
    @transcription = Transcription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transcription }
    end
  end

  # GET /transcriptions/new
  # GET /transcriptions/new.json
  def new
    @transcription = Transcription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transcription }
    end
  end

  # GET /transcriptions/1/edit
  def edit
    @transcription = Transcription.find(params[:id])
  end
  

  # POST /transcriptions
  # POST /transcriptions.json
  def create
    set_assoc_work_param()
    @transcription = Transcription.new(params[:transcription])

    respond_to do |format|
      if @transcription.save
        int_rebuild_value = "0"
        if (params[:rebuild])
          int_rebuild_value = params[:rebuild]
        end
        if int_rebuild_value.to_i > 0
          int_tei_ret = doeditiontei(@transcription.digital_edition_id)
        end
        arr_prev_page_data = get_prev_page_last_line_data(@transcription.page_id)
        do_page_lines(arr_prev_page_data[0], arr_prev_page_data[1], @transcription.page_id)
        dopagetei(@transcription.page_id)
        str_redirect_link = "/pages/"+@transcription.page_id.to_s+"/edit?notice=New%20Transcription%20Saved%20With%20ID%20"+@transcription.id.to_s
        format.html { redirect_to str_redirect_link }
        format.json { render json: @transcription, status: :created, location: @transcription }
      else
        format.html { render action: "new" }
        format.json { render json: @transcription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transcriptions/1
  # PUT /transcriptions/1.json
  def update

    @transcription = Transcription.find(params[:id])
    str_page_edit = "/pages/"+params[:parent_id]+"/edit?notice=New%20Transcription%20File%20Saved"

    int_do_rebuild = 0
    if (params[:rebuild])
      if (params[:rebuild] == 1)
        int_do_rebuild = 1
      end
    end

    respond_to do |format|
      if @transcription.update_attributes(params[:transcription])

        dopagetei(@transcription.page_id)
        #################################################################
        # Here is where I need to put code to recalculate all the lines #
        # In the edition 												#
        #################################################################
        if (int_do_rebuild > 0)
            int_tei_ret = doeditiontei(@transcription.digital_edition_id)
        end


        # format.html { render json: @transcription, status: "updated" }
        # format.html { redirect_to @transcription, notice: 'Transcription was successfully updated.' }
        format.html { redirect_to str_page_edit }
        # format.json { head :no_content }
        format.json { render json: @transcription, status: "updated" }
      else
        format.html { render action: "edit" }
        format.json { render json: @transcription.errors, status: :unprocessable_entity }
      end

    end
  end
  
  # POST /transcriptions/update_order
  # POST /transcriptions/update_order.json
  def update_order

	# holds the total number of transcription records for the page
	int_num_trans = params[:num_trans].to_i
	# holds the ID of the page parent for the transcriptions
	parent_id = params[:parent]
	
	str_page_edit = "/pages/"+parent_id+"/edit?notice=Transcription%20Order%20Updated"
	
	
	# fields to loop through look like these blow
	# "to_x" is the transcription order on the page
	# "id_x" is the :id for the transcription whose order should be set to "to_x"
	# in other words, update "id_x" set :transcription_order = "to_x"
	#
	#<input id="to_1" name="to_1" size="1" type="text" value="2" />
	#<input id="id_1" name="id_1" type="hidden" value="42" />
	#
	#<input id="to_2" name="to_2" size="1" type="text" value="3" />
	#<input id="id_2" name="id_2" type="hidden" value="43" />
	
	#########################################################
	# put looping logic here for x = 1 to int_num_trans get #
	# the param values and do a sql update  				#
	#########################################################
	
	int_iterate = 1
	while int_iterate <= int_num_trans
  		str_id_param = "id_" + int_iterate.to_s
  		str_order_param = "to_" + int_iterate.to_s
  		int_update_id = params[str_id_param].to_i
  		int_update_order = params[str_order_param].to_i
  		@transcription = Transcription.find(int_update_id)
		@transcription.transcription_order = int_update_order
		@transcription.save
  		int_iterate = int_iterate + 1
	end
	
	arr_prev_page_data = get_prev_page_last_line_data(parent_id)
	do_page_lines(arr_prev_page_data[0], arr_prev_page_data[1], parent_id)
  dopagetei(parent_id)

    respond_to do |format|
       format.html { redirect_to str_page_edit }
       format.json { redirect_to str_page_edit }
    end
    
  end

  # get /transcriptions/1
  # get /transcriptions/1.json
  def destroy
    logger.debug "Deletion Transcription ID: "+params[:id]
    @transcription = Transcription.find(params[:id])
    int_page_id = @transcription.page_id
    int_transcription_id = @transcriptionl.id
    @transcription.destroy

    arr_prev_page_data = get_prev_page_last_line_data(int_page_id)
    do_page_lines(arr_prev_page_data[0], arr_prev_page_data[1], int_page_id)

    str_redirect_link = "/pages/"+@transcription.int_page_id.to_s+"/edit?notice=New%20Transcription%20With%20ID%20"+int_transcription_id.to_s+"%20Deleted"

    respond_to do |format|
      format.html { redirect_to str_redirect_link }
      format.json { head :no_content }
    end
  end



  # get /transcriptions/1/dump
  def dump
    logger.debug "Deletion Transcription ID: "+params[:id]
    @transcription = Transcription.find(params[:id])
    logger.debug "Deletion Transcription ID After Record Load: "+@transcription.id.to_s
    int_page_id = @transcription.page_id
    int_transcription_id = @transcription.id
    @transcription.transcription_file.remove!

    @transcription.destroy

    arr_prev_page_data = get_prev_page_last_line_data(int_page_id)
    do_page_lines(arr_prev_page_data[0], arr_prev_page_data[1], int_page_id)
    dopagetei(int_page_id)

    str_redirect_link = "/pages/"+int_page_id.to_s+"/edit?notice=Transcription%20With%20ID%20"+int_transcription_id.to_s+"%20Deleted"

    respond_to do |format|
      format.html { redirect_to str_redirect_link }
      format.json { head :no_content }
    end
  end
    
  # get the surrogate id associated with the associated page and add a parameter
  # to the model for this id
  def get_surrogate_association
 
    	
    	#first, lets see if I can get the expression ID from the manifestation table
    	intAssociatedPageID = params[:transcription][:page_id]
    	@page = Page.find(intAssociatedPageID)
    	intAssociatedSurrogateID = @page.surrogate_id
    	params[:transcription][:surrogate_id] = intAssociatedSurrogateID
    	
  
  end

  def set_assoc_work_param()

    @expresssion = Expression.find(params[:transcription][:expression_id])
    params[:transcription][:work_id] = @expresssion.work_id


  end
  
  
end
