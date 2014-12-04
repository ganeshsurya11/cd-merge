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
class ItemEventsController < ApplicationController
  # if this is an update or create call, then check the submitted date values
  # to make sure that they are 0000-00-00 instead of containing nil values
  # for blank date strings.  Look for me in /app/controlers/application_controller.rb
  before_filter :standardise_dates, :only => [ :create, :update ]

  # GET /item_events
  # GET /item_events.json
  def index
    @item_events = ItemEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_events }
    end
  end

  # GET /item_events/1
  # GET /item_events/1.json
  def show
    @item_event = ItemEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_event }
    end
  end

  # GET /item_events/new
  # GET /item_events/new.json
  def new
    @item_event = ItemEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_event }
    end
  end

  # GET /item_events/1/edit
  def edit
    @item_event = ItemEvent.find(params[:id])
  end

  # POST /item_events
  # POST /item_events.json
  def create
    @item_event = ItemEvent.new(params[:item_event])

    respond_to do |format|
      if @item_event.save
        format.html { redirect_to @item_event, notice: 'Item event was successfully created.' }
        format.json { render json: @item_event, status: :created, location: @item_event }
      else
        format.html { render action: "new" }
        format.json { render json: @item_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /item_events/1
  # PUT /item_events/1.json
  def update
    @item_event = ItemEvent.find(params[:id])

    respond_to do |format|
      if @item_event.update_attributes(params[:item_event])
        format.html { redirect_to @item_event, notice: 'Item event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_events/1
  # DELETE /item_events/1.json
  def destroy
    @item_event = ItemEvent.find(params[:id])
    @item_event.destroy

    respond_to do |format|
      format.html { redirect_to item_events_url }
      format.json { head :no_content }
    end
  end
end
