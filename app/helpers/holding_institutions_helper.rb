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
module HoldingInstitutionsHelper

  def get_hi_show_link(this_id, referer_id)
    # http://localhost:3000/holding_institutions/:this_id/:referer_id
    str_link = "/holding_institutions/"+this_id.to_s+"/ref/"+referer_id.to_s
    return str_link
  end

  def get_hi_edit_link(this_id, referer_id)
    # http://localhost:3000/holding_institutions/:id/edit/referer_id
    str_link = "/holding_institutions/"+this_id.to_s+"/edit/"+referer_id.to_s
    return str_link
  end

  def get_holding_institutions_ref_path(referer_id)
     if (referer_id && referer_id.to_i > 0)
        str_ret_link = "/holding_institutions/"+referer_id+"/index"
     else
       str_ret_link = "/holding_institutions"
     end
     return str_ret_link
  end



end
