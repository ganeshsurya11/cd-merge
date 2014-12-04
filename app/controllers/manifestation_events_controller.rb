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
class ManifestationEventsController < ApplicationController
  # if this is an update or create call, then check the submitted date values
  # to make sure that they are 0000-00-00 instead of containing nil values
  # for blank date strings.  Look for me in /app/controlers/application_controller.rb
  before_filter :standardise_dates, :only => [ :create, :update ]

  # GET /manifestation_events
  # GET /manifestation_events.json
  def index
    @manifestation_events = ManifestationEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @manifestation_events }
    end
  end

  # GET /manifestation_events/1
  # GET /manifestation_events/1.json
  def show
    @manifestation_event = ManifestationEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @manifestation_event }
    end
  end

  # GET /manifestation_events/new
  # GET /manifestation_events/new.json
  def new
    @manifestation_event = ManifestationEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @manifestation_event }
    end
  end

  # GET /manifestation_events/1/edit
  def edit
    @manifestation_event = ManifestationEvent.find(params[:id])
  end

  # POST /manifestation_events
  # POST /manifestation_events.json
  def create
  
    @manifestation_event = ManifestationEvent.new(params[:manifestation_event])

    respond_to do |format|
      if @manifestation_event.save
        format.html { redirect_to @manifestation_event, notice: 'Manifestation event was successfully created.' }
        format.json { render json: @manifestation_event, status: :created, location: @manifestation_event }
      else
        format.html { render action: "new" }
        format.json { render json: @manifestation_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /manifestation_events/1
  # PUT /manifestation_events/1.json
  def update
    @manifestation_event = ManifestationEvent.find(params[:id])

    respond_to do |format|
      if @manifestation_event.update_attributes(params[:manifestation_event])
        format.html { redirect_to @manifestation_event, notice: 'Manifestation event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @manifestation_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manifestation_events/1
  # DELETE /manifestation_events/1.json
  def destroy
    @manifestation_event = ManifestationEvent.find(params[:id])
    @manifestation_event.destroy

    respond_to do |format|
      format.html { redirect_to manifestation_events_url }
      format.json { head :no_content }
    end
  end
  
end
