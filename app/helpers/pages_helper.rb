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
module PagesHelper

  def get_expression_siglum(page_id)
    logger.debug "PageID: "+page_id.to_s
    str_name = "***"
    @transcriptions = Transcription.where("page_id = ?", page_id).order("transcription_order DESC").last
    if (@transcriptions)
      if (@transcriptions.expression_id && @transcriptions.expression_id > 0)
        str_name = @transcriptions.expression.expression_siglum
        str_name = str_name.gsub(/E:/, "")
      end
    end
    return str_name
  end

  def get_expression_name(page_id)
    str_name = "No Associated Transcription"
    @transcriptions = Transcription.where("page_id = ?", page_id).order("transcription_order DESC").last
    if (@transcriptions)
      if (@transcriptions.expression_id && @transcriptions.expression_id > 0)
        str_name = @transcriptions.expression.expression_name
      end
    end
    return str_name
  end

end
