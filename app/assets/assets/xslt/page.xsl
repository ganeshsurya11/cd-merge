<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
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
  <xsl:template match="hi">
    <xsl:choose>
      <xsl:when test="@style">
        <span style="{@style}"><xsl:apply-templates/></span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="TEI">
    <xsl:for-each select="l">
      <xsl:choose>
        <xsl:when test="@style">
          <div style="{@style}margin-bottom: 4px;"><xsl:apply-templates/></div>
        </xsl:when>
        <xsl:otherwise>
          <div style="margin-bottom: 4px;"><xsl:apply-templates/></div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>


  <xsl:template match="app">
    <xsl:variable name="variant">
      <xsl:for-each select="rdg">
        <xsl:value-of select="@type"/>: <xsl:value-of select="."/> (<xsl:value-of select="@wit"/>)\n
      </xsl:for-each>
    </xsl:variable>
    <xsl:value-of select="lem"/><span class="variant_link"><a href="javascript:alert('{$variant}')">*</a></span>
  </xsl:template>


</xsl:stylesheet> 