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
               xmlns:D="DAV:"
               version="1.0">

    <xsl:param name="prop" />
    <xsl:param name="response"/>

    <xsl:template match="/D:multistatus/D:response">
        <xsl:copy>
            <xsl:apply-templates/>
            <D:propstat>
                <D:prop><xsl:element name="{$prop}" /></D:prop>
                <D:status><xsl:value-of select="$response" /></D:status>
            </D:propstat>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:transform>
