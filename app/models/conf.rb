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
class Conf < ActiveRecord::Base
  attr_accessible :conf_build_concordance, :conf_build_variants, :conf_contact_email, :conf_contact_form, :conf_group_expression_type, :conf_group_manifestation_type, :conf_site_domain_name, :conf_site_facsimile_root, :conf_site_httpd_root, :conf_site_name, :conf_site_tagline, :conf_site_transcription_root, :conf_site_xslt_directory, :config_active, :conf_publisher, :conf_publisher_url, :conf_publisher_location, :conf_publisher_license, :conf_site_editor_name, :conf_splash
end
