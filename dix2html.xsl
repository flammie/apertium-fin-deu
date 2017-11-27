<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="5.0"/>

  <xsl:param name="from"/>
  <xsl:param name="to"/>
  <xsl:param name="pair"/>
  <xsl:param name="version"/>
  <xsl:param name="invert"/>

  <xsl:template match="dictionary">
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
          content="Finnish–German dictionary for rule-based machine translation"/>

        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="/apertium-fin-deu/css/syntax.css"/>
        <link rel="stylesheet" href="/apertium-fin-deu/css/main.css"/>
      </head>
      <body>
        <div class="container">
          <div class="row">
            <div id="header" class="col-sm-12">
              <h4>
                <a class="brand" href="/apertium-fin-deu/">apertium-fin-deu</a>
                <small>Finnish–German dictionary for rule-based
                  machine translation</small>
              </h4>
            </div>
          </div>
          <div class="row">
            <div id="navigation" class="col-sm-2">
              <nav>
                <ul class="nav nav-list">
                  <li><a href="/apertium-fin-deu/">Home</a></li>
                  <li><a class="external" href="//github.com/flammie/apertium-fin-deu/#readme">README</a></li>
                  <li><a href="/apertium-fin-deu/statistics.html">Statistics</a></li>
                </ul>
              </nav>
            </div>
            <div id="content" class="col-sm-10">
              <h1 id="dictionary">Dictionary visualisation:
                Apertium-fin-deu–Finnish–German dictionary and RBMT resources
              </h1>
              <p style="font-variant: italic">
                This dictionary has been generated automatically from the XML
                dictionary data. It is intended for visualisation.
              </p>
              <h2>Alphabets</h2>
              <xsl:apply-templates select="alphabet"/>
              <h2>Apertium tags (for POS and MSD features</h2>
              <xsl:apply-templates select="sdefs"/>
              <h2>Words</h2>
              <xsl:apply-templates select="section"/>
            </div>
          </div>
          <div class="row">
            <div id="footer" class="col-sm-12">
              Documentation for
              <a href="https://github.com/flammie/apertium-fin-deu">
                apertium-fin-deu
              </a>
            </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="alphabet">
    <p>Apertium will use following letters as alphabets in its tokenisation:</p>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="sdefs">
    <table>
      <thead>
        <tr>
          <th>Symbol</th>
          <th>Comment</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="sdef">
    <tr>
      <td><pre>&lt;<xsl:value-of select="@n"/>&gt;</pre></td>
      <td><xsl:value-of select="@c"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="section">
    <h3><xsl:value-of select="@type"/></h3>
    <table>
      <thead>
        <th><xsl:value-of select="$from"/></th>
        <th><xsl:value-of select="$to"/></th>
        <th>Comments</th>
      </thead>
      <tbody>
        <xsl:choose>
          <xsl:when test="$invert='true'">
            <xsl:apply-templates select="e">
            <xsl:sort select="p[1]/r[1]" data-type="text"/>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="e">
            <xsl:sort select="p[1]/l[1]" data-type="text"/>
            </xsl:apply-templates>
          </xsl:otherwise>
        </xsl:choose>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="e">
    <tr>
      <xsl:apply-templates/>
      <td>
        <em><xsl:value-of select="@r"/></em>&#x0020;
        <xsl:value-of select="@c"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="$invert='true'">
        <td><xsl:apply-templates select="r"/></td>
        <td><xsl:apply-templates select="l"/></td>
      </xsl:when>
      <xsl:otherwise>
        <td><xsl:apply-templates select="l"/></td>
        <td><xsl:apply-templates select="r"/></td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="i">
    <td colspan="2"><xsl:apply-templates/></td>
  </xsl:template>

  <xsl:template match="s">
    (<xsl:value-of select="@n"/>)
  </xsl:template>

  <xsl:template match="b">
    &#160;
  </xsl:template>

  <xsl:template match="j">
    <strong style="color: red">+++</strong>
  </xsl:template>

  <xsl:template match="re">
    <!-- XXX: this would generate before td
         Reg.Ex: <xsl:apply-templates/> 
         -->
  </xsl:template>

 
</xsl:stylesheet>
