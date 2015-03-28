<?xml version="1.0"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:fn='http://www.w3.org/2005/02/xpath-functions'
               xmlns:xsd='http://www.w3.org/2001/XSL/XMLSchema'
               xmlns:xsi='http://www.w3.org/2001/XSL/XMLSchema-instance'
               xmlns:dc="http://purl.org/dc/elements/1.1/"
               version="1.0">

  <dc:title>Merge two XML files</dc:title>
  <dc:creator>Karl Redgate</dc:creator>
  <dc:description>
Merge the child nodes of the root of one XML document into the root
of the first XML document.
  </dc:description>

  <xsl:param name="filename" />

  <xsl:template match="/*" >
    <xsl:copy>
     <xsl:apply-templates />
     <xsl:copy-of select="document($filename)/node()[1]/*" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
