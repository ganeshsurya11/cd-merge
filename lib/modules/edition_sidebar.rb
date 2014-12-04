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

module EditionSidebar

  def makeBar()

    nav_cats = NavCategory.where("id IN (SELECT DISTINCT nav_category_id FROM digital_editions)").order("nav_category_order ASC");

    str_cat_string = ""
    bln_done_one = false
    nav_cats.each do |working_cat|
      if bln_done_one
        str_cat_string = str_cat_string + ","
      end
      str_cat_string = str_cat_string + " " + working_cat.id.to_s
      bln_done_one = true
    end

    if str_cat_string.length < 1
      str_cat_string = "0"
    end

    str_sql_where = "nav_category_id IN (" + str_cat_string + ") AND digital_edition_active LIKE 't'"
    # for mysql implementation use below
    # str_sql_where = "nav_category_id IN (" + str_cat_string + ") AND digital_edition_active LIKE 't'"

    has_editions = DigitalEdition.where(str_sql_where).order("nav_category_id ASC, digital_edition_order ASC");



    str_ret_code = "<td valign=\"top\">"
    str_ret_code = str_ret_code + "<div class=\"main_nav_cat_block\">"
    nav_cats.each do |nav_cat|
      str_ret_code = str_ret_code + "<div class=\"main_nav_cat_header\">" + nav_cat.nav_category_name + "</div>"
      has_editions.each do |has_edition|
         if has_edition.nav_category_id == nav_cat.id
           str_ret_code = str_ret_code + "<p class=\"main_nav_edition_link\"><a href=\"/ed/" + has_edition.id.to_s + "\">" + has_edition.digital_edition_local_title + "</a></p>";
         end
      end
      str_ret_code = str_ret_code + "<p>&nbsp;</p>"
    end
    str_ret_code = str_ret_code + "</div>"
    str_ret_code = str_ret_code + "</td>"

    return str_ret_code
  end

end