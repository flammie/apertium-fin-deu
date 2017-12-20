<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="5.0"/>

  <xsl:param name="from"/>
  <xsl:param name="to"/>
  <xsl:param name="pair"/>
  <xsl:param name="version"/>
  <xsl:param name="invert"/>

  <xsl:template match="transfer|interchunk|postchunk">
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
              <h1 id="dictionary">Transfer visualisation:
                Apertium-fin-deu–Finnish–German dictionary and RBMT resources
              </h1>
              <p style="font-variant: italic">
                This is a visualisation of an apertium transfer system
              </p>
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

  <xsl:template match="section-def-cats">
    <h2>Categories (parts of chunks)</h2>
    <p>
      These are the categories Apertium is using in order to chunk, re-order
      and transfer lexemes.
    </p>
    <table>
      <thead>
        <tr>
          <th>Category</th>
          <th>Items</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="def-cat">
    <tr>
      <td><xsl:value-of select="@n"/></td>
      <td><ul><xsl:apply-templates/></ul></td>
    </tr>
  </xsl:template>

  <xsl:template match="cat-item">
    <li>
      <xsl:value-of select="@lemma"/>
      <code>&lt;<xsl:value-of select="@tags"/>&gt;</code>
    </li>
  </xsl:template>

  <xsl:template match="section-def-attrs">
    <h2>Attributes</h2>
    <p>
      These are the morphological analysis value (tag) sets that can be
      processed in the transfer.
    </p>
    <table>
      <thead>
        <tr>
          <th>Attribute set name</th>
          <th>Tags</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="def-attr">
    <tr>
      <td><xsl:value-of select="@n"/></td>
      <td><ul><xsl:apply-templates/></ul></td>
    </tr>
  </xsl:template>

  <xsl:template match="attr-item">
    <li>
      <code>&lt;<xsl:value-of select="@tags"/>&gt;</code>
    </li>
  </xsl:template>

  <xsl:template match="section-def-macros">
    <h2>Macros</h2>
    <p>Macros are helper functions in apertium transfer files.</p>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="def-macro">
    <h3><xsl:value-of select="@n"/></h3>
    <div>Parametres: <xsl:value-of select="@npar"/></div>
    <code><ol>
      <xsl:apply-templates/>
    </ol></code>
  </xsl:template>

  <xsl:template match="let">
    <li>
      let <xsl:apply-templates select="*[1]"/> ≔ <xsl:apply-templates
        select="*[2]"/>
    </li>
  </xsl:template>

  <xsl:template match="var">
    $<em><xsl:value-of select="@n"/></em><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="concat">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="lit">
    "<xsl:value-of select="@v"/>"
  </xsl:template>

  <xsl:template match="lit-tag"
    >&lt;<xsl:value-of select="@v"/>&gt;</xsl:template>

  <xsl:template match="choose">
    <li><ol>
      <xsl:apply-templates/>
    </ol></li>
  </xsl:template>

  <xsl:template match="when[1]">
    <li>if <xsl:apply-templates select="test"/> then:<ol>
        <xsl:apply-templates select="let"/>
    </ol></li>
  </xsl:template>
  <xsl:template match="when[position()>1]">
    <li>elseif <xsl:apply-templates select="test"/> then:<ol>
        <xsl:apply-templates select="let"/>
    </ol></li>
  </xsl:template>

  <xsl:template match="otherwise">
    <li>else:<ol>
        <xsl:apply-templates/>
    </ol></li>
  </xsl:template>

  <xsl:template match="test">
    <li><ol>
        <xsl:apply-templates/>
    </ol></li>
  </xsl:template>

  <xsl:template match="equal">
    <li>
      <xsl:apply-templates select="clip|var"/> ≟ <xsl:apply-templates 
        select="lit|lit-tag"/>
    </li>
  </xsl:template>

  <xsl:template match="clip">
    <em><xsl:value-of select="@side"/>[<xsl:value-of
        select="@pos"/>]['<xsl:value-of select="@part"/>']</em>
  </xsl:template>

  <xsl:template match="section-rules">
    <h2>Rules</h2>
    <p>The actual rules concerning stuff.</p>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="rule">
    <h3><xsl:value-of select="@comment"/></h3>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="pattern">
    <h4>Matching pattern:</h4>
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <xsl:template match="pattern-item">
    <li><xsl:value-of select="@n"/></li>
  </xsl:template>

  <xsl:template match="action">
    <h4>Action:</h4>
    <code><ol>
      <xsl:apply-templates/>
    </ol></code>
  </xsl:template>

  <xsl:template match="call-macro">
    <li><xsl:value-of select="@n"/>(<xsl:apply-templates/>)</li>
  </xsl:template>

  <xsl:template match="with-param[1]"
    >$<xsl:value-of select="@pos"/>
  </xsl:template>

  <xsl:template match="with-param[position()>1]"
    >$<xsl:value-of select="@pos"/>
  </xsl:template>

  <xsl:template match="out">
    <li>Output: <ol>
        <xsl:apply-templates/>
    </ol></li>
  </xsl:template>

  <xsl:template match="chunk">
    <li>
      [<ol><xsl:apply-templates select="b|lu"/></ol>]<sub><xsl:value-of 
          select="@name"/><xsl:apply-templates select="tags"/></sub>
    </li>
  </xsl:template>

  <xsl:template match="tags">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tag">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="lu">
    <li><xsl:apply-templates/></li>
  </xsl:template>

  <xsl:template match="b">
    <li><sub>b<xsl:value-of select="@pos"/></sub><br/></li>
  </xsl:template>

</xsl:stylesheet>
