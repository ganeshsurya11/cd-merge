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
class VcTranscriptions < ActiveRecord::Base
  attr_accessible :vc_date_time_stamp, :vc_entitiy_id, :vc_id, :vc_item_id, :vc_page_id, :vc_transcription_file, :vc_transcription_notes, :vc_transcription_order, :vc_transcription_tei, :vc_transcription_text, :vc_user_action, :vc_user_id, :vc_user_name
end
