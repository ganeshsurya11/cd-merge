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
class DigitalEdition < ActiveRecord::Base
  belongs_to :item, :inverse_of => :digital_editions
  belongs_to :nav_category, :inverse_of => :digital_editions
  belongs_to :manifestation, :inverse_of => :digital_editions
  has_many :pages,  :inverse_of => :digital_editions
  has_many :lines,  :inverse_of => :digital_editions
  has_many :edition_teis,  :inverse_of => :digital_editions
  has_many :digital_edition_has_concordance_entries,  :inverse_of => :digital_editions
  has_many :digital_edition_has_concordance_entry_totals, :inverse_of => :digital_editions
  attr_accessible :id, :manifestation_id, :item_id, :digital_edition_active, :digital_edition_description, :digital_edition_local_title, :digital_edition_notes, :nav_category_id, :digital_edition_order, :digital_edition_variant_list_url
end
