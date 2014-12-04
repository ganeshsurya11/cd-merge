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
class Work < ActiveRecord::Base
  has_many :expressions,  :inverse_of => :work
  has_many :lines,  :inverse_of => :work
  has_many :transcriptions,  :inverse_of => :work
  attr_accessible :id, :work_name, :work_notes, :work_siglum, :work_viaf_id, :work_viaf_link, :work_frbr, :work_standard_title, :work_standard_title_source, :work_short_code

  def self.find_work_short_code(line_id)
  	work_short_code = Work.find_by_sql(%Q{ 
		select works.work_short_code from lines INNER JOIN digital_editions ON lines.digital_edition_id = digital_editions.id INNER JOIN manifestations ON manifestations.id  = digital_editions.manifestation_id INNER JOIN expressions_has_manifestations ON expressions_has_manifestations.manifestation_id = manifestations.id INNER JOIN expressions ON expressions.id =  expressions_has_manifestations .expression_id INNER JOIN works ON works.id = expressions.work_id
		where expressions_has_manifestations .expression_id = digital_editions.manifestation_id AND
		expressions_has_manifestations.expression_has_manifestation_primary = 1
		AND lines.id = #{line_id}
  	})
  	work_short_code[0].work_short_code
  end  

  def self.find_work_siglum(line_id)
  	work_siglum_code = Work.find_by_sql(%Q{ 
		select works.work_siglum from lines INNER JOIN digital_editions ON lines.digital_edition_id = digital_editions.id INNER JOIN manifestations ON manifestations.id  = digital_editions.manifestation_id INNER JOIN expressions_has_manifestations ON expressions_has_manifestations.manifestation_id = manifestations.id INNER JOIN expressions ON expressions.id =  expressions_has_manifestations .expression_id INNER JOIN works ON works.id = expressions.work_id
		where expressions_has_manifestations .expression_id = digital_editions.manifestation_id AND
		expressions_has_manifestations.expression_has_manifestation_primary = 1
		AND lines.id = #{line_id}
  	})
  	work_siglum_code[0].work_siglum
  end  
end
