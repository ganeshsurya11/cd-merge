require 'rubygems'

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


# rake utility:modify_expression_siglum_values

namespace :utility do
  desc "Removing 'E:' prefix from Expression.expression_siglum field values"
	task :modify_expression_siglum_values => :environment do
        Expression.all.each do |exp|
            if exp.expression_siglum.include?("E:")
                old_exp_siglum_val = exp.expression_siglum
                new_exp_siglum_val = exp.expression_siglum.gsub('E:', '')
                puts "Updating Expression siglumn values from #{old_exp_siglum_val} to #{new_exp_siglum_val}"
                exp.update_attribute(:expression_siglum, new_exp_siglum_val)
            end
        end
	end
end
