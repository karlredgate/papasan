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
               xmlns:papasan="http://redgates.com/2015/03/papasan/"
               xmlns:D="DAV:"
               version="1.0">

  <dc:title></dc:title>
  <dc:creator>Karl Redgate</dc:creator>
  <dc:description>
  </dc:description>

  <xsl:param name="hostname" />
  <xsl:param name="uuid" />

  <xsl:template match="/rdf:RDF/*[@rdf:about]" >
    <xsl:copy><xsl:apply-templates /></xsl:copy>
      <xsl:message terminate="yes">
          <xsl:text>Error: RDF document already has an rdf:about attribute</xsl:text>
      </xsl:message>
  </xsl:template>

  <xsl:template match="/rdf:RDF/*/papasan:current-state" >
    <xsl:copy><xsl:apply-templates /></xsl:copy>
      <xsl:message terminate="yes">
          <xsl:text>Error: RDF document has a current-state property</xsl:text>
      </xsl:message>
  </xsl:template>

  <xsl:template match="/rdf:RDF/*[not(@rdf:about)]" >
    <xsl:variable name="collection" select="substring-after(name(),':')" />
    <xsl:copy>
        <xsl:attribute name="rdf:about">
            <xsl:text>http://</xsl:text>
            <xsl:value-of select="$hostname" />
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$collection" />
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$uuid" />
            <xsl:text>.rdf</xsl:text>
        </xsl:attribute>
        <xsl:element name="papasan:uuid">
            <xsl:value-of select="$uuid" />
        </xsl:element>
        <xsl:element name="D:resourcetype" />
        <xsl:if test='not(papasan:desired-state)'>
            <xsl:element name='papasan:desired-state'>running</xsl:element>
        </xsl:if>
        <xsl:if test='not(papasan:current-state)'>
            <xsl:element name='papasan:current-state'>unknown</xsl:element>
        </xsl:if>
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
