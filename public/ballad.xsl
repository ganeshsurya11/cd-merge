<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#xa0;"> <!--known for HTML output, not in XML-->
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="render">
	<xsl:param name="style"/>
	<xsl:choose>
		<xsl:when test="$style='italic'">
			<i><xsl:apply-templates/></i>
		</xsl:when>
		<xsl:when test="$style='bold'">
			<b><xsl:apply-templates/></b>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="/">
	<html>
		<head>
			<title>Ballad XSLT Template</title>
			<style type="text/css">
				#globaltitle {
					font-family: "Times", Verdana, Arial, sans-serif;
					font-size: 21px;
					margin-left: 0px;
					margin-right: 0px;
					margin-top: 0px;
					margin-bottom: 20px;
				}
				#parttitle {
					font-family: "Times", Verdana, Arial, sans-serif;
					font-size: 19px;
					margin-left: 0px;
					margin-right: 0px;
					margin-top: 20px;
					margin-bottom: 20px;
				}
				#lg {
					font-family: "Times", Verdana, Arial, sans-serif;
					font-size: 15px;
					margin-left: 0px;
					margin-right: 0px;
					margin-top: 0px;
					margin-bottom: 0px;
				}
				#partcloser {
					font-family: "Times", Verdana, Arial, sans-serif;
					font-size: 15px;
					margin-left: 0px;
					margin-right: 0px;
					margin-top: 0px;
					margin-bottom: 0px;
				}
				#globalcloser {
					font-family: "Times", Verdana, Arial, sans-serif;
					font-size: 20px;
					margin-left: 0px;
					margin-right: 0px;
					margin-top: 0px;
					margin-bottom: 0px;
				}
				
			</style>
		</head>
		<body>
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr><td valign="top" align="right">
					<a href="test-two-part-ballad-1.xml" target="blank"><img src="xml-tei_button.gif" /></a>
				</td></tr>
				<xsl:for-each select="//div[@type='ballad']/opener">
					<tr><td valign="top" align="center">
						<div id="globaltitle">
						<xsl:for-each select="seg">
								<xsl:apply-templates/><br />
						</xsl:for-each>
						</div>
					</td></tr>
				</xsl:for-each>
				<tr><td><table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
				<xsl:for-each select="//div[@type='part']">	
					<td valign="top" align="center">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr><td align="center">
								<xsl:for-each select="head/title">
									<div id="parttitle">
									<xsl:for-each select="seg">
										<xsl:apply-templates/><br />
									</xsl:for-each>
									</div>
								</xsl:for-each>
							</td></tr>							
							<tr><td align="center">	
								<table border="0">
								<tr><td align="left">
								<xsl:for-each select="div[@type='col']">
									<xsl:for-each select="lg">
										<div id="lg">
										<p>
										<table border="0" cellpadding="0" cellspacing="0">
										<xsl:for-each select="l">
											<tr><td valign="top" align="left">
											<xsl:choose>
												<xsl:when test="@rend = 'left'">
													<xsl:apply-templates/><br />
												</xsl:when>
												<xsl:otherwise>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:apply-templates/><br />
												</xsl:otherwise>
											</xsl:choose>
											</td></tr>
										</xsl:for-each>
										</table>
										</p>
										</div>
									</xsl:for-each>
								</xsl:for-each>	
								</td></tr>
						
								<tr><td align="left">						
									<xsl:for-each select="closer">
										<div id="partcloser">
										<xsl:for-each select="seg">
											<xsl:choose>
												<xsl:when test="@rend = 'left'">
													<xsl:apply-templates/><br />
												</xsl:when>
												<xsl:otherwise>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<xsl:apply-templates/><br />
												</xsl:otherwise>
											</xsl:choose>
										</xsl:for-each>
										</div>
									</xsl:for-each>
								</td></tr>
								
							</table>
							</td></tr>	
								
						</table>
					</td>
				</xsl:for-each>
				</tr>
			</table></td></tr>
			<xsl:for-each select="//div[@type='ballad']/closer">
				<tr><td><br /></td></tr>
				<tr><td valign="top" align="center">
					<div id="globalcloser">
						<p>
						<xsl:for-each select="seg">
								<xsl:apply-templates/><br />
						</xsl:for-each>
						</p>
					</div>
				</td></tr>
			</xsl:for-each>
			</table>
		</body>
	</html>
</xsl:template>



<xsl:template match="hi">
 <xsl:choose>
  <xsl:when test="@rend">
   <xsl:call-template name="render">
<xsl:with-param name="style" select="@rend"/>
</xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
   <xsl:apply-templates/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>
</xsl:stylesheet> 