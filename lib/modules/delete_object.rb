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

module DeleteObject

  def delete_manifestation_event(manifestation_id)
    int_ret_status = 0
    manifestationevent = ManifestationEvent.find(manifestation_id)
    if manifestationevent.destroy
      int_ret_status = 1
    end
    #return status 1=success/0=failure
    return int_ret_status
  end


  def delete_expression_has_manifestation(record_id)
    int_ret_status = 0
    expressionhasmanifestation = ExpressionsHasManifestations.find(record_id)
    if expressionhasmanifestation.destroy
      int_ret_status = 1
    end
    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_tei(tei_id)
    int_ret_status = 0
    teirecord = EditionTei.find(tei_id)
    if teirecord.destroy
      int_ret_status = 1
    end
    return int_ret_status
  end

  def delete_line(line_id)
    int_ret_status = 0
    line = Line.find(line_id)
    if line.destroy
      int_ret_status = 1
    end
    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_item(item_id)
    int_ret_status = 0
    int_errors = 0
    item = Item.find(item_id)

    #delete any associated events
    itemevents = ItemEvent.where("item_id = ?", item_id)
    itemevents.each do |ied|
      itemeventsagents = ItemEventsHasAgents.where("item_event_id = ?", ied.id)
      itemeventsagents.each do |iead|
        int_del_iead_ret = delete_item_event_agent(iead.id)
        if int_del_iead_ret < 1
          int_errors = int_errors + 1
        end
      end
      int_del_itemevents_ret = delete_item_event(ied.id)
      if int_del_itemevents_ret < 1
        int_errors = int_errors + 1
      end
    end

    #delete the item
    if item.destroy
      #if the item was successfully destroyed, set all references to
      #it in the digital_editions table to null
      loopeditions = DigitalEdition.where("item_id = ?", item_id)
      loopeditions.each do |led|
        diged = DigitalEdition.find(led.id)
        diged.item_id = nil
        if !diged.save
          int_errors = int_errors + 1
        end
      end
    else
      int_errors = int_errors + 1
    end

    if (int_errors < 1)
      int_ret_status = 1
    end

    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_item_event(item_id)
    int_ret_status = 0
    itemevent = ItemEvent.find(item_id)
    if itemevent.destroy
      int_ret_status = 1
    end
    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_item_event_agent(record_id)
    int_ret_status = 0
    itemeventhasagent = ItemEventsHasAgents.find(record_id)
    if itemeventhasagent.destroy
      int_ret_status = 1
    end
    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_transcription(trans_id)
    int_ret_status = 0
    transcription = Transcription.find(trans_id)
    logger.debug "Attempting to remove transcription file for transcription "+trans_id.to_s
    transcription.transcription_file.remove!
    logger.debug "Attempting to delete transcription record "+trans_id.to_s
    if transcription.destroy
      int_ret_status = 1
      logger.debug "Successfully deleted transcription record "+trans_id.to_s
    end
    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_page(page_id)
    int_ret_status = 1

    #delete associated lines
    int_line_delete_errors = 0
    lines = Line.where("page_id = ?", page_id)
    lines.each do |dl|
      int_ld_ret = delete_line(dl.id)
      if int_ld_ret < 1
        int_line_delete_errors = int_line_delete_errors + 1
      end
    end

    #delete associated transcriptions
    int_trans_delete_errors = 0
    transcriptions = Transcription.where("page_id = ?", page_id)
    transcriptions.each do |td|
      int_tr_del_ret =  delete_transcription(td.id)
      if int_tr_del_ret < 1
        int_trans_delete_errors = int_trans_delete_errors + 1
      end
    end

    #delete page
    int_page_del_error = 1
    page = Page.find(page_id)
    page.page_image.remove!
    if page.destroy
      int_page_del_ret = 0
    end

    #check for errors
    if (int_line_delete_errors > 0 || int_trans_delete_errors > 0 || int_page_del_error > 0)
      int_ret_status = 1
    end

    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_digital_edition(digital_edition_id)
    int_ret_status = 1

    #delete associated pages and all sub children
    int_page_delete_errors = 0
    pages = Page.where("digital_edition_id = ?", digital_edition_id)
    pages.each do |pd|
       int_del_page_ret = delete_page(pd.id)
       if int_del_page_ret < 1
         int_page_delete_errors = int_page_delete_errors + 1
       end
    end

    #delete associated TEI
    int_tei_delete_errors = 0
    tei = EditionTei.where("digital_edition_id = ?", digital_edition_id)
    tei.each do |teid|
      int_del_tei_ret = delete_tei(teid.id)
      if int_del_tei_ret < 1
        int_tei_delete_errors = int_tei_delete_errors + 1
      end
    end

    #delete edition
    int_edition_delete_error = 1
    digitaledition = DigitalEdition.find(digital_edition_id)
    if digitaledition.destroy
      int_edition_delete_error = 0
    end

    #check for errors
    if (int_page_delete_errors > 0 || int_edition_delete_error > 0 || int_tei_delete_errors > 0)
      int_ret_status = 0
    end

    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_manifestation(manifestation_id)
    int_ret_status = 1

    #delete associated items and events
    int_del_it_errors = 0
    items = Item.where("manifestation_id = ?", manifestation_id)
    items.each do |itd|
       int_del_item_ret = delete_item(itd.id)
       if int_del_item_ret < 1
        int_del_it_errors = int_del_it_errors + 1
       end
    end


    #delete associated digital editions and all sub-children
    int_del_de_errors = 0
    digitaleditions = DigitalEdition.where("manifestation_id = ?", manifestation_id)
    digitaleditions.each do |de|
      int_del_editions_ret = delete_digital_edition(de.id)
      if int_del_editions_ret < 1
        int_del_de_errors = int_del_de_errors + 1
      end
    end

    #delete manifestation events
    int_del_man_event_errors = 0
    manifestationents = ManifestationEvent.where("manifestation_id = ?", manifestation_id)
    manifestationents.each do |me|
      int_del_man_event_ret = delete_manifestation_event(manifestation_id)
      if (int_del_man_event_ret < 1)
        int_del_man_event_errors = int_del_man_event_errors + 1
      end
    end

    #delete expression/manifestation associations
    int_del_exp_man_assoc_errors = 0
    expressionhasmanifestations = ExpressionsHasManifestations.where("manifestation_id = ?", manifestation_id)
    expressionhasmanifestations.each do |ehmd|
      int_del_exp_man_assoc_ret = delete_expression_has_manifestation(ehmd.id)
      if (int_del_exp_man_assoc_ret < 1)
        int_del_exp_man_assoc_errors = int_del_exp_man_assoc_errors + 1
      end
    end

    #delete manifestation
    int_manifestation_delete_error = 1
    manifestation = Manifestation.find(manifestation_id)
    if manifestation.destroy
      int_manifestation_delete_error = 0
    end

    #check for errors
    if (int_manifestation_delete_error > 0 || int_del_exp_man_assoc_errors > 0 || int_del_man_event_errors > 0 || int_del_de_errors > 0)
      int_ret_status = 0
    end

    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_expression(expression_id)
    int_ret_status = 1
    int_total_errors = 0

    #load the record to be deleted
    thisexpression = Expression.find(expression_id)

    #if this is the expression of a FRBR primary level Work (not a sub work)
    if (thisexpression.work.work_frbr?)
      logger.debug "Deleting a Primary Expression"

      #get manifestation associations
      manifestationshasexpressions = ExpressionsHasManifestations.where("expression_id = ?", expression_id)
      manifestationshasexpressions.each do |mhe|
        int_man_id = mhe.manifestation_id
        #delete the associated manifestation
        int_man_delete_ret = delete_manifestation(int_man_id)
        if int_man_delete_ret < 1
          int_total_errors = int_total_errors + 1
        end
      end

    # if this is the expression of  a sub work
    else

      logger.debug "Deleting a Secondary Expression"

      #delete associated transcriptions
      extranscriptions = Transcription.where("expression_id = ?", expression_id)
      extranscriptions.each do |extd|
        # foreach transcription, kill the associated lines
        thislines = Line.where("transcription_id = ?", extd.id)
        thislines.each do |dl|
          int_ld_ret = delete_line(dl.id)
          if int_ld_ret < 1
            int_del_expression_error = int_del_expression_error + 1
          end
        end
        int_tr_del_ret =  delete_transcription(extd.id)
        if int_tr_del_ret < 1
          int_del_expression_error = int_del_expression_error + 1
        end
      end

    end

    #delete expression
    int_del_expression_error = 1
    expression = Expression.find(expression_id)
    if expression.destroy
      int_del_expression_error = 0
    end
    int_total_errors = int_total_errors + int_del_expression_error


    #check for errors
    if (int_total_errors > 0)
      int_ret_status = 0
    end

    #return status 1=success/0=failure
    return int_ret_status
  end

  def delete_work(work_id)
    int_ret_status = 1

    #delete associated expressions and sub-children
    #note:  expression level will determine whether to fork
    # into primary or secondary work deletion mode
    int_del_expression_error = 0
    expressions = Expression.where("work_id = ?", work_id)
    expressions.each do |exd|
      int_expression_del_ret = delete_expression(exd.id)
      if int_expression_del_ret < 1
        int_del_expression_error = int_del_expression_error + 1
      end
    end

    #delete work if all sub expressions were deleted
    if int_del_expression_error < 1
      int_del_work_error = 1
      work = Work.find(work_id)
      if work.destroy
        int_del_work_error = 0
      end
    end

    #check for errors
    if (int_del_expression_error > 0 || int_del_work_error > 0)
      int_ret_status = 0
    end

    #return status 1=success/0=failure
    return int_ret_status
  end

end