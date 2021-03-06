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
                xmlns:papasan="http://redgates.com/2015/03/papasan/"
                version="1.0">
    <xsl:template match='text()' />
    <xsl:output method="text"/>
    <xsl:template match='/rdf:RDF/papasan:recovery-host/papasan:name'>
        <xsl:value-of select='.'/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
