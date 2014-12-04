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
class ConcordanceController < ApplicationController
  #include /lib/modules/edition_base_links.rb
  include EditionBaseLinks

  #set the layout
  layout "application"


  # GET /edition/1/concordance

  def showedition

    @edition = params[:id]

    # @concordance_entries = ConcordanceEntry.where("digital_edition_id = ?", params[:id]).order("concordance_entry_token ASC").page( params[:page]).per(20)

    # @concordance_entries = DigitalEditionHasConcordanceEntryTotal.joins(ConcordanceEntry).where("digital_edition_id = ?", params[:id]).order("concordance_entry_token ASC").page( params[:page]).per(20)

    # @concordance_entries = DigitalEditionHasConcordanceEntryTotal.joins("JOIN concordance_entries ON concordance_entries.id = digital_edition_has_concordance_entry_totals.id").where("digital_edition_id = ?", params[:id]).order("concordance_entry_token").page( params[:page]).per(20)

    @concordance_entries = ConcordanceEntry.joins(:digital_edition_has_concordance_entry_totals).where("digital_edition_id = ?", params[:id]).order("concordance_entry_token").page( params[:page]).per(68)

    #setup navlinks
    @edition_nav_links =  makeLinks(params[:id])

    #setup title link
    @title_nav_links = makeTitleLink(@edition)

    render :show

  end

  # GET /edition/1/concordance/1

  def showeditem

    @edid =  params[:id]
    @concid =  params[:it]

    #setup title link
    @title_nav_links = makeTitleLink(@edid)

    rs_concordance_entry  = ConcordanceEntry.find(@concid)
    str_sql_safe_token = rs_concordance_entry.concordance_entry_token.gsub(/'/i, "'")
    @concordance_token = rs_concordance_entry.concordance_entry_token

    #str_lines_where = "line_tei LIKE '" + rs_concordance_entry.concordance_entry_token + " %' OR line_tei LIKE '% " + rs_concordance_entry.concordance_entry_token + " %' OR line_tei LIKE '% " + rs_concordance_entry.concordance_entry_token + "' AND digital_edition_id = " +  @edid
    #@rs_concordance_lines = Line.where(str_lines_where).order("line_expression_order ASC").page( params[:page]).per(20)

    # "JOIN lines ON lines.id = digital_edition_has_concordance_entries.line_id"
    str_entries_where = "digital_edition_has_concordance_entries.digital_edition_id = " + @edid + " AND digital_edition_has_concordance_entries.concordance_entry_id = " + @concid
    @rs_concordance_lines = DigitalEditionHasConcordanceEntry.joins(:line).where(str_entries_where).order("lines.line_digital_edition_order ASC").page( params[:page]).per(20)


    rs_edition = DigitalEdition.find(@edid)
    rs_manifestation = Manifestation.find(rs_edition.manifestation_id)
    rs_expression_manifestation = ExpressionsHasManifestations.where("manifestation_id = ?", rs_manifestation.id).first
    rs_expression = Expression.find(rs_expression_manifestation.expression_id)
    @rs_work = Work.find(rs_expression.work_id)



    #get the navlinks
    @edition_nav_links =  makeLinks(@edid)

    render :view

  end


end
