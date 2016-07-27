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

  <dc:title>Translate RDF to JSON</dc:title>
  <dc:creator>Karl Redgate</dc:creator>
  <dc:description>
    The strip-space element eliminates space only text nodes, which have a side effect
    when using the position() function - where there are many more positions than there
    are elements.  Usually you see this as all your position()s are even numbered.
  </dc:description>

  <xsl:output method="text"/>
  <xsl:strip-space elements="*" />

  <dc:description>
  This template eats all text nodes that do not already have a template
  that matches.  This makes sure that we only output what we intended.
  </dc:description>
  <xsl:template match='text()' />

  <xsl:template match="rdf:RDF" >
    <xsl:text>[&#10;</xsl:text>
     <xsl:apply-templates />
    <xsl:text>]&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="rdf:RDF/*" >
    <xsl:text>{&#10;</xsl:text>
      <xsl:apply-templates />
      <xsl:text>"rdf:about":"</xsl:text>
      <xsl:value-of select="@rdf:about" />
      <xsl:text>"&#10;</xsl:text>
    <xsl:text>}</xsl:text>
    <xsl:if test="not(position() = last())"><xsl:text>,</xsl:text></xsl:if>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <dc:description>
      The "[not(*)]" part of this XPath chooses nodes that have
      no children nodes.
  </dc:description>
  <xsl:template match="rdf:RDF/*/*[not(*)]" >
    <xsl:text>"</xsl:text>
    <xsl:value-of select="name()" />
    <xsl:text>":"</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>",&#10;</xsl:text>
  </xsl:template>

  <dc:description>
      Need to check to see if there is a customer.
  </dc:description>
  <xsl:template match="rdf:RDF/*/*[@rdf:resource]" >
    <xsl:text>"</xsl:text>
    <xsl:value-of select="name()" />
    <xsl:text>":"</xsl:text>
    <xsl:value-of select="@rdf:resource" />
    <xsl:text>",&#10;</xsl:text>
  </xsl:template>

</xsl:transform>

<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
