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

module LineProcessing


  #####################################################################################
  # tree traversing and building routines used to build tei from the lines controller #
  # and also build page text during submission of digital edition page building       #
  #####################################################################################
  
  # walk the lines tree and process according to int_type
  # 0 = write page lines for edition to db - default
  # 1 = make edition TEI
  # 2 = make expression TEI -- not yet implemented
  def dowalk(digital_edition_id, int_type, host)

  	retrun_line = "ERROR:  NOTHING WAS PROCESSED!"

  	
  	int_pages_processed = 0
  	int_expressions_processed = 0
  	
  	if (int_type == 1)
  		arr_digital_edition_tei_lines = Array.new
  	elsif (int_type == 2)
  		arr_expression_tei_lines = Array.new
  	else
  		arr_page_tei_lines = Array.new
  		int_type = 0
    end

    if (int_type == 0)
      @lines = Line.where("page_id = ?", digital_edition_id).order("line_page_order ASC")
    else
      @lines = Line.where("digital_edition_id = ?", digital_edition_id).order("page_id ASC, line_page_order ASC")
    end
  	
 
  	int_open_ital = 0
  	int_open_boldface = 0
  	int_open_superscript = 0
  	int_open_subscript = 0
  	int_open_small_caps = 0
  	int_open_underline = 0
  	int_open_strike = 0
  	str_space_above = ""
  	int_working_page_id = 0
  	int_working_expression_id = 0
  	
  	int_line_iteration = 0
  	
  	int_work_id = 0
   	int_expression_id = 0
   	int_transcription_id = 0
   	int_page_id = 0
  	
  	@lines.each do |line|

      # get base text line
      line_base_text = line.line_variant_version
      line_id = line.id
      int_work_id = line.work_id
      int_expression_id = line.expression_id
      int_transcription_id = line.transcription_id
      int_page_id = line.page_id
      line_designator = line.line_designator
      str_page_facs = line.page.page_image

      if !line_base_text
        line_base_text = " "
      end

      #logger.debug "Processing Line "+line_base_text

  	
  		if (int_line_iteration == 0)
			int_working_page_id = int_page_id
			int_working_expression_id = int_expression_id
   	 		str_sub_work_tei = ""
  		end


   	 	if (int_page_id != int_working_page_id)
   	 		if (int_type == 0)
   	 			update_page_tei(arr_page_tei_lines, int_working_page_id)
   	 			int_pages_processed = int_pages_processed + 1
   	 			arr_page_tei_lines.clear
   	 		end
   	 		int_working_page_id = int_page_id
   	 	end   	 	
   	 	
   	 	if (int_expression_id != int_working_expression_id)
			if (int_type == 2)
   	 			update_expression_tei(arr_expression_tei_lines, int_working_expression_id)
   	 			int_expressions_processed = int_expressions_processed + 1
   	 			arr_expression_tei_lines.clear
   	 		end
   	 		int_working_expression_id = int_expression_id
   	 	end
   	 	
   	 	
   	 	if ( line_base_text =~ /%H.*%N/ ) 
   	 		str_temp_height_string = line_base_text
   	 		str_temp_height_string = str_temp_height_string.gsub(/%H/,"")
   	 		str_temp_height_string = str_temp_height_string.gsub(/%N/,"")
   			str_space_above = str_temp_height_string
   	 	else
   	 	
   	 		#fix ampersands in text to make tei compliant
			  str_entity_safe_line = line_base_text.gsub(/&/, "&amp;")
   	 	
        # convert special characters to hex codes
        line_converted_text = convert_special_chars(str_entity_safe_line);

        # check for centering markup
        str_line_style = "text-align: left;"
        if ( line_converted_text =~ /%X/ )
          str_line_style = "text-align: center;"
          line_converted_text = line_converted_text.gsub(/%X/,"")
        end

        # check for a space line from above
        if (str_space_above.length > 0)
          int_space_above = str_space_above.to_i
          int_space_above = int_space_above * 0.75
          str_final_space_above = int_space_above.to_s
          str_line_style = str_line_style + " margin-top:" + str_final_space_above + "px;"
        else
          str_line_style = str_line_style + " margin-top:3px;"
        end
			
        # convert variant rendering from donne syntax to tei
        line_variant_text = do_variant_tei(line_converted_text)


        # do carry-over open tags from previous line
        if int_open_ital > 0
          while int_open_ital > 0  do
            line_variant_text = "<hi style=\"font-style:italic\">" + line_variant_text
            int_open_ital = int_open_ital - 1
          end
        end
        if int_open_boldface > 0
          while int_open_boldface > 0  do
            line_variant_text = "<hi style=\"font-style:bold\">" + line_variant_text
            int_open_boldface = int_open_boldface - 1
          end
        end
        if int_open_superscript > 0
          while int_open_superscript > 0  do
            line_variant_text = "<hi style=\"font-size:xx-small; vertical-align:top;\">" + line_variant_text
            int_open_superscript = int_open_superscript - 1
          end
        end
        if int_open_subscript > 0
          while int_open_subscript > 0  do
            line_variant_text = "<hi style=\"font-size:xx-small; vertical-align:bottom;\">" + line_variant_text
            int_open_subscript = int_open_subscript - 1
          end
        end
        if int_open_small_caps > 0
          while int_open_small_caps > 0  do
            line_variant_text = "<hi style=\"font-variant:small-caps;\">" + line_variant_text
            int_open_small_caps = int_open_small_caps - 1
          end
        end
        if int_open_underline > 0
          while int_open_underline > 0  do
            line_variant_text = "<hi style=\"text-decoration:underline\">" + line_variant_text
            int_open_underline = int_open_underline - 1
          end
        end
        if int_open_strike > 0
          while int_open_strike > 0  do
            line_variant_text = "<hi style=\"text-decoration:line-through\">" + line_variant_text
            int_open_ital = int_open_ital - 1
          end
        end
			
			
			
        # convert itals to tei
        int_ital_up_count = line_variant_text.scan(/%1/).size
        int_open_ital = int_open_ital + int_ital_up_count
        line_variant_text = line_variant_text.gsub(/%1/,"<hi style=\"font-style:italic\">")
        int_ital_down_count = line_variant_text.scan(/%2/).size
        int_open_ital = int_open_ital - int_ital_down_count
        line_variant_text = line_variant_text.gsub(/%2/,"</hi>")

        # convert boldface to tei
        int_bold_up_count = line_variant_text.scan(/%3/).size
        int_open_boldface = int_open_boldface + int_bold_up_count
        line_variant_text = line_variant_text.gsub(/%3/,"<hi style=\"font-style:bold\">")
        int_bold_down_count = line_variant_text.scan(/%4/).size
        int_open_boldface = int_open_boldface - int_bold_down_count
        line_variant_text = line_variant_text.gsub(/%4/,"</hi>")

        # convert superscript to tei
        int_superscript_up_count = line_variant_text.scan(/%5/).size
        int_open_superscript = int_open_superscript + int_superscript_up_count
        line_variant_text = line_variant_text.gsub(/%5/,"<hi style=\"font-size:xx-small; vertical-align:top;\">")
        int_superscript_down_count = line_variant_text.scan(/%6/).size
        int_open_superscript = int_open_superscript - int_superscript_down_count
        line_variant_text = line_variant_text.gsub(/%6/,"</hi>")

        # convert subscript to tei
        int_subscript_up_count = line_variant_text.scan(/%7/).size
        int_open_subscript = int_open_subscript + int_subscript_up_count
        line_variant_text = line_variant_text.gsub(/%7/,"<hi style=\"font-size:xx-small; vertical-align:bottom;\">")
        int_supscript_down_count = line_variant_text.scan(/%8/).size
        int_open_subscript = int_open_subscript - int_supscript_down_count
        line_variant_text = line_variant_text.gsub(/%8/,"</hi>")

        # convert small caps to tei
        int_smallcaps_up_count = line_variant_text.scan(/%9/).size
        int_open_small_caps = int_open_small_caps + int_smallcaps_up_count
        line_variant_text = line_variant_text.gsub(/%9/,"<hi style=\"font-variant:small-caps;\">")
        int_smallcaps_down_count = line_variant_text.scan(/%0/).size
        int_open_small_caps = int_open_small_caps - int_smallcaps_down_count
        line_variant_text = line_variant_text.gsub(/%0/,"</hi>")

        # convert underline to tei
        int_underline_up_count = line_variant_text.scan(/%J/).size
        int_open_underline = int_open_underline + int_underline_up_count
        line_variant_text = line_variant_text.gsub(/%J/,"<hi style=\"text-decoration:underline\">")
        int_underline_down_count = line_variant_text.scan(/%K/).size
        int_open_underline = int_open_underline - int_underline_down_count
        line_variant_text = line_variant_text.gsub(/%K/,"</hi>")

        # convert strikethrough to tei
        int_strike_up_count = line_variant_text.scan(/%Y/).size
        int_open_strike = int_open_strike + int_strike_up_count
        line_variant_text = line_variant_text.gsub(/%Y/,"<hi style=\"text-decoration:line-through\">")
        int_strike_down_count = line_variant_text.scan(/%Z/).size
        int_open_strike = int_open_strike - int_strike_down_count
        line_variant_text = line_variant_text.gsub(/%Z/,"</hi>")


        # close any open tags
        if int_open_ital > 0
          int_ital_inc = int_open_ital
          while int_ital_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_ital_inc = int_ital_inc - 1
          end
        end
        if int_open_boldface > 0
          int_bold_inc = int_open_boldface
          while int_bold_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_bold_inc = int_bold_inc - 1
          end
        end
        if int_open_superscript > 0
          int_superscript_inc = int_open_superscript
          while int_superscript_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_superscript_inc = int_superscript_inc - 1
          end
        end
        if int_open_subscript > 0
          int_subscript_inc = int_open_subscript
          while int_subscript_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_subscript_inc = int_subscript_inc - 1
          end
        end
        if int_open_small_caps > 0
          int_smallcap_inc = int_open_small_caps
          while int_smallcap_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_smallcap_inc = int_smallcap_inc - 1
          end
        end
        if int_open_underline > 0
          int_underline_inc = int_open_underline
          while int_underline_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_underline_inc = int_underline_inc - 1
          end
        end
        if int_open_strike > 0
          int_strike_inc = int_open_strike
          while int_strike_inc > 0  do
            line_variant_text = line_variant_text + "</hi>"
            int_strike_inc = int_strike_inc - 1
          end
        end

        # put on line tags
        line_designator = line_designator.gsub(/\n/, "")
        line_variant_text = "<l n=\"" + line_designator + "\" style=\"" + str_line_style + "\">" + line_variant_text + "</l>"
        # logger.debug "Variant Text: "+line_variant_text



        # setup the line array to send to various functions
        arr_line_array = [line_variant_text, line_designator, int_page_id, int_expression_id, int_work_id, str_page_facs]


  			  			
  			# add to page tei array and update line table
  			if (int_type == 0)
          #logger.debug "Adding to lines array"
  				arr_page_tei_lines.push(arr_line_array)
  				# write line record
  				# update_line_tei(line_variant_text, line_id)
  			end
  			
  			# add to expression tei array
  			if (int_type == 2)
  				arr_expression_tei_lines.push(arr_line_array)
  			end
  			
  			# add to digital edition tei array
  			if (int_type == 1)
  				arr_digital_edition_tei_lines.push(arr_line_array)
  			end
			
        # add a newline
        # retrun_line = retrun_line + line_variant_text + "\n"

        # clear the str_space_above variable
        str_space_above = ""

        #update the  line record
        save_lines = Line.find(line_id)
        save_lines.line_tei = line_variant_text
        save_lines.save
			
		end
		
   	 	int_line_iteration = int_line_iteration + 1;

	end
  	
  	
  	if (int_type == 0)
      #logger.debug "Line Array Size: "+arr_page_tei_lines.size.to_s
      retrun_line = update_edition_tei(arr_page_tei_lines, digital_edition_id, host)
      #logger.debug "retrun_line: "+retrun_line
  		# retrun_line = "Processed " + int_pages_processed.to_s + " pages."
  	elsif (int_type == 1)
  		# make the digital edition TEI
  		retrun_line = update_edition_tei(arr_digital_edition_tei_lines, digital_edition_id, host)
  	elsif (int_type == 2)
  		retrun_line = "Processed " + int_expressions_processed.to_s + " expressions."
  	end
    #logger.debug "retrun_line 2: "+retrun_line
  	return retrun_line
  	
  end
  
  # rebuild the lines for a single page.  Used on reorder submission
  # where the number of lines doesn't change, so you don't need to recalculate everything
  def do_page_lines(int_previous_expression_id, int_previous_expression_line_number, int_previous_digital_edition_order, int_page_id)
  
  	int_working_page_line_number = 0
  	int_working_expression_id = int_previous_expression_id
  	int_working_expresssion_line_number = int_previous_expression_line_number
    int_start_digital_edition_line_number = int_previous_digital_edition_order + 1

  	# 1. Delete all line records currently associated with this page
  	Line.where(:page_id => int_page_id).destroy_all
  	
  	# 2. For each transcription assoicated with this page
  	@transcriptions = Transcription.where("page_id = ?", int_page_id).order("transcription_order ASC");
  	@transcriptions.each do |tr|
  		int_this_expression_id = tr.expression_id
  		
  		# reset the working expression line number if the expression associated with this transcription
  		# is different from that of the previous one (the current working one)
  		if (int_this_expression_id != int_working_expression_id)
  			int_working_expresssion_line_number = 0
  			int_working_expression_id = int_this_expression_id
  		end 
  		
  		
  		
  		########################################################################
  		# start working here.  load the transcription file and process it one  #
  		# line at a time.  For each line, increment the
  		# int_working_page_line_number and int_working_expresssion_line_number #
  		# variables before you do anything else								   #
  		########################################################################
  
  		# now loop through each line in the transcription file and process accordingly
  	str_file_to_load = Rails.public_path+tr.transcription_file.to_s
		#logger.debug "File To Load: #{str_file_to_load}"
    begin
      file = File.new(str_file_to_load, "r")
      while (line = file.gets)
        int_working_page_line_number = int_working_page_line_number + 1
        int_working_expresssion_line_number = int_working_expresssion_line_number + 1
        str_base_line = getBaseLine(line)
        str_base_line = str_base_line.strip!
        str_line_designator = getLineDesignator(line)
        str_start_code = getStartCode(line)
        #logger.debug "str_start_code Ret Val: " + str_start_code
        str_converted_line = makeSQLSafe(str_base_line)
          str_final_line = convert_special_chars(str_converted_line)

          Line.create(transcription_id: tr.id, page_id: int_page_id, digital_edition_id: tr.digital_edition_id, expression_id: tr.expression_id, work_id: tr.work_id, line_page_order: int_working_page_line_number, line_expression_order: int_working_expresssion_line_number, line_designator: str_line_designator, line_variant_version: str_final_line, line_dv_start_code: str_start_code, line_digital_edition_order: int_start_digital_edition_line_number)



          #logger.debug "     Line Designator: #{str_line_designator}     -- Base Line: #{str_final_line}"
          int_start_digital_edition_line_number = int_start_digital_edition_line_number + 1
      end
      #logger.debug "End File"
      file.close
    rescue
      #logger.debug "Failed To Load: #{str_file_to_load}"
    end

  			
  			# Increment int_working_page_line_number and int_working_expresssion_line_number
  			# process the line (see what I did in the jave file process
  			# Insert the new line record.
   end
  
  end
  
  # Takes a page_id and looks to see if there is a page before or not.
  # If there is, it finds the expression_id and expression line number of the 
  # Last line of that page and returns these values.  If this is the 
  # first page in the edition, it returns 0 for both values
  def get_prev_page_last_line_data(page_id)
  
  	# line_page_order, :expression_id, :line_expression_order
  	int_working_expression_id = 0
  	int_line_expression_order = 0
    int_line_digital_edition_order = 0
  
  	@working_page = Page.find(page_id)
  	int_working_digital_edition_id = @working_page.digital_edition_id
  	int_working_page_page = @working_page.page_page
  	int_working_page_id = @working_page.id
  	
  	@first_page = Page.where("digital_edition_id = ?", int_working_digital_edition_id).order("page_page ASC").first;
  	int_first_page_page = @first_page.page_page
  	int_first_page_id = @first_page.id

    if (int_first_page_page.nil?)
      int_first_page_page = -100
    end

    #logger.debug "int_first_page_page: "+int_first_page_page.to_s
    #logger.debug "int_working_page_page: "+int_working_page_page.to_s
  	
  	if int_first_page_page < int_working_page_page
  		# if here, there are pages before this in the edition, so I need to find
  		# the page right before and calculate the work, work-line, and edition-line
  		# of the last line of that page
  		int_page_before_working = 0
  		int_page_before = 0
  		@pages = Page.where("digital_edition_id = ?", int_working_digital_edition_id).order("page_page ASC");
  		@pages.each do |pid|
  			int_this_id = pid.id
  			if (int_working_page_id == int_this_id)
  				int_page_before = int_page_before_working
  			end
  			int_page_before_working = int_this_id
  		end
  		#now get the last line associated with the page before
  		@last_line = Line.where("page_id = ?", int_page_before).order("line_page_order ASC").last;
  		int_working_expression_id = @last_line.expression_id
  		int_line_expression_order = @last_line.line_expression_order
      int_line_digital_edition_order = @last_line.line_digital_edition_order
  	end
  	
  
  	arr_last_page_info = [int_working_expression_id, int_line_expression_order, int_line_digital_edition_order]
  	
  	return arr_last_page_info
  	
  end
  
  # converts scpecial characters to ASCII code
  def convert_special_chars(line)
    ret_line = line

    if ret_line

      # if line =~ /P(erl|ython)/
      #
      # end

      # if
      # elsif
      # else
      # end

      # ret_line = ret_line.gsub(/%H40%N/, "SPACE-40")

      # Left Italian quotation mark
      ret_line = ret_line.gsub(/%<</,"&#x00AB;")
      # Right Italian quotation mark
      ret_line = ret_line.gsub(/%>>/,"&#x00BB;")
      # Replace alteration with the arrow
      ret_line = ret_line.gsub(/%>/,"&#x2192;")
      # Nonscribal alteration begin
      ret_line = ret_line.gsub(/<</,"&#x00AB;")
      # Nonscribal alteration end
      ret_line = ret_line.gsub(/>>/,"&#x00BB;")
      # Replaces < with %#
      ret_line = ret_line.gsub(/>/,"%~")
      # Replaces > with %!
      ret_line = ret_line.gsub(/</,"%!")


      # Removes large cap
      ret_line = ret_line.gsub(/%\+/,"")
      # Replaces %V with caret
      ret_line = ret_line.gsub(/%V/,"^")
      # Sigma
      ret_line = ret_line.gsub(/%F/,"&#x03A3;")
      # %(sic%) --> [sic]
      ret_line = ret_line.gsub(/%\(/,"[")
      ret_line = ret_line.gsub(/%\)/,"]")
      #Above running %\( --> \(
      ret_line = ret_line.gsub(/%\\\(/,"\\\\(")
      # Below running %/( --> /(
      ret_line = ret_line.gsub(/%\/\(/,"/(")
      # Ordinal number
      ret_line = ret_line.gsub(/%@/,"&#x00B0;")
      # Em space
      ret_line = ret_line.gsub(/%_/,"&#x2003;")
      # En dash
      ret_line = ret_line.gsub(/%-/,"&#x2013;")
      # Section symbol
      ret_line = ret_line.gsub(/%\$/,"&#x00A7;")

      ###########
      # ACCENTS #
      ###########

      # Accute
      if (ret_line.index("%A"))
        ret_line = ret_line.gsub(/A%A/,"&#x00C1;")
        ret_line = ret_line.gsub(/E%A/,"&#x00C9;")
        ret_line = ret_line.gsub(/I%A/,"&#x00CD;")
        ret_line = ret_line.gsub(/O%A/,"&#x00D3;")
        ret_line = ret_line.gsub(/U%A/,"&#x00DA;")
        ret_line = ret_line.gsub(/Y%A/,"&#x00DD;")
        ret_line = ret_line.gsub(/a%A/,"&#x00E1;")
        ret_line = ret_line.gsub(/e%A/,"&#x00E9;")
        ret_line = ret_line.gsub(/i%A/,"&#x00ED;")
        ret_line = ret_line.gsub(/o%A/,"&#x00F3;")
        ret_line = ret_line.gsub(/u%A/,"&#x00FA;")
        ret_line = ret_line.gsub(/y%A/,"&#x00FD;")
      end


      # Grave
      if (ret_line.index("%G"))
        ret_line = ret_line.gsub(/A%G/,"&#x00C0;")
        ret_line = ret_line.gsub(/E%G/,"&#x00C8;")
        ret_line = ret_line.gsub(/I%G/,"&#x00CC;")
        ret_line = ret_line.gsub(/O%G/,"&#x00D2;")
        ret_line = ret_line.gsub(/U%G/,"&#x00D9;")
        ret_line = ret_line.gsub(/a%G/,"&#x00E0;")
        ret_line = ret_line.gsub(/e%G/,"&#x00E8;")
        ret_line = ret_line.gsub(/i%G/,"&#x00EC;")
        ret_line = ret_line.gsub(/o%G/,"&#x00F2;")
        ret_line = ret_line.gsub(/u%G/,"&#x00F9;")
      end

        # Circumflex
      if (ret_line.index("%C"))
        ret_line = ret_line.gsub(/A%C/,"&#x00C2;")
        ret_line = ret_line.gsub(/E%C/,"&#x00CA;")
        ret_line = ret_line.gsub(/I%C/,"&#x00CE;")
        ret_line = ret_line.gsub(/O%C/,"&#x00D4;")
        ret_line = ret_line.gsub(/U%C/,"&#x00DB;")
        ret_line = ret_line.gsub(/C%C/,"&#x0108;")
        ret_line = ret_line.gsub(/G%C/,"&#x011C;")
        ret_line = ret_line.gsub(/H%C/,"&#x0124;")
        ret_line = ret_line.gsub(/J%C/,"&#x0134;")
        ret_line = ret_line.gsub(/S%C/,"&#x015C;")
        ret_line = ret_line.gsub(/W%C/,"&#x0174;")
        ret_line = ret_line.gsub(/Y%C/,"&#x0176;")

        ret_line = ret_line.gsub(/a%C/,"&#x00E2;")
        ret_line = ret_line.gsub(/e%C/,"&#x00EA;")
        ret_line = ret_line.gsub(/i%C/,"&#x00EE;")
        ret_line = ret_line.gsub(/o%C/,"&#x00F4;")
        ret_line = ret_line.gsub(/u%C/,"&#x00FB;")
        ret_line = ret_line.gsub(/c%C/,"&#x0109;")
        ret_line = ret_line.gsub(/g%C/,"&#x011D;")
        ret_line = ret_line.gsub(/h%C/,"&#x0125;")
        ret_line = ret_line.gsub(/j%C/,"&#x0135;")
        ret_line = ret_line.gsub(/s%C/,"&#x015D;")
        ret_line = ret_line.gsub(/w%C/,"&#x0175;")
        ret_line = ret_line.gsub(/y%C/,"&#x0177;")
      end

        # Umlaut
      if (ret_line.index("%U"))
        ret_line = ret_line.gsub(/A%U/,"&#x00C4;")
        ret_line = ret_line.gsub(/E%U/,"&#x00CB;")
        ret_line = ret_line.gsub(/I%U/,"&#x00CF;")
        ret_line = ret_line.gsub(/O%U/,"&#x00D6;")
        ret_line = ret_line.gsub(/U%U/,"&#x00DC;")
        ret_line = ret_line.gsub(/a%U/,"&#x00E4;")
        ret_line = ret_line.gsub(/e%U/,"&#x00EB;")
        ret_line = ret_line.gsub(/i%U/,"&#x00EF;")
        ret_line = ret_line.gsub(/o%U/,"&#x00F6;")
        ret_line = ret_line.gsub(/u%U/,"&#x00FC;")
      end


      # Macron
      if (ret_line.index("%M"))
        ret_line = ret_line.gsub(/A%M/,"&#x0100;")
        ret_line = ret_line.gsub(/E%M/,"&#x0112;")
        ret_line = ret_line.gsub(/I%M/,"&#x012A;")
        ret_line = ret_line.gsub(/O%M/,"&#x014C;")
        ret_line = ret_line.gsub(/U%M/,"&#x016A;")
        ret_line = ret_line.gsub(/a%M/,"&#x0101;")
        ret_line = ret_line.gsub(/e%M/,"&#x0113;")
        ret_line = ret_line.gsub(/i%M/,"&#x012B;")
        ret_line = ret_line.gsub(/o%M/,"&#x014D;")
        ret_line = ret_line.gsub(/u%M/,"&#x016B;")
        # if Combination of Macron with another letter, uses the unicode combined macron
        # it might not work properly.
        # if (ret_line.index("%M")) ret_line = ret_line.gsub(/%M/,"&#x0304")
      end

      #  Tilde
      if (ret_line.index("%T"))
        ret_line = ret_line.gsub(/A%T/,"&#x00C3;")
        ret_line = ret_line.gsub(/E%T/,"&#x1EBC;")
        ret_line = ret_line.gsub(/I%T/,"&#x0128;")
        ret_line = ret_line.gsub(/O%T/,"&#x00D5;")
        ret_line = ret_line.gsub(/U%T/,"&#x0168;")
        ret_line = ret_line.gsub(/N%T/,"&#x00D1;")
        ret_line = ret_line.gsub(/a%T/,"&#x00E3;")
        ret_line = ret_line.gsub(/e%T/,"&#x1EBD;")
        ret_line = ret_line.gsub(/i%T/,"&#x0129;")
        ret_line = ret_line.gsub(/o%T/,"&#x00F5;")
        ret_line = ret_line.gsub(/u%T/,"&#x0169;")
        ret_line = ret_line.gsub(/n%T/,"&#x00F1;")
        # if Combination of Tilde with another letter, uses the unicode combined tilde
        # it might not work properly.
        # if (ret_line.index("%T")!=-1) ret_line = ret_line.gsub(/%T/,"&#x0303");
      end

      # Breve
      if (ret_line.index("%B"))
        ret_line = ret_line.gsub(/S%B/,"&#x0160;")
        ret_line = ret_line.gsub(/A%B/,"&#x0102;")
        ret_line = ret_line.gsub(/E%B/,"&#x0114;")
        ret_line = ret_line.gsub(/I%B/,"&#x012C;")
        ret_line = ret_line.gsub(/O%B/,"&#x014E;")
        ret_line = ret_line.gsub(/U%B/,"&#x016C;")
        ret_line = ret_line.gsub(/s%B/,"&#x0161;")
        ret_line = ret_line.gsub(/a%B/,"&#x0103;")
        ret_line = ret_line.gsub(/e%B/,"&#x0115;")
        ret_line = ret_line.gsub(/i%B/,"&#x012D;")
        ret_line = ret_line.gsub(/o%B/,"&#x014F;")
        ret_line = ret_line.gsub(/u%B/,"&#x016D;")
      end

      # Cedilla
      ret_line = ret_line.gsub(/C%D/,"&#x00C7;")
      ret_line = ret_line.gsub(/c%D/,"&#x00E7;")

      # Degee mark
      ret_line = ret_line.gsub(/A%E/,"&#x00C5;")
      ret_line = ret_line.gsub(/a%E/,"&#x00E5;")

      # Inverted
      ret_line = ret_line.gsub(/!%I/,"&#x00A1;")
      ret_line = ret_line.gsub(/\?%I/,"&#x00B;F")

      # Ligature
      ret_line = ret_line.gsub(/AE%L/,"&#x00C6;")
      ret_line = ret_line.gsub(/ae%L/,"&#x00E6;")
      ret_line = ret_line.gsub(/OE%L/,"&#x0152;")
      ret_line = ret_line.gsub(/oe%L/,"&#x0153;")

      # Polish L
      ret_line = ret_line.gsub(/L%W/,"&#x0141;")
      ret_line = ret_line.gsub(/l%W/,"&#x0142;")

      # slashed P **
      ret_line = ret_line.gsub(/p%P/,"&#x1D7D;")
      ret_line = ret_line.gsub(/P%P/,"&#x2C63;")

      # que latin sufix
      ret_line = ret_line.gsub(/q%Q/,"que")

      # Slash Danish O
      ret_line = ret_line.gsub(/O%S/,"&#x00D8;")
      ret_line = ret_line.gsub(/o%S/,"&#x00F8;")


      ret_line = ret_line.gsub(/&#230;/, "&#x00E6;")
      ret_line = ret_line.gsub(/&#133;/, "&#x2026;")
      ret_line = ret_line.gsub(/&#235;/, "&#x00EB;")
      ret_line = ret_line.gsub(/&#244;/, "&#x00F4;")
      ret_line = ret_line.gsub(/&#194;/, "&#x00C2;")
      ret_line = ret_line.gsub(/&#226;/, "&#x00E2;")

    end
    
  	return ret_line
  	
  end


  
  
  # Function for making a TEI header for the entire digital edition.
  # Returns a complete header as a text string
  def do_edition_header(int_edition_id, int_manifestation_id)
  	ret_header = ""
  	tab_1 = "   "
	tab_2 = "      "
	tab_3 = "         "
	tab_4 = "            "
	tab_5 = "               "
	tab_6 = "                  "
	tab_7 = "                     "
	
	ret_header = ret_header + tab_1 + "<teiHeader>\n"
	ret_header = ret_header + tab_2 + "<fileDesc>\n"
	
	
	str_dig_edition_title = ""
	int_man_id = 0
	
	@edition = DigitalEdition.where("id = ?", int_edition_id)
	@edition.each do |dig_ed|
		str_dig_edition_title = dig_ed.digital_edition_local_title
		int_man_id = dig_ed.manifestation_id
	end
	
	arr_authors = Array.new
	arr_authors_plane = Array.new
	arr_editors = Array.new
	arr_editors_plane = Array.new
	arr_publishers = Array.new
	int_man_event_author = 0
	int_man_event_editor = 0
	int_man_event_publish = 0
	int_man_event_publish_location = 0
	str_man_event_publish_start_dt = ""
	str_man_event_publish_end_dt = ""
	
	
	@manevents = ManifestationEvent.where("manifestation_events.manifestation_id = ?", int_man_id)
	@manevents.each do |man_events|
		if (man_events.event_type_id == 1)
			int_man_event_author = man_events.id
		elsif (man_events.event_type_id == 2)
			int_man_event_publish = man_events.id
			int_man_event_publish_location = man_events.location_id
			str_man_event_publish_start_dt = man_events.manifestation_event_start_date
			str_man_event_publish_end_dt = man_events.manifestation_event_end_date
		elsif (man_events.event_type_id == 3)
			int_man_event_editor = man_events.id
		end
	
	end

	if int_man_event_author > 0
		@authors = ManifestationEventsHasAgents.where("manifestation_event_id = ?", int_man_event_author)
		@authors.each do |man_authors|	
			int_agent_id = man_authors.agent_id
			str_author_name_formatted = get_formatted_agent_name(int_agent_id)
			if str_author_name_formatted.length > 0
				arr_authors_plane.push(str_author_name_formatted)
				str_author_tei = "<persName key=\"" + int_agent_id.to_s + "\" xml:id=\"AGT_" + int_agent_id.to_s + "\">" + str_author_name_formatted + "</persName>"
				arr_authors.push(str_author_tei)
			end
		end
	end


	if int_man_event_editor > 0
		@editors = ManifestationEventsHasAgents.where("manifestation_event_id = ?", int_man_event_publisher)
		@editors.each do |edit_pubs|	
			int_edit_id = edit_pubs.agent_id
			str_edit_name_formatted = get_formatted_agent_name(int_edit_id)
			if str_edit_name_formatted.length > 0
				arr_editors_plane.push(str_edit_name_formatted)
				str_author_tei = "<persName key=\"" + int_edit_id.to_s + "\" xml:id=\"AGT_" + int_edit_id.to_s + "\">" + str_edit_name_formatted + "</persName>"
				arr_editors.push(str_author_tei)
			end			
		end
	end	
	
	
	str_dig_edition_title = str_dig_edition_title.gsub(/&/, "&amp;")	
	ret_header = ret_header + tab_3 + "<titleStmt>\n"
	ret_header = ret_header + tab_4 + "<title>" + str_dig_edition_title + "</title>\n"
	if arr_authors.size > 0
		ret_header = ret_header + tab_4 + "<author>\n"
		arr_authors.each do |authors_el|
			ret_header = ret_header + tab_5 + authors_el + "\n"
		end
		ret_header = ret_header + tab_4 + "</author>\n"
	end
	
	if arr_editors.size > 0
		ret_header = ret_header + tab_4 + "<editor>\n"
		arr_editors.each do |editors_el|
			ret_header = ret_header + tab_5 + editors_el + "\n"
		end
		ret_header = ret_header + tab_4 + "</editor>\n"
	end
	ret_header = ret_header + tab_3 + "</titleStmt>\n"


	str_digital_publisher_name = ""
	str_digital_publisher_url = ""
	str_digital_publisher_location = ""
	str_digital_license = ""
	str_digital_site_editor_name = ""
	str_digital_site_name = ""

	@confs = Conf.where("config_active = ?", true)
	@confs.each do |conf|	
		str_digital_publisher_name = conf.conf_publisher
		str_digital_publisher_url = conf.conf_publisher_url
		str_digital_publisher_location = conf.conf_publisher_location
		str_digital_license = conf.conf_publisher_license
		str_digital_site_editor_name = conf.conf_site_editor_name
		str_digital_site_name = conf.conf_site_name
	end
	str_digital_publisher_name = str_digital_publisher_name.gsub(/&/, "&amp;")	
	str_digital_publisher_url = str_digital_publisher_url.gsub(/&/, "&amp;")	
	str_digital_publisher_location = str_digital_publisher_location.gsub(/&/, "&amp;")	
	str_digital_license = str_digital_license.gsub(/&/, "&amp;")	
	str_digital_site_editor_name = str_digital_site_editor_name.gsub(/&/, "&amp;")	
	str_digital_site_name = str_digital_site_name.gsub(/&/, "&amp;")	


	ret_header = ret_header + tab_3 + "<publicationStmt>\n"
	
	if (str_digital_publisher_name.length > 0 || str_digital_publisher_url.length > 0)
		ret_header = ret_header + tab_4 + "<publisher>\n"
		ret_header = ret_header + tab_5
		if (str_digital_publisher_url.length > 0)
			ret_header = ret_header + "<ref target=\"" + str_digital_publisher_url + "\">"
		end
		if (str_digital_publisher_name.length > 0)
			ret_header = ret_header + str_digital_publisher_name
		else
			ret_header = ret_header + str_digital_publisher_url
		end
		if (str_digital_publisher_url.length > 0)
			ret_header = ret_header + "</ref>"
		end	
		ret_header = ret_header + "\n"
		ret_header = ret_header + tab_4 + "</publisher>\n"
	end
	
	if (str_digital_publisher_location.length > 0)
		ret_header = ret_header + tab_4 + "<pubPlace>" + str_digital_publisher_location + "</pubPlace>\n"
	end
	ret_header = ret_header + tab_4 + "<date when=\"" + Time.now.year.to_s + "\"/>\n"
	
	if (str_digital_license.length > 0 || str_digital_site_editor_name.length > 0)
		ret_header = ret_header + tab_4 + "<availability>\n"
		if (str_digital_site_editor_name.length > 0)
			ret_header = ret_header + tab_5 + "<p> Copyright (c) " + Time.now.year.to_s + " " + str_digital_site_editor_name + " </p>\n"
		end
		if (str_digital_license.length > 0)
			ret_header = ret_header + tab_5 + "<p> " + str_digital_license + " </p>\n"
		end
		ret_header = ret_header + tab_4 + "</availability>\n"
	end
		
	ret_header = ret_header + tab_3 + "</publicationStmt>\n"
	
	ret_header = ret_header + tab_3 + "<sourceDesc>\n"
	ret_header = ret_header + tab_4 + "<biblStruct n=\"MANIFESTATION\" xml:id=\"MN_" + int_manifestation_id.to_s + "\">\n"


	if (arr_editors_plane.size > 0 || arr_authors_plane.size > 0)
		ret_header = ret_header + tab_5 + "<analytic>\n"
		if arr_authors_plane.size > 0
			ret_header = ret_header + tab_6 + "<author>\n"
			arr_authors_plane.each do |authors_el|
				ret_header = ret_header + tab_7 + "<persName>" + authors_el + "</persName>\n"
			end
			ret_header = ret_header + tab_6 + "</author>\n"
		end
	
		if arr_editors_plane.size > 0
			ret_header = ret_header + tab_6 + "<editor>\n"
			arr_editors_plane.each do |editors_el|
				ret_header = ret_header + tab_7 + "<persName>" + editors_el + "</persName>\n"
			end
			ret_header = ret_header + tab_6 + "</editor>\n"
		end

		ret_header = ret_header + tab_5 + "</analytic>\n"
	end
	
	
	
	
	str_manifestation_title = ""
	@mans = Manifestation.where("id = ?", int_manifestation_id)
	@mans.each do |man_item|	
		str_manifestation_title = man_item.manifestation_name
	end	
	str_manifestation_title = str_manifestation_title.gsub(/&/, "&amp;")
	ret_header = ret_header + tab_5 + "<monogr>\n"
	ret_header = ret_header + tab_6 + "<title>" + str_manifestation_title + "</title>\n"	
	
	ret_header = ret_header + tab_6 + "<imprint>\n"
	
	if (int_man_event_publish_location > 0) 
		str_pub_loc_name = ""
		@publoc = Location.where("id = ?", int_man_event_publish_location)
		@publoc.each do |publoc_item|	
			str_pub_loc_name = publoc_item.location_name
		end	
		if (str_pub_loc_name.length > 0)
			str_pub_loc_name = str_pub_loc_name.gsub(/&/, "&amp;")
			ret_header = ret_header + tab_7 + "<pubPlace>" + str_pub_loc_name + "</pubPlace>\n"
		end
	end
					
	
	if int_man_event_publish > 0
	
		@publishers = ManifestationEventsHasAgents.where("manifestation_event_id = ?", int_man_event_publish)
		@publishers.each do |man_pubs|	
			int_agent_id = man_pubs.agent_id
			str_pub_name_formatted = get_formatted_agent_name(int_agent_id)
			if str_pub_name_formatted.length > 0
				ret_header = ret_header + tab_7 + "<publisher>" + str_pub_name_formatted + "</publisher>\n"
			end
		end
	end
	
	str_pub_final_date = ""
	if (str_man_event_publish_start_dt == str_man_event_publish_end_dt)
		str_pub_final_date = str_man_event_publish_start_dt
	else
		bln_do_dash = false
		if (str_man_event_publish_start_dt.length >0)
			str_pub_final_date = str_man_event_publish_start_dt
			bln_do_dash = true
		end
		if (str_man_event_publish_end_dt.length >0)
			if (bln_do_dash)
				str_pub_final_date = str_pub_final_date + "-"
			end
			str_pub_final_date = str_pub_final_date + str_man_event_publish_end_dt
		end		
	end
	if (str_pub_final_date.length >0)
		ret_header = ret_header + tab_7 + "<date when=\"" + str_pub_final_date + "\" xml:id=\"sort_date\"/>\n"
	end
	
	ret_header = ret_header + tab_6 + "</imprint>\n"
	
	
	ret_header = ret_header + tab_5 + "</monogr>\n"

	ret_header = ret_header + tab_4 + "</biblStruct>\n"
	ret_header = ret_header + tab_3 + "</sourceDesc>\n"
	
	
	
	
	
	ret_header = ret_header + tab_2 + "</fileDesc>\n"
	
	
	ret_header = ret_header + tab_2 + "<encodingDesc>\n"
	ret_header = ret_header + tab_3 + "<editorialDecl>\n"
	ret_header = ret_header + tab_4 + "<p>This document follows the guidelines specified for TEI P.5.</p>\n"
	ret_header = ret_header + tab_4 + "<p>XML generated automatically at " + Time.now.to_s + " by the Collex Edition Builder created by Carl Stahmer, PhD.</p>\n"
	ret_header = ret_header + tab_3 + "</editorialDecl>\n"
	ret_header = ret_header + tab_3 + "<variantEncoding method=\"parallel-segmentation\" location=\"internal\"/>\n"
	ret_header = ret_header + tab_2 + "</encodingDesc>\n"
	
	
	
  	ret_header = ret_header + tab_1 + "</teiHeader>\n"
  	
  	return ret_header
  end
  
  # Function for making a TEI header for the work.
  # Returns a complete header as a text string
  def do_work_header()
  	ret_header = ""
  	
  	return ret_header
  end 
  
  # function for creating the <TEXT> block for a non poem expression
  def do_generic_text(work_id, expression_id, line, line_expression_order, line_page_order, line_designator, arr_flags)
	ret_text = ""
	# <text n="A Ballad of Life" type="poem" xml:id="expressionid">
	# 	<index corresp="acs0000001-01-i002-md.xml" indexName="text"/>
	#	
	# 	<body>
	#	
	# 		<pb facs="http://eebo.chadwyck.com/fetchimage?vid=18464width=1200"/>
	# 		<div type="Miscellaneous_Sub-Work" xml:id="workid">
	# 			<l style="text-align: center; font-variant: small-caps">line of text</l>
	# 		</div>
	#		
	# 	</body>
	#	
	# </text>

  	return ret_text
  end
  
  
  # function for updating the database with the TEI for the edition.
  # should do the actual db write here
  # def update_edition_tei(str_tei_text, int_digital_edition_id)
  def update_edition_tei(arr_edition_tei_lines, int_digital_edition_id, host)



    #logger.debug "I'm here"


  	str_running_edition = ""
    tab_1 = "   "
    tab_2 = "      "
    tab_3 = "         "
    tab_4 = "            "
    tab_5 = "               "
    tab_6 = "                  "
    tab_7 = "                     "
  	
  	int_open_lg = 0
  	int_open_div = 0
  	int_open_text = 0
  	int_open_body = 0
  	int_open_head = 0
  	int_working_expression_id = 0
  	int_working_page_id = 0
  	
  	int_loop_iteration = 0
  	
  	str_working_conv_line_designator = ""
  	
  	arr_edition_tei_lines.each do |line| 
  		
  		str_line = line[0]
  		str_designator = line[1]
  		int_page = line[2]
  		int_expression = line[3]
  		str_page_facs = line[5]

      #logger.debug "Now Re-Processing Line: "+str_line
  		
  		if (int_expression != int_working_expression_id)
  		
  			if (int_loop_iteration > 0)				
  			
  			  	#close out any remaining lgs
  				while int_open_lg > 0
  				
#  					if (int_open_head > 0)
#						str_running_edition = str_running_edition + tab_7 + "</head>\n"
#						int_open_head = int_open_head - 1
#					end
  				
  				
  					str_running_edition = str_running_edition + tab_6 + "</lg>\n"
  					int_open_lg = int_open_lg - 1
  				end
  			
  				str_running_edition = str_running_edition + tab_5 + "</div>\n" + tab_4 + "</body>\n" + tab_3 + "</text>\n"
  				int_open_div = int_open_div - 1
  				int_open_text = int_open_text - 1
  				int_open_body = int_open_body - 1
  				str_working_conv_line_designator = ""
  				
  			end

  			str_running_edition = str_running_edition + tab_3 + "<text type=\"expression\" xml:id=\"EX_" + int_expression.to_s + "\">\n"
  			# str_running_edition = str_running_edition + tab_3 + "<index indexName=\"EXPRESSIONS\" xml:id=\"EX_" + int_expression.to_s + "\" />\n"
  			str_running_edition = str_running_edition + tab_3 + "<index indexName=\"EXPRESSIONS\" />\n"
			str_running_edition = str_running_edition + tab_4 + "<body>\n"
			# str_running_edition = str_running_edition + tab_5 + "<div type=\"EXPRESSIONS\" xml:id=\"EX_" + int_expression.to_s + "\">\n"
			str_running_edition = str_running_edition + tab_5 + "<div type=\"EXPRESSIONS\">\n"
  			
  			int_open_div = int_open_div + 1
  			int_open_text = int_open_text + 1
  			int_open_body = int_open_body + 1
  			
  			int_working_expression_id = int_expression
  		end
  		
  		

  		
  		
  		# deal with page breaks
  		if (int_page != int_working_page_id)
  			int_pb_tab_spaces = 18 + (3 * int_open_lg)
  			str_pb_tab_string = ""
		  	while int_pb_tab_spaces > 0
		  		str_pb_tab_string = str_pb_tab_string + " "
		  		int_pb_tab_spaces = int_pb_tab_spaces - 1
		  	end  
  			str_running_edition = str_running_edition + str_pb_tab_string 
  			if (int_open_head > 0)
  				str_running_edition = str_running_edition + "   "
  			end
  			str_running_edition = str_running_edition + "<pb facs=\"http://" + host.to_s + str_page_facs.to_s + "\"/>\n"
  			int_working_page_id = int_page
  		end 	
  		
  		
  		
  		
     				
  		# deal with lgs
  		str_conv_desigator = str_designator.gsub(/O/,"0")
  		str_conv_desigator = str_designator.gsub(/\dHE/,"XHE")
  		# str_group_type = get_lg_type(str_conv_desigator)
  		
  		if (str_working_conv_line_designator.length) < 1
  		
  			str_running_edition = str_running_edition + tab_6 + "<lg"
  			
  			if (str_conv_desigator =~ /STZ/ || str_conv_desigator =~ /SZB/ || str_conv_desigator =~ /SZN/)
  				str_running_edition = str_running_edition + " type=\"stanza\""
  			end
  			  			
  			str_running_edition = str_running_edition + ">\n";
  			int_open_lg = int_open_lg + 1
  			str_working_conv_line_designator = str_conv_desigator
  		else
  		
  			if (str_working_conv_line_designator != str_conv_desigator )
  			
  				if (str_conv_desigator =~ /\d+/ && (str_working_conv_line_designator =~ /\d+/ || str_working_conv_line_designator =~ /STZ/ || str_working_conv_line_designator =~ /SZB/ || str_working_conv_line_designator =~ /SZN/  || str_working_conv_line_designator =~ /XHE/))
  					
  					if (str_line =~ /margin-top:/ && (str_working_conv_line_designator !~ /\D+/ || str_working_conv_line_designator =~ /XHE/))
# 						int_did_head = 0
# 						if (int_open_head > 0)
#							str_running_edition = str_running_edition + tab_7 + "</head>\n"
#							int_did_head = int_did_head + 1
#						end
  						str_running_edition = str_running_edition + tab_6 + "</lg>\n"
  						str_running_edition = str_running_edition + tab_6 + "<lg>\n"
#  						if (int_did_head > 0)
#  							str_running_edition = str_running_edition + tab_7 + "<head>\n"
#  						end
  					end
  				
  					# check here to see if this is a new stanza
  					int_temp_num = 1
 
  				else
  				
					while int_open_lg > 0
#						if (int_open_head > 0)
#							str_running_edition = str_running_edition + tab_7 + "</head>\n"
#							int_open_head = int_open_head - 1
#						end
					
						str_running_edition = str_running_edition + tab_6 + "</lg>\n"
						int_open_lg = int_open_lg - 1
					end

					str_running_edition = str_running_edition + tab_6 + "<lg"
  			
					if (str_conv_desigator =~ /STZ/ || str_conv_desigator =~ /SZB/ || str_conv_desigator =~ /SZN/)
						str_running_edition = str_running_edition + " type=\"stanza\""
					end
								
					str_running_edition = str_running_edition + ">\n";
					
					int_open_lg = int_open_lg + 1
				end
  				
  				
  				str_working_conv_line_designator = str_conv_desigator
  			end
 
  		end
  		
#####
  		
  		
  		#close out the head if there's an open one and this is a a non-head line
#		if (str_conv_desigator !~ /\D+/ && int_open_head > 0)
#			str_running_edition = str_running_edition + tab_7 + "</head>\n"
#			int_open_head = int_open_head - 1
#		end
  		
  		# open a head if this is a head item and there isn't already one
# 		if  (str_conv_desigator =~ /\D+/ && int_open_head == 0)
# 			str_running_edition = str_running_edition + tab_7 + "<head>\n"
#  			int_open_head = int_open_head + 1
#  		end

  		str_running_edition = str_running_edition + tab_7
#  		if (int_open_head > 0)
#  			str_running_edition = str_running_edition + "   "
#  		end 
  		
  		str_running_edition = str_running_edition + str_line + "\n"
  		
  		int_loop_iteration = int_loop_iteration + 1
  	
  	end
  	
  	#close out the head if there's an open one
#  	if (int_open_head > 0)
#  		str_running_edition = str_running_edition + tab_7 + "</head>\n"
#  	end
  	
  	#close out any remaining lgs
  	while int_open_lg > 0
  		str_running_edition = str_running_edition + tab_6 + "</lg>\n"
  		int_open_lg = int_open_lg - 1
  	end
  	
  	str_running_edition = str_running_edition + tab_5 + "</div>\n" + tab_4 + "</body>\n" + tab_3 + "</text>\n"
  	
#  	str_running_edition = str_running_edition.gsub(/\s*<head>\n\s*<\/head>\n/, "\n")

    #logger.debug str_running_edition

  	return str_running_edition
  	
  end
  
  # function for updating the database with the TEI for the expression.
  # should do the actual db write here
  # def update_expression_tei(str_tei_text, int_expression_id)
  def update_expression_tei(arr_expression_tei_lines, int_expression_id)
  	x = 1
  end
  
  # function for updating the database with the TEI for the line.
  # should do the actual db write here
  # def update_page_tei(str_tei_page, int_page_id)
  def update_page_tei(arr_page_tei_lines, int_page_id)
  	# 			arr_line_array = [line_variant_text, line_designator, int_page_id, int_expression_id, int_work_id, str_page_facs]



  end
  
  # function for updating the database with the TEI for the line.
  # should do the actual db write here
  def update_line_tei(str_tei_line, int_line_id)
  	x = 1
  end
  
  # function for converting variant lines to proper TEI variant encoding
  # returns a TEI variant line
  def do_variant_tei(str_line)
  	ret_variant_line = str_line
  	if ( str_line =~ /{.*}/ )
  		str_working_line_start = str_line
  		str_working_line = str_working_line_start.gsub(/{.*?}/, "{VAR::VAR}");
  		arr_linewords = str_working_line.split(/\s+/)
  		int_line_word_length = arr_linewords.length
  		arr_variant_matches = str_line.scan(/{.*?}/)
  		str_match_string = ""
  		int_match_num = 0
  		
  		int_open_ital = 0
  		int_open_bold = 0
  		int_open_super = 0
  		int_open_sub = 0
  		int_open_smallcap = 0
  		int_open_underline = 0
  		int_open_strike = 0
  		
  		arr_linewords.each do |line_word| 
  		
  			if ( line_word =~ /{VAR::VAR}/ )
 
  				str_stripped_word = line_word.gsub(/{VAR::VAR}/, "")
  				
  				int_match_on = 0
  				arr_variant_matches.each do |var_chunk|
  					# str_match_string = str_match_string + "[[[" + var_chunk + "]]] "
  					
					if (int_match_on == int_match_num)	
					

						if ( var_chunk =~ /:/ )
							arr_var_pieces = var_chunk.split(/:/)
							str_type_base = arr_var_pieces.first
							str_working_part = arr_var_pieces.last
							str_type_base = str_type_base.gsub(/%\d/,"")
							str_type_base = str_type_base.gsub(/\{/,"")
							
							
							if ( str_type_base =~ /unc/ )
								str_type = "uncorrected"
							elsif ( str_type_base =~ /\*+/ )
								str_type = "obscured"
							elsif ( str_type_base =~ /\^/ )
								str_type = "ommission"
							elsif ( str_type_base =~ /app/ )
								str_type = "appearance"
							elsif ( str_type_base =~ /cor/ )
								str_type = "corrected"
							elsif ( str_type_base =~ /del/ )
								str_type = "deleted"
							elsif ( str_type_base =~ /err/ )
								str_type = "errata"
							elsif ( str_type_base =~ /HE/ )
								str_type = "heading"
							elsif ( str_type_base =~ /ind/ )
								str_type = "indented"
							elsif ( str_type_base =~ /Keynes/ )
								str_type = "Keynes"
							elsif ( str_type_base =~ /missing/ )
								str_type = "missing"
							elsif ( str_type_base =~ /om/ )
								str_type = "omitted"
							elsif ( str_type_base =~ /rev/ )
								str_type = "reversed"
							elsif ( str_type_base =~ /SS/ )
								str_type = "subscription"
							elsif ( str_type_base =~ /var/ )
								str_type = "variant"
							else
								str_type = str_type_base
							end
						else
							str_type = "variant"
							str_working_part = var_chunk
						end
						
						if ( str_working_part =~ /\(/ )
							arr_var_new_pieces = str_working_part.split(/\(/)
							str_new_working_base = arr_var_new_pieces.first
							str_working_witnesses = arr_var_new_pieces.last
							str_working_witnesses = str_working_witnesses.gsub(/\)/,"")
							str_working_witnesses = str_working_witnesses.gsub(/\}/,"")
							str_working_witnesses = str_working_witnesses.rstrip
							str_working_witnesses = str_working_witnesses.lstrip
							str_working_witnesses = str_working_witnesses.gsub(/,/," ")
							str_working_witnesses = str_working_witnesses.gsub(/\s+/," ")
						else
							str_working_witnesses = ""
							str_new_working_base = str_working_part
						end
						
						str_new_working_base = str_new_working_base.rstrip
						str_new_working_base = str_new_working_base.lstrip
						
						
						# {%1unc%2: ~, (CtY,DFo,OJn)}
					
						#str_match_string = str_match_string + "[<app><lem>" + str_stripped_word + "</lem><rdg>" + var_chunk + "</rdg></app>]" + " "
						
						if (str_stripped_word.length <1)
							arr_count_array = str_new_working_base.split(/\s/)
							
							str_stripped_word = "["
							arr_count_array.each do |xy| 
								str_stripped_word = str_stripped_word + "*"
							end
							str_stripped_word = str_stripped_word + "]"
						end
						
						
						str_format_tags = add_close_format_tags(int_open_ital, int_open_bold, int_open_super, int_open_sub, int_open_smallcap, int_open_underline, int_open_strike)
						str_match_string = str_match_string.rstrip
						str_match_string = str_match_string + str_format_tags + " "


						str_match_string = str_match_string + "<app>"
						str_match_string = str_match_string + "<lem>" 
						
						str_format_tags = add_open_format_tags(int_open_ital, int_open_bold, int_open_super, int_open_sub, int_open_smallcap, int_open_underline, int_open_strike)
						str_match_string = str_match_string + str_format_tags
						
						
						str_match_string = str_match_string + str_stripped_word 
						
						
						int_open_ital = int_open_ital + str_stripped_word.scan(/%1/).size - str_stripped_word.scan(/%2/).size
						int_open_bold = int_open_bold + str_stripped_word.scan(/%3/).size - str_stripped_word.scan(/%4/).size
						int_open_super = int_open_super + str_stripped_word.scan(/%5/).size - str_stripped_word.scan(/%6/).size
						int_open_sub = int_open_sub + str_stripped_word.scan(/%7/).size - str_stripped_word.scan(/%8/).size
						int_open_smallcap = int_open_smallcap + str_stripped_word.scan(/%9/).size - str_stripped_word.scan(/%0/).size
						int_open_underline = int_open_underline + str_stripped_word.scan(/%J/).size - str_stripped_word.scan(/%K/).size
						int_open_strike = int_open_strike + str_stripped_word.scan(/%Y/).size - str_stripped_word.scan(/%Z/).size
						
						str_format_tags = add_close_format_tags(int_open_ital, int_open_bold, int_open_super, int_open_sub, int_open_smallcap, int_open_underline, int_open_strike)
						str_match_string = str_match_string + str_format_tags
						
						
						str_match_string = str_match_string + "</lem>"
						str_match_string = str_match_string + "<rdg type=\"" + str_type + "\""
						if (str_working_witnesses.length > 0)
							str_match_string = str_match_string + " wit=\"" + str_working_witnesses + "\""
						end
						str_match_string = str_match_string + ">" + str_new_working_base + "</rdg>"
						str_match_string = str_match_string + "</app>" + " "
						
						str_format_tags = add_open_format_tags(int_open_ital, int_open_bold, int_open_super, int_open_sub, int_open_smallcap, int_open_underline, int_open_strike)
						str_match_string = str_match_string + str_format_tags
						
					end 
					int_match_on = int_match_on + 1	
  				end	
  				int_match_num = int_match_num + 1
  			else
  			
				if (line_word =~ /%1/) 
					int_open_ital = int_open_ital + 1
				elsif (line_word =~ /%2/)
					int_open_ital = int_open_ital -1
				elsif (line_word =~ /%3/) 
					int_open_bold = int_open_bold + 1
				elsif (line_word =~ /%4/)
					int_open_bold = int_open_bold -1
				elsif (line_word =~ /%5/) 
					int_open_super = int_open_super + 1
				elsif (line_word =~ /%6/)
					int_open_super = int_open_super -1
				elsif (line_word =~ /%7/) 
					int_open_sub = int_open_sub + 1
				elsif (line_word =~ /%8/)
					int_open_sub = int_open_sub -1
				elsif (line_word =~ /%9/) 
					int_open_smallcap = int_open_smallcap + 1
				elsif (line_word =~ /%0/)
					int_open_smallcap = int_open_smallcap -1
				elsif (line_word =~ /%J/) 
					int_open_underline = int_open_underline + 1
				elsif (line_word =~ /%K/)
					int_open_underline = int_open_underline -1
				elsif (line_word =~ /%Y/) 
					int_open_strike = int_open_strike + 1
				elsif (line_word =~ /%Z/)
					int_open_strike = int_open_strike -1
				end
  			  			
  				str_match_string = str_match_string + line_word + " "
  			end
  			
  		end
  		
  		strip_variant_line = str_match_string.rstrip
		if (strip_variant_line.length > 0)
			ret_variant_line = strip_variant_line
		end 
	end
	return ret_variant_line
  end
  
  # replaces all occurances of seed string in haystack string
  # and returns the number of occurances replaces
  def replace_and_count(seed, haystack)
  	int_ret_count = message.scan(/#{Regexp.escape(seed)}/).size
  	return int_ret_count
  end
  
  # looks at the line designator type and returns an lg type for the lg
  def get_lg_type(str_line_designator)
  	ret_type = "poem"
  	if ( str_line_designator =~ /\d+/ || str_line_designator =~ /STZ/ || str_line_designator =~ /SZB/ || str_line_designator =~ /SZN/ )
		ret_type = "poem"					
	elsif ( str_line_designator =~ /SS/ )
		ret_type = "closer"							
	elsif ( str_line_designator =~ /HE/ || str_line_designator =~ /SEC/ || str_line_designator =~ /CH/ )
		ret_type = "head"	
	else
		ret_type = "misc"
	end
  	
  	return ret_type
  end
  
  def get_formatted_agent_name(int_agent_id)
  	str_author = ""  
	@agent = Agent.where("id = ?", int_agent_id)
	@agent.each do |auth_name_parts|
		bln_do_comma = false
		if auth_name_parts.agent_last_name.length > 0
			str_author = str_author + auth_name_parts.agent_last_name
			bln_do_comma = true
		end
		if auth_name_parts.agent_first_name.length > 0
			if bln_do_comma
				str_author = str_author + ","
			end
			str_author = str_author + " " + auth_name_parts.agent_first_name
		end 
		if auth_name_parts.agent_middle_name.length > 0
			str_author = str_author + " " + auth_name_parts.agent_middle_name
		end
		if auth_name_parts.agent_name_prefix.length > 0
			str_author = auth_name_parts.agent_name_prefix + " " + str_author
		end
		if auth_name_parts.agent_name_suffix.length > 0
			str_author = str_author + " " + auth_name_parts.agent_name_suffix
		end
		if auth_name_parts.agent_name_suffix.length > 0
			str_author = str_author + " " + auth_name_parts.agent_name_suffix
		end
	end
	str_author = str_author.gsub(/&/, "&amp;")		
  	return str_author
  end 
  
  def add_open_format_tags(int_open_ital, int_open_bold, int_open_super, int_open_sub, int_open_smallcap, int_open_underline, int_open_strike)
  
 	str_match_string = ""
  	
	int_it = 0
	while int_it < int_open_ital do
		str_match_string = str_match_string + "%1"
		int_it = int_it + 1
	end
	int_it = 0
	while int_it < int_open_bold do
		str_match_string = str_match_string + "%3"
		int_it = int_it + 1
	end													
	int_it = 0
	while int_it < int_open_super do
		str_match_string = str_match_string + "%5"
		int_it = int_it + 1
	end	
	int_it = 0
	while int_it < int_open_sub do
		str_match_string = str_match_string + "%7"
		int_it = int_it + 1
	end								
	int_it = 0
	while int_it < int_open_smallcap do
		str_match_string = str_match_string + "%9"
		int_it = int_it + 1
	end								
	int_it = 0
	while int_it < int_open_underline do
		str_match_string = str_match_string + "%J"
		int_it = int_it + 1
	end	
	int_it = 0
	while int_it < int_open_strike do
		str_match_string = str_match_string + "%Y"
		int_it = int_it + 1
	end	
	
	return str_match_string
	
  end
 
  
  def add_close_format_tags(int_open_ital, int_open_bold, int_open_super, int_open_sub, int_open_smallcap, int_open_underline, int_open_strike)
  
  	str_match_string = ""
  	
	int_it = 0
	while int_it < int_open_ital do
		str_match_string = str_match_string + "%2"
		int_it = int_it + 1
	end
	int_it = 0
	while int_it < int_open_bold do
		str_match_string = str_match_string + "%4"
		int_it = int_it + 1
	end													
	int_it = 0
	while int_it < int_open_super do
		str_match_string = str_match_string + "%6"
		int_it = int_it + 1
	end	
	int_it = 0
	while int_it < int_open_sub do
		str_match_string = str_match_string + "%8"
		int_it = int_it + 1
	end								
	int_it = 0
	while int_it < int_open_smallcap do
		str_match_string = str_match_string + "%0"
		int_it = int_it + 1
	end								
	int_it = 0
	while int_it < int_open_underline do
		str_match_string = str_match_string + "%K"
		int_it = int_it + 1
	end	
	int_it = 0
	while int_it < int_open_strike do
		str_match_string = str_match_string + "%Z"
		int_it = int_it + 1
	end	
  
  	return str_match_string
  
  end
  
  ######################
  # convertd from java #
  ######################
  
  def getLineDesignator(strLine)
		str_retVal = "line"

		str_tempstring = strLine.gsub(/(\w+\.?\w+\.?\w+?)(\s+?)(.*)/, '\1')

		arr_codes = str_tempstring.split(/\./)
		
		retVal = arr_codes[2]
		
		return retVal
  end

  def getStartCode(strLine)
    str_retVal = "line"

    str_tempstring = strLine.gsub(/(\w+\.?\w+\.?\w+?)(\s+?)(.*)/, '\1')

    arr_codes = str_tempstring.split(/\./)

    retVal = arr_codes[0]

    return retVal
  end
	
	  
  	def getBaseLine(strLine)
  	
		str_tempstring = strLine.gsub(/(\w+\.?\w+\.?\w+?)(\s+?)(.*)/, '\3')
		
		return str_tempstring
	end
	
	
	def makeSQLSafe(workingString)
		retString = workingString
    if retString
      retString = retString.gsub(/æ/, "&#230;")
      retString = retString.gsub(/…/, "&#133;")
      retString = retString.gsub(/ë/, "&#235;")
      retString = retString.gsub(/ô/, "&#244;")
      retString = retString.gsub(/Â/, "&#194;")
      retString = retString.gsub(/â/, "&#226;")
      retString = retString.gsub(/ë/, "&#235;")
    end
		return retString
  end



  def dopagetei(page_id)

    str_whole_doc_tei = "   <text type=\"digital_edition\" xml:id=\"PG_" + page_id.to_s + "\">\n"
    str_whole_doc_tei = str_whole_doc_tei + "   	<group>\n";
    str_whole_doc_tei = str_whole_doc_tei + dowalk(page_id, 0, request.host_with_port)
    str_whole_doc_tei = str_whole_doc_tei + "   	</group>\n"
    str_whole_doc_tei = str_whole_doc_tei + "   </text>\n"


    @page = Page.find(page_id)
    @page.page_tei = str_whole_doc_tei
    @page.save

  end



  def doeditiontei(de_id)
    digital_edition_id = de_id
    manifestation_id = 0
    ret_val = 0

    #first kill all the old tei version for this edition
    @oldtei = EditionTei.where("digital_edition_id = ?", digital_edition_id)
    @oldtei.each do |tek|
      tek.destroy
    end

    @dig_ed = DigitalEdition.where("id = ?", digital_edition_id)
    @dig_ed.each do |ed_record|
      manifestation_id = ed_record.manifestation_id
    end

    str_whole_doc_tei = "<TEI xmlns=\"http://www.tei-c.org/ns/1.0\">\n"
    str_whole_doc_tei = str_whole_doc_tei + do_edition_header(digital_edition_id, manifestation_id)
    str_whole_doc_tei = str_whole_doc_tei + "   <text type=\"digital_edition\" xml:id=\"DE_" + digital_edition_id.to_s + "\">\n"
    str_whole_doc_tei = str_whole_doc_tei + "   	<group>\n";
    str_whole_doc_tei = str_whole_doc_tei + dowalk(digital_edition_id, 1, request.host_with_port)
    str_whole_doc_tei = str_whole_doc_tei + "   	</group>\n"
    str_whole_doc_tei = str_whole_doc_tei + "   </text>\n"
    str_whole_doc_tei = str_whole_doc_tei + "</TEI>\n"

    @editiontei = EditionTei.new()
    @editiontei.digital_edition_id = digital_edition_id
    @editiontei.tei_build_tei = str_whole_doc_tei

    if @editiontei.save
      ret_val = 1
    end
    return ret_val
  end
	
end