require 'rubygems'

# Jira Ticket reference url - https://carlstahmer.atlassian.net/browse/CEB-12

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


# rake utility:remove_duplicate_records

namespace :utility do
  desc "Removing duplicate data from three difference tables"
	task :remove_duplicate_records => :environment do

    Id_hash  = {50 => 43, 67 => 68, 76 => 77, 98 => 100, 99 => 100, 102 => 104, 108 => 166, 116 => 115, 118 => 111,
      123 => 124,152 => 154, 155 => 153, 203 => 204, 224 => 225}

    ["expressions", "lines", "transcriptions"].each do |table|
      Id_hash.each_pair do |key, val|
        sql_string = %Q(UPDATE #{table} SET work_id = #{val} WHERE work_id = #{key})
        p sql_string
        ActiveRecord::Base.connection.execute(sql_string)
      end
    end

    puts "\n"
    delete_sql_string = %Q(DELETE FROM works WHERE id IN #{Id_hash.keys.to_s.gsub("[","(").gsub("]",")")})
    puts delete_sql_string
    ActiveRecord::Base.connection.execute(delete_sql_string)
  end
end
