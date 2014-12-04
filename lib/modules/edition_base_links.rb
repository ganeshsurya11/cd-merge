# encoding: utf-8

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


module EditionBaseLinks

  def makeLinks(this_id)

    #need to lookup first page for this edition
    str_sql_page_before_where = "digital_edition_id = " + this_id.to_s
    rs_edition_pages = Page.where(str_sql_page_before_where).order("page_page ASC").first

    #lookup the composite list of variants link for this edition
    rs_digital_edition = DigitalEdition.find(this_id)
    str_composite_link = rs_digital_edition.digital_edition_variant_list_url


    str_ret_code = "<div id=\"footernavcontainer\">"
    str_ret_code = str_ret_code + "<ul id=\"footernavlist\">"
    str_ret_code = str_ret_code + "<li><a href=\"/ed/" + this_id.to_s + "\">Edition Home</a> </li>"
    str_ret_code = str_ret_code + "<li><a href=\"/edition/" + this_id.to_s + "/toc\">Index of Poems</a> </li>"
    str_ret_code = str_ret_code + "<li><a href=\"/viewport/" + rs_edition_pages.id.to_s + "\">Facsimile Edition</a> </li>"
    str_ret_code = str_ret_code + "<li><a href=\"/edition/" + this_id.to_s + "/concordance\">Concordance</a></li>"

    if str_composite_link && (str_composite_link.length > 0)
      str_ret_code = str_ret_code + "<li><a href=\"" + str_composite_link + "\">Composite List of Variants</a></li>"
    end
    str_ret_code = str_ret_code + "</ul>"
    str_ret_code = str_ret_code + "</div>"
    return str_ret_code
  end

  def makeTitleLink(this_id)
    this_edition = DigitalEdition.find(this_id)
    if this_edition
      this_manifestation = Manifestation.find(this_edition.manifestation_id)
      str_siglum = this_manifestation.manifestation_siglum
      str_siglum = str_siglum.gsub(/M:/, "").strip
      str_ret = "<div class=\"ed_title_link\"><a href=\"/ed/" + this_id.to_s + "\">" + str_siglum + ": " + this_edition.digital_edition_local_title + "</a></div>"
    else
      str_ret = ""
    end
    return str_ret
  end


end