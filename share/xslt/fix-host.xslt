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
               version="1.0">

  <dc:title></dc:title>
  <dc:creator>Karl Redgate</dc:creator>
  <dc:description>
  </dc:description>

  <xsl:param name="hostname" />

  <xsl:template match="/rdf:RDF/*" >
    <xsl:variable name="hostpath" select="substring-after(@rdf:about,'http://')" />
    <xsl:variable name="host" select="substring-before($hostpath,'/')" />
    <xsl:variable name="path" select="substring-after($hostpath,'/')" />

    <xsl:copy>
        <xsl:attribute name="rdf:about">
            <xsl:text>http://</xsl:text>
            <xsl:value-of select="$hostname" />
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$path" />
        </xsl:attribute>
        <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
