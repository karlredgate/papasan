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

  <dc:title>PROPFIND Meta-stylesheet</dc:title>
  <dc:creator>Karl Redgate</dc:creator>
  <dc:description>
      Translate a propfind xml document into an xslt that can be used
      against an RDF document to return propfind results.
  </dc:description>

  <xsl:output method="xml" indent="yes" />
  <xsl:namespace-alias stylesheet-prefix="rdf" result-prefix="rdf" />
  <xsl:key name='ns' match='/*/namespace::*' use='string(.)' />

  <dc:description>
      The propfind element wraps the query types.  This is translated to
      the transform element of the generated stylesheet.  The general
      templates are added here also - since they do not change based on
      the query type.

      Since this is a stylesheet that generates a stylesheet, the target
      elements have the same name as templates that would be recognized as
      first pass templates.  So, the must be created using the
      xsl:element elements to "escape" them.

      The rdf:about attribute here is used to force the rdf namespace
      declaration into the result document.  If we do not do this then
      the template that matches rdf:RDF elements fail.
  </dc:description>
  <xsl:template match="D:propfind" >
      <xsl:element name="xsl:transform">
          <xsl:copy-of select="//namespace::*"/>
          <!-- <xsl:copy-of select="document('')/xsl:stylesheet/namespace::rdf" /> -->
          <xsl:attribute name="rdf:about">http://redgates.com/2015/03/papasan/propfind.xslt</xsl:attribute>
          <xsl:attribute name="version">1.0</xsl:attribute>

          <xsl:element name="xsl:template">
              <xsl:attribute name="match">text()</xsl:attribute>
          </xsl:element>

          <xsl:element name="xsl:template">
              <xsl:attribute name="match">rdf:RDF</xsl:attribute>
              <D:multistatus>
                  <xsl:element name="xsl:apply-templates" />
              </D:multistatus>
          </xsl:element>

          <xsl:element name="xsl:template">
              <xsl:attribute name="match">
                  <xsl:text>child::*[local-name() = 'displayname'][namespace-uri() = 'DAV:']</xsl:text>
              </xsl:attribute>
              <xsl:element name="xsl:copy-of">
                  <xsl:attribute name="select">.</xsl:attribute>
              </xsl:element>
          </xsl:element>

          <xsl:element name="xsl:template">
              <xsl:attribute name="match">
                  <xsl:text>child::*[local-name() = 'resourcetype'][namespace-uri() = 'DAV:']</xsl:text>
              </xsl:attribute>
              <xsl:element name="xsl:copy-of">
                  <xsl:attribute name="select">.</xsl:attribute>
              </xsl:element>
          </xsl:element>

          <xsl:element name="xsl:template">
              <xsl:attribute name="match">rdf:RDF/*</xsl:attribute>
              <D:response>
                <D:href>
                    <xsl:element name="xsl:value-of">
                        <xsl:attribute name="select">@rdf:about</xsl:attribute>
                    </xsl:element>
                </D:href>
                <D:propstat>
                    <D:prop>
                        <xsl:element name="xsl:apply-templates" />
                    </D:prop>
                    <D:status>HTTP/1.1 200 OK</D:status>
                </D:propstat>
              </D:response>
          </xsl:element>

          <xsl:apply-templates />

      </xsl:element>
  </xsl:template>

  <dc:description>
  This is searching the namespaces in the processed doc
  I need the namespaces in the current stylesheet
  </dc:description>
  <xsl:template match="D:prop/*" >
          <xsl:element name="xsl:template">
              <xsl:attribute name="match">
                  <xsl:text>child::*[local-name() = '</xsl:text>
                  <xsl:value-of select="local-name()" />
                  <xsl:text>'][namespace-uri() = '</xsl:text>
                  <xsl:value-of select="namespace-uri()" />
                  <xsl:text>']</xsl:text>
              </xsl:attribute>
              <xsl:element name="xsl:copy-of">
                  <xsl:attribute name="select">.</xsl:attribute>
              </xsl:element>
          </xsl:element>
  </xsl:template>

  <dc:description>
  </dc:description>
  <xsl:template match="D:prop/D:allprop" >
      <xsl:element name="xsl:template">
          <xsl:attribute name="match">
              <xsl:text>rdf:RDF/*/*</xsl:text>
          </xsl:attribute>
          <xsl:element name="xsl:copy-of">
              <xsl:attribute name="select">.</xsl:attribute>
          </xsl:element>
      </xsl:element>
  </xsl:template>

  <dc:description>
  </dc:description>
  <xsl:template match="D:propname" >
  </xsl:template>

  <dc:description>
  </dc:description>
  <xsl:template match="D:include" >
  </xsl:template>

</xsl:transform>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
