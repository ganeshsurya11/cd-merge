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
class ConcordanceStopWordsController < ApplicationController
  # GET /concordance_stop_words
  # GET /concordance_stop_words.json
  def index
    @concordance_stop_words = ConcordanceStopWord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @concordance_stop_words }
    end
  end

  # GET /concordance_stop_words/1
  # GET /concordance_stop_words/1.json
  def show
    @concordance_stop_word = ConcordanceStopWord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @concordance_stop_word }
    end
  end

  # GET /concordance_stop_words/new
  # GET /concordance_stop_words/new.json
  def new
    @concordance_stop_word = ConcordanceStopWord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @concordance_stop_word }
    end
  end

  # GET /concordance_stop_words/1/edit
  def edit
    @concordance_stop_word = ConcordanceStopWord.find(params[:id])
  end

  # POST /concordance_stop_words
  # POST /concordance_stop_words.json
  def create
    @concordance_stop_word = ConcordanceStopWord.new(params[:concordance_stop_word])

    respond_to do |format|
      if @concordance_stop_word.save
        format.html { redirect_to @concordance_stop_word, notice: 'Concordance stop word was successfully created.' }
        format.json { render json: @concordance_stop_word, status: :created, location: @concordance_stop_word }
      else
        format.html { render action: "new" }
        format.json { render json: @concordance_stop_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /concordance_stop_words/1
  # PUT /concordance_stop_words/1.json
  def update
    @concordance_stop_word = ConcordanceStopWord.find(params[:id])

    respond_to do |format|
      if @concordance_stop_word.update_attributes(params[:concordance_stop_word])
        format.html { redirect_to @concordance_stop_word, notice: 'Concordance stop word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @concordance_stop_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concordance_stop_words/1
  # DELETE /concordance_stop_words/1.json
  def destroy
    @concordance_stop_word = ConcordanceStopWord.find(params[:id])
    @concordance_stop_word.destroy

    respond_to do |format|
      format.html { redirect_to concordance_stop_words_url }
      format.json { head :no_content }
    end
  end
end
