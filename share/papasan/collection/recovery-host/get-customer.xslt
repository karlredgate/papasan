<?xml version="1.0"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:fn='http://www.w3.org/2005/02/xpath-functions'
               xmlns:xsd='http://www.w3.org/2001/XSL/XMLSchema'
               xmlns:xsi='http://www.w3.org/2001/XSL/XMLSchema-instance'
               xmlns:dc="http://purl.org/dc/elements/1.1/"
	       xmlns:dcterms="http://purl.org/dc/terms/"
	       xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	       xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	       xmlns:owl="http://www.w3.org/2002/07/owl#"
               xmlns:papasan="http://redgates.com/2015/03/papasan/"
               version="1.0">

    <dc:title></dc:title>
    <dc:creator>Kris Brakke</dc:creator>
    <dc:description>
    We need to get the customer id from this
    </dc:description>

    <xsl:output method="text"/>
    <xsl:template match='text()' />
    <xsl:template match='/rdf:RDF/papasan:recovery-host'>
        <xsl:variable name = 'uri' select='papasan:customer/@rdf:resource'/>
        <xsl:variable name = 'rdf' select="substring-before(substring-after($uri, '/customer/'), '.rdf')"/>
        <xsl:value-of select="$rdf"/>
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:transform>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
