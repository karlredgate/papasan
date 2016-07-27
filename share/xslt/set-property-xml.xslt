<?xml version="1.0"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:fn='http://www.w3.org/2005/02/xpath-functions'
               xmlns:xsd='http://www.w3.org/2001/XMLSchema'
               xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'
               xmlns:dc="http://purl.org/dc/elements/1.1/"
	             xmlns:dcterms="http://purl.org/dc/terms/"
	             xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	             xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	             xmlns:owl="http://www.w3.org/2002/07/owl#"
               xmlns:D="DAV:"
               version="1.0">

  <dc:title></dc:title>
  <dc:creator>Kris Brakke</dc:creator>
  <dc:description>
    Need this to be able to set the href in an xml document.
    Sadly it not being an rdf and not having the same tree depth
    means that the othet set-property doesn't work
  </dc:description>

  <xsl:param name="property" />
  <xsl:param name="value" />

  <xsl:template match="/D:multistatus/*/*" >
      <xsl:choose>
          <xsl:when test="name()=$property">
              <xsl:copy>
                <xsl:value-of select="$value" />
              </xsl:copy>
          </xsl:when>
          <xsl:otherwise>
              <xsl:copy-of select="." />
          </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
