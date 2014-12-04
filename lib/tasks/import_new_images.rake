require 'rubygems'

# For requirements of this ticket please visit - https://carlstahmer.atlassian.net/browse/CEB-6

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


# rake utility:import_new_images

namespace :utility do 
  
  desc "Re-imports a fresh set of images for several of the digital editions"

	task :import_new_images => :environment do

    base_path = "#{Rails.root}"

    ###Step 1 : Map digital edition id to directory path
    digital_edition = map_digital_edition_id_to_path() ## Returns hash

    digital_edition.each_pair do |id, path|

      if File.directory?("#{base_path}#{path}")

        puts "Importing images for DigitalEdition: #{id} from path #{path}"

        ### Load a list of all .jpg filenames found in the image directory for the DigitalEdition.
        jpg_images = Dir["#{base_path}#{path}*.jpg"]

        ### Sort the list of filenames present in jpg_images array in the given format:
        sorted_jpg_images = jpg_images.map{|path| File.basename(path)}.sort_by { |j| [j[/.*[a-z].*\.jpg/] ? 0 : 1, j] }

        ### Select all records from Page where digital_edition_id: = id ORDER BY page_page
        page_images = Page.where(:digital_edition_id => id).order(:page_page)

        page_images.each_with_index do |page, index|
          image_file_name = sorted_jpg_images[index]
			  if image_file_name
				puts "Importing #{image_file_name} for page id: #{page.id}"
				file_path = File.open("#{base_path}#{path}#{image_file_name}")
				page.update_attribute(:page_image, file_path)
				page.update_attribute(:page_image, image_file_name)
			  else
				puts "JPG Image not present for page with id:#{page.id}"
			  end
        end

      else
        puts "Directory #{base_path}#{path} doesn't exisit."
      end

    end

	end

  ### Returns Digital Edition hash, where id is the each DE db id and value contains the actual dir path
  def map_digital_edition_id_to_path()
    digital_edition = {}

    digital_edition[1] = "/public/transfer_images/1633_A/"

    digital_edition[2] = "/public/transfer_images/1635_B/"

    digital_edition[3] = "/public/transfer_images/1669_G/"

    digital_edition[7] = "/public/transfer_images/DT1/"

    digital_edition[5] = "/public/transfer_images/H6/"

    digital_edition[6] = "/public/transfer_images/NY3/"

    digital_edition[4] = "/public/transfer_images/SP1/"

    digital_edition[8] = "/public/transfer_images/WN1/"

    digital_edition    
  end

end
