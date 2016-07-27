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

	       <dc:title>Merge two XML/RDF files</dc:title>
  <dc:creator>Karl Redgate</dc:creator>
  <dc:description>
Merge the child nodes of the root of one XML document into the root
of the first XML document.
  </dc:description>

  <xsl:param name="etag" />
  <xsl:param name="lastmodified" />
  <xsl:param name="contentlength" />

  <xsl:template match="rdf:RDF" >
    <D:multistatus>
    <D:response>
    <D:propstat>
     <xsl:apply-templates />
    </D:propstat>
    </D:response>
    </D:multistatus>
  </xsl:template>

  <xsl:template match="rdf:RDF/*" >
    <D:prop>
      <D:resourcetype></D:resourcetype>
      <D:displayname></D:displayname>
      <D:iscollection>0</D:iscollection>
      <D:getcontentlength><xsl:value-of select="$contentlength" /></D:getcontentlength>
      <D:getcontenttype>application/rdf+xml</D:getcontenttype>
      <D:getetag><xsl:value-of select="$etag" /></D:getetag>
      <D:getlastmodified><xsl:value-of select="$lastmodified" /></D:getlastmodified>
      <D:creationdate>1970-01-01T00:00:00Z</D:creationdate>
      <xsl:apply-templates />
    </D:prop>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
