<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
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

    <xsl:template match='text()' />
    <xsl:output method="text"/>
    <xsl:strip-space elements="*" />

    <xsl:template match='/'>
        <xsl:text>{&#10;</xsl:text>
        <xsl:apply-templates />
        <xsl:text>}&#10;</xsl:text>
    </xsl:template>

    <xsl:template match='D:propertyupdate/D:set/D:prop/*'>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="name(.)"/>
        <xsl:text>":"</xsl:text>
        <xsl:value-of select='.'/>
        <xsl:text>"</xsl:text>
        <xsl:if test="not(position() = last())"><xsl:text>,</xsl:text></xsl:if>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
