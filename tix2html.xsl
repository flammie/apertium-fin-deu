<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="5.0"/>
  <xsl:strip-space elements="let var clip
    lit lit-tag
    call-macro with-param
    output
    choose when otherwise
    test equal
    chunk tags tag
    concat
    lu b"/>

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
              <h4>
                <a class="brand" href="/apertium-fin-deu/">apertium-fin-deu</a>
                <small>Finnish–German transfer for rule-based
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
    <pre><code>
      <xsl:apply-templates/>
    </code></pre>
  </xsl:template>

  <xsl:template match="let"
    >let <xsl:apply-templates select="*[1]"/> ≔ <xsl:apply-templates
      select="*[2]"/>;
  </xsl:template>

  <xsl:template match="var"
    >$<em><xsl:value-of select="@n"/></em><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="concat"
    ><xsl:apply-templates/></xsl:template>

  <xsl:template match="lit"
    >"<xsl:value-of select="@v"/>"</xsl:template>

  <xsl:template match="lit-tag"
    >&lt;<xsl:value-of select="@v"/>&gt;</xsl:template>

  <xsl:template match="choose">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="when[1]">
    if <xsl:apply-templates select="test"/> then:
       <xsl:apply-templates select="let"/>
  </xsl:template>
  <xsl:template match="when[position()>1]">
    elseif <xsl:apply-templates select="test"/> then:
       <xsl:apply-templates select="let"/>
  </xsl:template>

  <xsl:template match="otherwise">
    else:
       <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="test"
    >(<xsl:apply-templates/>)</xsl:template>

  <xsl:template match="equal">
    <xsl:apply-templates select="clip|var"/> ≟ <xsl:apply-templates 
      select="lit|lit-tag"/>
  </xsl:template>

  <xsl:template match="clip"
    ><em><xsl:value-of select="@side"/>[<xsl:value-of
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
    <div>Matching pattern:</div>
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="pattern-item">
    <li><xsl:value-of select="@n"/></li>
  </xsl:template>

  <xsl:template match="action">
    <div>Action:</div>
    <pre><code>
        <xsl:apply-templates/>
    </code></pre>
  </xsl:template>

  <xsl:template match="call-macro">
    <xsl:value-of select="@n"/>(<xsl:apply-templates/>)
  </xsl:template>

  <xsl:template match="with-param"
    >$<xsl:value-of select="@pos"/>
  </xsl:template>

  <xsl:template match="out">
    Output: <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="chunk">
    [<xsl:apply-templates select="b|lu"/>]<sub><xsl:value-of 
        select="@name"/><xsl:apply-templates select="tags"/></sub>
  </xsl:template>

  <xsl:template match="tags"
    ><xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tag"
    >&lt;<xsl:apply-templates/>&gt;
  </xsl:template>

  <xsl:template match="lu">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="b">
    <sub>b<xsl:value-of select="@pos"/></sub><br/>
  </xsl:template>

</xsl:stylesheet>
