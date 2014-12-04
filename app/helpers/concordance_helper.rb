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
module ConcordanceHelper

  def render_multi_column_list(items, cols=4, edition)
      rendered = "<table class='concordance_table'><tr class='concordance_tr'>"
      bln_first_column = true
      if items.size > 0
        total_grouped_columns = items.size < cols ? cols : items.size/cols
        items.in_groups_of(total_grouped_columns) do |group|
          if bln_first_column
            str_class = "narrow-col-first"
          else
            str_class = "narrow-col-other"
          end
          rendered = rendered + "<td class='" + str_class + "'><ul class='concordance_list'>"
          group.each do |item|
            if item
              rendered = rendered + "<li class='concordance_li'><a href=\"/edition/" + edition.to_s + "/concordance/" + item.id.to_s + "\">" + item.concordance_entry_token + " (" + get_entry_count(item.id, edition).to_s + ")</a></li>"
            end
          end
          rendered = rendered + "</ul></td>"
          bln_first_column = false
        end
      else
        rendered = rendered + "<td align=\"center\"><h1>No concordance has been generated for this edition.</h1></td>"
      end
      rendered = rendered + "</tr></table>"
      return rendered
  end

  def get_entry_count(concordance_item, edition_id)

    str_sql_string = "concordance_entry_id = " +  concordance_item.to_s  + " AND digital_edition_id = " + edition_id.to_s
    item_count = DigitalEditionHasConcordanceEntryTotal.where(str_sql_string).first
    if item_count
       retnum =  item_count.entrycount
    else
       retnum = 0
    end

    return retnum

  end

  def bold_item(str_line, str_token)
    str_ret_line = str_line.gsub(/<.*?>/i, '')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\s+)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(^#{str_token}\s+)/i, '<span class="concordance_bold_span">\1</span>\2')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token}$)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\.)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\?)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(,)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\!)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\))/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\(#{str_token})(\))/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\(#{str_token})(\s+)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\})/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\{#{str_token})(\s+)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\{#{str_token})(\})/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\])/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\[#{str_token})(\s+)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\[#{str_token})(\])/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(~)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\")/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\"#{str_token})(\s+)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/(\"#{str_token})(\")/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(:)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(;)/i, '\1<span class="concordance_bold_span">\2</span>\3')
    str_ret_line = str_ret_line.gsub(/([\s|,|;|:]+)(#{str_token})(\*)/i, '\1<span class="concordance_bold_span">\2</span>\3')


    return str_ret_line
  end

  def get_expression_siglum(exp_id)
    rs_expression = Expression.find(exp_id)
    if rs_expression
      str_siglum =  rs_expression.expression_siglum
      str_siglum = str_siglum.gsub(/E:/i, '')
    else
      str_siglum = UNK
    end
    return str_siglum
  end

  def right_adjust_elem(elem)
    if elem.is_a?(String) && elem.length < 3
      elem  = elem.rjust(3, '0')
    elsif elem.is_a?(Integer) && elem.to_s.length < 3
      elem = "%03d" % elem
    else
      elem
    end
  end

  def make_concordance_line_row(str_siglum, str_dv_code, str_work_siglum, str_line_designator, str_line, int_page_id, str_token)

    str_siglum ||= ""
    str_dv_code ||= ""
    str_work_siglum ||= "" 
    str_line_designator ||= ""
    str_line ||= ""

    str_link = "<a href=\"/viewport/" + int_page_id.to_s + "/" + str_token + "\">"

    #do siglum cell
    str_ret_string = "<td class=\"concordance_line_siglum\">"
    str_ret_string = str_ret_string + str_link +  str_siglum + "</a>"
    str_ret_string = str_ret_string + "</td>"

    #do code cell
    str_ret_string = str_ret_string + "<td class=\"concordance_line_code\">"
    str_ret_string = str_ret_string + str_link +  str_dv_code + "." + str_work_siglum + "." + str_line_designator + "</a>"
    str_ret_string = str_ret_string + "</td>"


    #do line cell
    str_ret_string = str_ret_string + "<td class=\"concordance_line_line\">"
    str_ret_string = str_ret_string + str_link +  str_line + "</a>"
    str_ret_string = str_ret_string + "</td>"


    return str_ret_string
  end



end