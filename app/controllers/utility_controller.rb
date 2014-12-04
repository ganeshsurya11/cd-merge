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

class UtilityController < ApplicationController
  include LineProcessing
  require 'RMagick'


  def update_lines
    @dig_ed_id = params[:id]
    str_sql_pages_where = "digital_edition_id"
    @pages = Page.where("digital_edition_id = ?", @dig_ed_id).order(:page_page)
    @int_pages_done = 0
    @pages.each do |this_page|


      arr_prev_page_data = get_prev_page_last_line_data(this_page.id)
      do_page_lines(arr_prev_page_data[0], arr_prev_page_data[1], arr_prev_page_data[2], this_page.id)
      dopagetei(this_page.id)

      @int_pages_done = @int_pages_done + 1

    end

    render :show

  end

  def make_medium_thumb
    @no_of_images_converted = 0
    @error_message = nil
    dir_path = "#{Rails.root}/public/uploads/page/page_image/"
    if directory_exists?(dir_path)
      logger.debug "Creating medium thumb images from original images..."
      Dir.foreach(dir_path) do |item|
        if File.directory?("#{dir_path}#{item}")
          Dir.foreach("#{dir_path}#{item}") do |page_image|
            if page_image.include?("thumb") && !page_image.include?("medium_thumb")
              orig_file_name = page_image.sub "thumb_", ""
              unless File.file?("#{dir_path}#{item}/medium_thumb_#{orig_file_name}")
                @no_of_images_converted += 1 
                logger.debug "Creating medium thumb image for #{orig_file_name}."
                img = Magick::Image.read("#{dir_path}#{item}/#{orig_file_name}")[0]
                img.write("#{dir_path}#{item}/medium_thumb_#{orig_file_name}")
              end
            end
          end
        end
      end
      logger.debug "Medium thumb images created successfully."
    else
      @error_message = "Uploads Directory doesn't exisit."
      logger.debug @error_message
    end    
  end

  private

  def directory_exists?(directory)
    File.directory?(directory)
  end  

end