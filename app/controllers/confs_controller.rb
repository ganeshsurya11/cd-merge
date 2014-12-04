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
class ConfsController < ApplicationController
  before_filter :authenticate_user!
  layout "admin"
  # GET /confs
  # GET /confs.json
  def index
    @confs = Conf.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @confs }
    end
  end

  # GET /confs/1
  # GET /confs/1.json
  def show
    @conf = Conf.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conf }
    end
  end

  # GET /confs/new
  # GET /confs/new.json
  def new
    @conf = Conf.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conf }
    end
  end

  # GET /confs/1/edit
  def edit
    @conf = Conf.find(params[:id])
  end

  # POST /confs
  # POST /confs.json
  def create
    @conf = Conf.new(params[:conf])

    respond_to do |format|
      if @conf.save
        format.html { redirect_to @conf, notice: 'Conf was successfully created.' }
        format.json { render json: @conf, status: :created, location: @conf }
      else
        format.html { render action: "new" }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /confs/1
  # PUT /confs/1.json
  def update
    @conf = Conf.find(params[:id])

    respond_to do |format|
      if @conf.update_attributes(params[:conf])
        format.html { redirect_to @conf, notice: 'Conf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @conf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confs/1
  # DELETE /confs/1.json
  def destroy
    @conf = Conf.find(params[:id])
    @conf.destroy

    respond_to do |format|
      format.html { redirect_to confs_url }
      format.json { head :no_content }
    end
  end
end
