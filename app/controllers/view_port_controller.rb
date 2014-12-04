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
class ViewPortController < ApplicationController
  #include /lib/modules/edition_base_links.rb
  include EditionBaseLinks

  require 'xml/xslt'

  #set the layout
  layout "application"

  # GET /viewport/1
  # GET /viewport/1.json
  def show
    if params[:token]
      int_do_highlight = 1
      str_token = params[:token]
    else
      int_do_highlight = 0
      str_token = ""
    end


    display_page(params[:id], int_do_highlight, str_token)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end

  end

  # GET '/viewport/:parent/page/:page'
  # GET /viewport/:parent/page/:page.json'
  def getpage

    str_sql_page_before_where = "digital_edition_id = " + params[:parent] + " AND page_page = " + params[:page]
    this_page = Page.where(str_sql_page_before_where).order("page_page ASC").first
    if this_page
       this_page_id = this_page.id
    else
      this_page_id = 0
    end

    display_page(this_page_id.to_s, 0, "")

    render :show

  end

  def display_page(this_id, int_highlight, str_token_for_highlight)


    #load the page record
    @page = Page.find(this_id)

    #load the digital_edition_id that this page belongs to
    @diged = @page.digital_edition_id

    #load the title for the digital edition
    @de_title = @page.digital_edition.digital_edition_local_title

    #get the page number for this page
    @int_page_value = @page.page_page

    #setup the title link
    @title_nav_links = makeTitleLink(@diged)

    @str_page_value =  @int_page_value.to_s

    logger.debug "Page Value: "+@str_page_value

    #get before and after pages
    str_sql_page_before_where = "digital_edition_id = " + @diged.to_s
    rs_edition_pages = Page.where(str_sql_page_before_where).order("page_page ASC")
    @first_page = nil
    @before_page = nil
    @after_page = nil
    @last_page = nil
    bln_record_next = true
    bln_record_first = true
    rs_edition_pages.each do |this_page|
      if bln_record_first
        @first_page = this_page.page_page
      end
      if this_page.page_page < @int_page_value
        @before_page = this_page.id
      elsif (this_page.page_page > @int_page_value && bln_record_next)
        @after_page = this_page.id
        bln_record_next = false
      end
      @last_page =  this_page.page_page
      bln_record_first = false
    end

    #get the transcription info for the page so I can extract titles of poems that appear on the page
    str_sql_trans_where = "transcriptions.page_id = " + this_id
    @transcriptions = Transcription.joins(:expression).where(str_sql_trans_where).order("transcriptions.transcription_order ASC")

    #get the lines that belong to this edition
    str_sql_lines_where = "page_id = " + this_id
    @lines = Line.where(str_sql_lines_where).order("line_page_order ASC")

    #format the lines into to transformed TEI
    @page_content = "<TEI>"
    @lines.each do |ln|
      if ln.line_tei && ln.line_tei.length > 0

        str_this_line =  ln.line_tei

        if int_highlight > 0

          str_do_line = make_highlight(str_this_line, str_token_for_highlight)

        else

          str_do_line = str_this_line

        end

        @page_content = @page_content + str_do_line
      end
    end
    @page_content = @page_content + "</TEI>"


    #do xslt transformation
    begin
      xslt = XML::XSLT.new()
      xslt.xml = @page_content
      xslt.xsl = "./app/assets/xslt/page.xsl"
      out = xslt.serve()
    rescue
      logger.debug "TEI Parsing Error: #{$!}"
      out = "[TEI Not Valid]"
    end

    if out
      @formatted_page = out.gsub('<?xml version="1.0"?>', '')
    else
      @formatted_page = "[No Transcription Information Available]"
    end


    #get the navlinks
    @edition_nav_links =  makeLinks(@diged)

  end

  def make_highlight(str_line, str_token)

    line_variant_text = str_line.gsub(/(#{str_token})/i,'<hi style="color:red">\1</hi>')

    return line_variant_text



  end

  #this is copied over just to serve as an example of a more complex regex that
  #deals with line replacement.  Can't use this directly because it delets out all
  #the markup before processing the line.
  def bold_item_example(str_line, str_token)
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


end