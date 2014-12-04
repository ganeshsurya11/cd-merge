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
class ConcordanceEntriesController < ApplicationController
  # GET /concordance_entries
  # GET /concordance_entries.json
  def index
    @concordance_entries = ConcordanceEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @concordance_entries }
    end
  end

  # GET /concordance_entries/1
  # GET /concordance_entries/1.json
  def show
    @concordance_entry = ConcordanceEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @concordance_entry }
    end
  end

  # GET /concordance_entries/new
  # GET /concordance_entries/new.json
  def new
    @concordance_entry = ConcordanceEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @concordance_entry }
    end
  end

  # GET /concordance_entries/1/edit
  def edit
    @concordance_entry = ConcordanceEntry.find(params[:id])
  end

  # POST /concordance_entries
  # POST /concordance_entries.json
  def create
    @concordance_entry = ConcordanceEntry.new(params[:concordance_entry])

    respond_to do |format|
      if @concordance_entry.save
        format.html { redirect_to @concordance_entry, notice: 'Concordance entry was successfully created.' }
        format.json { render json: @concordance_entry, status: :created, location: @concordance_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @concordance_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /concordance_entries/1
  # PUT /concordance_entries/1.json
  def update
    @concordance_entry = ConcordanceEntry.find(params[:id])

    respond_to do |format|
      if @concordance_entry.update_attributes(params[:concordance_entry])
        format.html { redirect_to @concordance_entry, notice: 'Concordance entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @concordance_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concordance_entries/1
  # DELETE /concordance_entries/1.json
  def destroy
    @concordance_entry = ConcordanceEntry.find(params[:id])
    @concordance_entry.destroy

    respond_to do |format|
      format.html { redirect_to concordance_entries_url }
      format.json { head :no_content }
    end
  end


  # Build the concordance for an edition   /doconcord/1
  def build_edition_concordance

    int_num_lines = 0
    int_num_tokens = 0
    int_num_new_tokens = 0

    ##first clear all the concordance records for this edition
    #old_concordance_entries = DigitalEditionHasConcordanceEntry.where("digital_edition_id = ?", params[:id])
    #old_concordance_entries.each do |dece|
    #  dece.destroy
    #end
    #old_concordance_total_entries = DigitalEditionHasConcordanceEntryTotal.where("digital_edition_id = ?", params[:id])
    #old_concordance_total_entries.each do |decet|
    #  decet.destroy
    #end

    #temp while testing
    #ConcordanceEntry.destroy_all

    DigitalEditionHasConcordanceEntry.where("digital_edition_id = ?", params[:id]).destroy_all
    DigitalEditionHasConcordanceEntryTotal.where("digital_edition_id = ?", params[:id]).destroy_all


    str_sql_lines_where = "digital_edition_id = " + params[:id]
    lines = Line.where(str_sql_lines_where)
    lines.each do |ln|
      if ln.line_tei && ln.line_tei.length > 0

        #first remove all the TEI tags
        clean_line_string = ln.line_tei.gsub(/<.*?>/,"")

        #now, remove all the special characters and punctuation

        clean_line_string = clean_line_string.gsub(/\(/," ")
        clean_line_string = clean_line_string.gsub(/\)/," ")
        clean_line_string = clean_line_string.gsub(/\[\s*p\.*\s*\d+\s*\]/," ")
        clean_line_string = clean_line_string.gsub(/\d/," ")
        clean_line_string = clean_line_string.gsub(/,/," ")
        clean_line_string = clean_line_string.gsub(/"/," ")
        clean_line_string = clean_line_string.gsub(/\!/," ")
        clean_line_string = clean_line_string.gsub(/;/," ")
        clean_line_string = clean_line_string.gsub(/:/," ")
        clean_line_string = clean_line_string.gsub(/\//," ")
        clean_line_string = clean_line_string.gsub(/\[\s*CW/," ")
        clean_line_string = clean_line_string.gsub(/\./," ")
        clean_line_string = clean_line_string.gsub(/\[/," ")
        clean_line_string = clean_line_string.gsub(/\]/," ")
        clean_line_string = clean_line_string.gsub(/\?/," ")
        clean_line_string = clean_line_string.gsub(/\$/," ")
        clean_line_string = clean_line_string.gsub(/\#/," ")
        clean_line_string = clean_line_string.gsub(/\*/," ")
        clean_line_string = clean_line_string.gsub(/\^/," ")
        clean_line_string = clean_line_string.gsub(/\&/," ")
        clean_line_string = clean_line_string.gsub(/~/," ")
        clean_line_string = clean_line_string.gsub(/\{/," ")
        clean_line_string = clean_line_string.gsub(/\}/," ")
        clean_line_string = clean_line_string.gsub(/\\/," ")


        #now remove repetative white spaces
        clean_line_string = clean_line_string.squish

        #now make all lowercase
        clean_line_string = clean_line_string.downcase


        #now split the line into separate tokens
        arr_var_pieces = clean_line_string.split(/\s/)

        #now look through each token
        arr_var_pieces.each do |tk|


           #here's where I do a lookup, insert if new, and add an association (incrementing count)
          # as needed

          str_sql_safe_token = tk.gsub(/'/, "''")
          str_token_check_where = "concordance_entry_token LIKE '" + str_sql_safe_token + "'"
          this_token = ConcordanceEntry.where(str_token_check_where).first()
          if this_token
            int_token_id = this_token.id
          else
            #Create a new token entry
            this_new_token = ConcordanceEntry.new()
            this_new_token.concordance_entry_token = tk
            this_new_token.save
            int_token_id = this_new_token.id
            int_num_new_tokens = int_num_new_tokens + 1
          end

          #now update the concordance entry entry total for this token and edition
          str_concordance_pair_sql = "concordance_entry_id = " +  int_token_id.to_s + " AND digital_edition_id = " + params[:id]
          this_concordance_pair = DigitalEditionHasConcordanceEntryTotal.where(str_concordance_pair_sql).first()
          if this_concordance_pair
             int_total_entries = this_concordance_pair.entrycount
             int_total_entries = int_total_entries + 1
             this_concordance_pair.entrycount = int_total_entries
             this_concordance_pair.save
          else
            this_new_token_pair = DigitalEditionHasConcordanceEntryTotal.new()
            this_new_token_pair.entrycount = 1
            this_new_token_pair.digital_edition_id = params[:id]
            this_new_token_pair.concordance_entry_id =  int_token_id
            this_new_token_pair.save
          end

          #now create a concordance entry record
          this_new_concordance_entry = DigitalEditionHasConcordanceEntry.new()
          this_new_concordance_entry.digital_edition_id = params[:id]
          this_new_concordance_entry.concordance_entry_id = int_token_id
          this_new_concordance_entry.line_id = ln.id
          this_new_concordance_entry.save




          int_num_tokens = int_num_tokens + 1

        end
        int_num_lines = int_num_lines + 1
      end
    end

    bln_test = true

    if bln_test
      ret_hash = { :created => "yes", :success => "yes", :total_lines => int_num_lines.to_s, :total_tokens => int_num_tokens.to_s, :total_new_tokens => int_num_new_tokens}
      render json: ret_hash, status: :created
    else
      ret_hash = { :status => "success", :success => "yes"}
      render json: ret_hash, status: :unprocessable_entity
    end


  end
end
