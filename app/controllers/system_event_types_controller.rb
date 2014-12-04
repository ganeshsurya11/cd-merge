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
class SystemEventTypesController < ApplicationController
  # GET /system_event_types
  # GET /system_event_types.json
  def index
    @system_event_types = SystemEventType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @system_event_types }
    end
  end

  # GET /system_event_types/1
  # GET /system_event_types/1.json
  def show
    @system_event_type = SystemEventType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @system_event_type }
    end
  end

  # GET /system_event_types/new
  # GET /system_event_types/new.json
  def new
    @system_event_type = SystemEventType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @system_event_type }
    end
  end

  # GET /system_event_types/1/edit
  def edit
    @system_event_type = SystemEventType.find(params[:id])
  end

  # POST /system_event_types
  # POST /system_event_types.json
  def create
    @system_event_type = SystemEventType.new(params[:system_event_type])

    respond_to do |format|
      if @system_event_type.save
        format.html { redirect_to @system_event_type, notice: 'System event type was successfully created.' }
        format.json { render json: @system_event_type, status: :created, location: @system_event_type }
      else
        format.html { render action: "new" }
        format.json { render json: @system_event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /system_event_types/1
  # PUT /system_event_types/1.json
  def update
    @system_event_type = SystemEventType.find(params[:id])

    respond_to do |format|
      if @system_event_type.update_attributes(params[:system_event_type])
        format.html { redirect_to @system_event_type, notice: 'System event type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @system_event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_event_types/1
  # DELETE /system_event_types/1.json
  def destroy
    @system_event_type = SystemEventType.find(params[:id])
    @system_event_type.destroy

    respond_to do |format|
      format.html { redirect_to system_event_types_url }
      format.json { head :no_content }
    end
  end
end
