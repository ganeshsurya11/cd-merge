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
class SessionsController < ApplicationController
  layout "admin"
  
  def new
  
    @user = User.new
	@notice = params[:notice]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
    
  end

  def create
  	user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # redirect_to root_url, :notice => "Logged in!"
      respond_to do |format|
      	format.html { redirect_to "/admin"}
      	format.json { render json: @user, status: :created, location: @user }
      end
    else
      # flash.now.alert = "Invalid email or password"
      # render "new"
      respond_to do |format|
      	format.html { redirect_to action: "new", notice: 'Login Failed: Incorrect Username/Password Pair!' }
      	format.json { render json: @user, status: :failed, location: @user }
      end
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to action: "new", :notice => "Logged out!"
  end
end

