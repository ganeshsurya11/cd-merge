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
class LinesController < ApplicationController
  #include /lib/modules/line_processing.rb
  include LineProcessing

  # GET /lines
  # GET /lines.json
  def index
   	digital_edition = params[:digital_edition]

  	if digital_edition.nil?
    	@lines = Line.all
  	else
    	@lines = Line.where("digital_edition_id = ?", digital_edition).order("page_id ASC, line_page_order ASC");
  	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end
  
  # GET /dotei/1
  def dotei
    digital_edition_id = params[:id]
    manifestation_id = 0

    #first kill all the old tei version for this edition
    @oldtei = EditionTei.where("digital_edition_id = ?", digital_edition_id)
    @oldtei.each do |tek|
      tek.destroy
    end

    @dig_ed = DigitalEdition.where("id = ?", digital_edition_id)
    @dig_ed.each do |ed_record|
      manifestation_id = ed_record.manifestation_id
    end

    str_whole_doc_tei = "<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">\n"
    str_whole_doc_tei = str_whole_doc_tei + do_edition_header(digital_edition_id, manifestation_id)
    str_whole_doc_tei = str_whole_doc_tei + "   <text type=\"digital_edition\" xml:id=\"DE_" + digital_edition_id.to_s + "\">\n"
    str_whole_doc_tei = str_whole_doc_tei + "   	<group>\n";
    str_whole_doc_tei = str_whole_doc_tei + dowalk(digital_edition_id, 1, request.host_with_port)
    str_whole_doc_tei = str_whole_doc_tei + "   	</group>\n"
    str_whole_doc_tei = str_whole_doc_tei + "   </text>\n"
    str_whole_doc_tei = str_whole_doc_tei + "</TEI>\n"

    @editiontei = EditionTei.new()
    @editiontei.digital_edition_id = digital_edition_id
    @editiontei.tei_build_tei = str_whole_doc_tei

    if @editiontei.save
      ret_hash = { :created => "yes", :success => "yes"}
      render json: ret_hash, status: :created
    else
      ret_hash = { :status => "failed", :success => "no"}
      render json: ret_hash, status: :unprocessable_entity
    end

  end

  # GET /lines/1
  # GET /lines/1.json
  def show
    @line = line.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/new
  # GET /lines/new.json
  def new
    @line = Line.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line }
    end
  end

  # GET /lines/1/edit
  def edit
    @line = Line.find(params[:id])
  end

  # POST /lines
  # POST /lines.json
  def create
    @line = Line.new(params[:item])

    respond_to do |format|
      if @line.save
        format.html { redirect_to @line, notice: 'Line was successfully created.' }
        format.json { render json: @line, status: :created, location: @line }
      else
        format.html { render action: "new" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lines/1
  # PUT /lines/1.json
  def update
    @line = Line.find(params[:id])

    respond_to do |format|
      if @line.update_attributes(params[:line])
        format.html { redirect_to @line, notice: 'Line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lines/1
  # DELETE /lines/1.json
  def destroy
    @line = Line.find(params[:id])
    @line.destroy

    respond_to do |format|
      format.html { redirect_to lines_url }
      format.json { head :no_content }
    end
  end
  
end




