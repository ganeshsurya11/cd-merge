require 'rubygems'
require 'csv'

# Jira ticket  - https://carlstahmer.atlassian.net/browse/CEB-13

### Before Running this rake task, Make sure 
### migration file 20140809103215_add_work_short_code_to_works.rb is executed

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


# rake utility:update_works_table

namespace :utility do
  desc "Update Work Siglum and Short Code values"
    task :update_works_table => :environment do

      current_csv_file_path = "#{Rails.root}/current.csv"

      new_csv_file_path = "#{Rails.root}/new.csv"

      begin

        ## Updated works tables with the new values from current.csv file
        CSV.read(current_csv_file_path, :headers => true).each do |row|
          # Assumed headers from CSV file - ["id", "work_siglum", "short_code"]
          puts "Updating Work Record ##{row["id"]}"

          ##  Updates the "work_siglum" field to the value in the csv file
          ##  Update the value in the "short_code" column of the csv file into the "work_short_code" field of the database.
          Work.find(row["id"]).update_attributes({:work_siglum => row["work_siglum"], :work_short_code => row["short_code"]})
        end

        ## Insert new records in works table from new.csv table
        new_work_arr = []
        CSV.read(new_csv_file_path, :headers => true).each do |row|
          puts "Creating new record with work name #{row["work_name"]}"
          new_work_arr << {:work_name => row["work_name"], :work_siglum => row["work_siglum"], :work_short_code => row["work_short_code"], :work_notes => row["work_notes"], :work_frbr => row["work_frbr"]}
        end
        Work.create(new_work_arr)
      rescue Exception => ex
        puts "Error : "+ ex.message
      end

    end
end
