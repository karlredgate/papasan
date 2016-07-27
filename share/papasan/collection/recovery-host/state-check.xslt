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

    <dc:title>List of recovery host to fix state</dc:title>
    <dc:description>
        Return a list of recovery hosts whose desired state and current state
        values differ.  When this is the case the VMs need to be updated.
    </dc:description>

    <xsl:output method="text"/>
    <xsl:template match='text()' />

    <dc:description>
        This is an unhandled case and calls the unhandled case script.
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state != papasan:current-state]'>
        <xsl:text>spawn-job resolve-state </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text> </xsl:text>
        <xsl:value-of select='papasan:current-state' />
        <xsl:text> </xsl:text>
        <xsl:value-of select='papasan:desired-state' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <dc:description>
        In addition to the UUID - it would probably be easier if the
        command was passed the recovery hostname and customer UUID.
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state="running" and papasan:current-state="stopped"]'>
        <xsl:text>spawn-job start-recovery-host </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <dc:description>
        In addition to the UUID - it would probably be easier if the
        command was passed the recovery hostname and customer UUID.
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state="stopped" and papasan:current-state="running"]'>
        <xsl:text>spawn-job shutdown-recovery-host </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <dc:description>
        In addition to the UUID - it would probably be easier if the
        command was passed the recovery hostname and customer UUID.
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state="running" and papasan:current-state="unknown"]'>
        <xsl:text>spawn-job create-recovery-host </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <dc:description>
        Eventually we want some sort of eventing for this, but for now we can 
        just check every so often
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state="running" and papasan:current-state="creating"]'>
        <xsl:text>spawn-job check-recovery-host </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
    
    <dc:description>
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state="running" and papasan:current-state="created"]'>
        <xsl:text>spawn-job prepare-recovery-host </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

    <dc:description>
    </dc:description>
    <xsl:template match='/rdf:RDF/papasan:recovery-host[papasan:desired-state="running" and papasan:current-state="prepared"]'>
        <xsl:text>spawn-job recover-recovery-host </xsl:text>
        <xsl:value-of select='papasan:uuid' />
        <xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
<!-- vim: set autoindent expandtab sw=4 syntax=xslt: -->
