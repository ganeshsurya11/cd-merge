require 'rubygems'
require 'RMagick'

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


# rake utility:make_med_thumb

namespace :utility do
  desc "Create medium_thumb images from original images"
	task :make_med_thumb => :environment do
    dir_path = "#{Rails.root}/public/uploads/page/page_image/"
    if directory_exists?(dir_path)
      puts "Creating medium thumb images from original images..."
  		Dir.foreach(dir_path) do |item|
        if File.directory?("#{dir_path}#{item}")
          Dir.foreach("#{dir_path}#{item}") do |page_image|
            if page_image.include?("thumb") && !page_image.include?("medium_thumb")
              orig_file_name = page_image.sub "thumb_", ""
              unless File.file?("#{dir_path}#{item}/medium_thumb_#{orig_file_name}") 
                puts "Creating medium thumb image for #{orig_file_name}."
                img = Magick::Image.read("#{dir_path}#{item}/#{orig_file_name}")[0]
                img.write("#{dir_path}#{item}/medium_thumb_#{orig_file_name}")
              end
            end
          end
        end
  		end
      puts "Medium thumb images created successfully."
    else
      puts "Uploads Directory doesn't exisit."
    end
	end

	def directory_exists?(directory)
    File.directory?(directory)
	end

end
