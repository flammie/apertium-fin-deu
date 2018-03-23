<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="5.0"/>

  <xsl:param name="from"/>
  <xsl:param name="to"/>
  <xsl:param name="pair"/>
  <xsl:param name="version"/>
  <xsl:param name="invert"/>

  <xsl:template match="transfer|interchunk|postchunk|dictionary">
    <!-- lot of c/p from the jekyll outp  {{{ -->
    <html>
      <head>
        <meta charset="utf-8"/>
          <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
          <meta name="viewport" content="width=device-width"/>
        <title>apertium-fin-deu
             : Apertium-fin-deu
        </title>
        <meta name="description" 
          content="Finnish–German transfer for rule-based machine translation"/>

        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="/apertium-fin-deu/css/syntax.css"/>
        <link rel="stylesheet" href="/apertium-fin-deu/css/main.css"/>
      </head>
      <body>
        <div class="container">
          <div class="row">
            <div id="header" class="col-sm-12">
              <xsl:copy-of select="document('header.html')"/>
            </div>
          </div>
          <div class="row">
            <div id="navigation" class="col-sm-2">
              <xsl:copy-of select="document('navigation.html')"/>
            </div>
            <div id="content" class="col-sm-10">
              <h1 id="dictionary">Statistics
                Apertium-fin-deu–Finnish–German dictionary and RBMT resources
              </h1>
              <h2><code><xsl:value-of 
                    select="tokenize(base-uri(), '/')[last()]"/></code></h2>
              <xsl:apply-templates/>
            </div>
          </div>
          <div class="row">
            <div id="footer" class="col-sm-12">
              <xsl:copy-of select="document('footer.html')"/>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="alphabet">
    <h3>Alphabet</h3>
    <p>
      There are
      <xsl:value-of select="string-length(.)"/>
      symbols in this dictionary
    </p>
  </xsl:template>
      
  <xsl:template match="sdefs">
    <h3>Tags (Multichar Symbols)</h3>
    <p>
      There are
      <xsl:value-of select="count(sdef)"/>
      symbols in this dictionary
    </p>
  </xsl:template>

  <xsl:template match="pardefs">
    <h3>Paradigms</h3>
    <p>
      There are
      <xsl:value-of select="count(pardef)"/>
      paradigms in this dictionary
    </p>
  </xsl:template>

  <xsl:template match="section">
    <h3>Dictionary <xsl:value-of select="@id"/></h3>
    <p>
      There are
      <xsl:value-of select="count(e)"/>
      words in the dictionary part <xsl:value-of select="@id"/>
    </p>
  </xsl:template>

  <xsl:template match="section-def-cats">
    <h3>Categories (parts of chunks)</h3>
    <p>
      There are
      <xsl:value-of select="count(def-cat)"/>
      cats in this ruleset
    </p>
  </xsl:template>


  <xsl:template match="section-def-attrs">
    <h3>Attributes</h3>
    <p>
      There are
      <xsl:value-of select="count(def-attr)"/>
      attrs in this ruleset
    </p>
  </xsl:template>


  <xsl:template match="section-def-macros">
    <h3>Macros</h3>
    <p>
      There are
      <xsl:value-of select="count(def-macro)"/>
      attrs in this ruleset
    </p>
  </xsl:template>

  <xsl:template match="section-rules">
    <h3>Rules</h3>
    <p>
      There are
      <xsl:value-of select="count(rule)"/>
      attrs in this ruleset
    </p>
  </xsl:template>


</xsl:stylesheet>
