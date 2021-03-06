<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY nbsp "&#160;">
    ]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>


  <xsl:include href="common/accesslevel_parameters.xsl"/>
  <xsl:include href="common/button.xsl"/>
  <xsl:include href="common/displaysystempath.xsl"/>
  <xsl:include href="common/convert_filesize.xsl"/>
  <xsl:include href="common/waitsplash.xsl"/>

  <xsl:param name="page"/>
  <xsl:param name="mode"/>
  <xsl:param name="selectedtabpage"/>
  <xsl:param name="selectedoperation"/>
  <xsl:param name="selectedcachename"/>

  <xsl:template match="/">
    <html>
      <head>
        <xsl:call-template name="waitsplash"/>
        <script type="text/javascript" src="javascript/admin.js"/>
        <script type="text/javascript" src="javascript/tabpane.js"/>
        <link type="text/css" rel="StyleSheet" href="javascript/tab.webfx.css"/>
        <link type="text/css" rel="stylesheet" href="css/admin.css"/>
      </head>
      <body>
        <h1>
          <xsl:call-template name="displaysystempath">
            <xsl:with-param name="nolinks" select="true()"/>
            <xsl:with-param name="page" select="'10'"/>
            <xsl:with-param name="mode" select="$mode"/>
          </xsl:call-template>
        </h1>

        <xsl:if test="$mode = 'system'">
          <table cellspacing="0" cellpadding="0" border="0">
            <tr>
              <td>
                <xsl:call-template name="button">
                  <xsl:with-param name="type" select="'link'"/>
                  <xsl:with-param name="caption" select="'%cmdCleanReadLogs%'"/>
                  <xsl:with-param name="href" select="'adminpage?page=10&amp;op=cleanReadLogs'"/>
                  <xsl:with-param name="condition">
                    <xsl:text>confirm('%alertCleanReadLogs%')</xsl:text>
                  </xsl:with-param>
                </xsl:call-template>
                <xsl:text>&#160;</xsl:text>
                <xsl:call-template name="button">
                  <xsl:with-param name="type" select="'link'"/>
                  <xsl:with-param name="caption" select="'%cmdRemoveDeletedContentFromDatabase%'"/>
                  <xsl:with-param name="href" select="'adminpage?page=10&amp;op=cleanUnusedContent'"/>
                  <xsl:with-param name="condition">
                    <xsl:text>confirm('%alertCleanUnusedContent%')</xsl:text>
                  </xsl:with-param>
                </xsl:call-template>
                <xsl:text>&#160;</xsl:text>
                <xsl:text>&#160;</xsl:text>
              </td>
            </tr>
            <tr>
              <td class="browse_buttonrow_datarows_seperator">
                <img src="images/1x1.gif"/>
              </td>
            </tr>
          </table>
        </xsl:if>

        <div class="tab-pane" id="tab-pane-1">

          <script type="text/javascript" language="JavaScript">
            var tabPane1 = new WebFXTabPane( document.getElementById( "tab-pane-1" ), true);
          </script>

          <xsl:choose>
            <xsl:when test="$mode = 'system'">
              <xsl:call-template name="system-panel"/>
            </xsl:when>
            <xsl:when test="$mode = 'java_properties'">
              <xsl:call-template name="java-properties-panel"/>
            </xsl:when>
          </xsl:choose>
        </div>

        <script type="text/javascript" language="JavaScript">
          setupAllTabs();
        </script>

      </body>
    </html>
  </xsl:template>

  <xsl:template name="system-panel">
    <div class="tab-page" id="tab-page-1">
      <span class="tab">%system%</span>

      <script type="text/javascript" language="JavaScript">
        tabPane1.addTabPage( document.getElementById( "tab-page-1" ) );
      </script>

      <fieldset>
        <legend>&nbsp;%blockUptime%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td class="form_labelcolumn" colspan="2">
              <xsl:value-of select="/vertical/@upTime"/> ( since
              <xsl:value-of select="/vertical/@bootTime"/> )
            </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>&nbsp;%blockCms%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td class="form_labelcolumn">
              %fldVersion%:
            </td>
            <td>
              <xsl:value-of select="/vertical/@version"/>
            </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>&nbsp;%blockDatabaseProperties%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td class="form_labelcolumn">
              %modelVersion%:
            </td>
            <td>
              <xsl:value-of select="/vertical/@modelVersion"/>
            </td>
          </tr>
        </table>
      </fieldset>

      <fieldset>
        <legend>&nbsp;%componentVersions%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td nowrap="true">
              <b>%name%</b>
            </td>
            <td width="100%">
              <b>%version%</b>
            </td>
          </tr>
          <xsl:for-each select="/vertical/components/component">
            <tr>
              <td nowrap="true"><xsl:value-of select="@name"/>&nbsp;&nbsp;
              </td>
              <td>
                <xsl:value-of select="@version"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </fieldset>

      <fieldset>
        <legend>&nbsp;Java&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td nowrap="true">
              %version%:
            </td>
            <td width="100%">
              <xsl:value-of select="/vertical/java/@version"/>
            </td>
          </tr>
          <tr>
            <td nowrap="true" colspan="2">
              <b>Heap memory:</b>
            </td>
          </tr>
          <tr>
            <td nowrap="true">
              %maxMemory%:
            </td>
            <td width="100%">
              <xsl:call-template name="convert_filesize">
                <xsl:with-param name="fsize" select="/vertical/java/memory/heap/@max"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td nowrap="true">
              %usedMemory%:
            </td>
            <td width="100%">
              <xsl:call-template name="convert_filesize">
                <xsl:with-param name="fsize" select="/vertical/java/memory/heap/@used"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td nowrap="true" colspan="2">
              <b>Non-heap memory:</b>
            </td>
          </tr>
          <tr>
            <td nowrap="true">
              %maxMemory%:
            </td>
            <td width="100%">
              <xsl:call-template name="convert_filesize">
                <xsl:with-param name="fsize" select="/vertical/java/memory/nonheap/@max"/>
              </xsl:call-template>
            </td>
          </tr>
          <tr>
            <td nowrap="true">
              %usedMemory%:
            </td>
            <td width="100%">
              <xsl:call-template name="convert_filesize">
                <xsl:with-param name="fsize" select="/vertical/java/memory/nonheap/@used"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </fieldset>

    </div>
  </xsl:template>

  <xsl:template name="java-properties-panel">


    <div class="tab-page" id="tab-page-2">
      <span class="tab">%datasourceProperties%</span>

      <script type="text/javascript" language="JavaScript">
        tabPane1.addTabPage( document.getElementById( "tab-page-2" ) );
      </script>

      <fieldset>
        <legend>&nbsp;%datasourceProperties%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td nowrap="true">
              <b>%name%</b>
            </td>
            <td width="100%">
              <b>%value%</b>
            </td>
          </tr>
          <xsl:for-each select="/vertical/model/datasourceProperties/datasourceProperty">
            <xsl:sort select="@name"/>
            <tr>
              <td nowrap="true"><xsl:value-of select="@name"/>&nbsp;&nbsp;
              </td>
              <td>
                <xsl:value-of select="@value"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </fieldset>
    </div>


    <div class="tab-page" id="tab-page-3">
      <span class="tab">%systemProperties%</span>

      <script type="text/javascript" language="JavaScript">
        tabPane1.addTabPage( document.getElementById( "tab-page-3" ) );
      </script>

      <fieldset>
        <legend>&nbsp;%systemProperties%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td nowrap="true">
              <b>%name%</b>
            </td>
            <td width="100%">
              <b>%value%</b>
            </td>
          </tr>
          <xsl:for-each select="/vertical/model/systemProperties/systemProperty">
            <xsl:sort select="@name"/>
            <tr>
              <td nowrap="true"><xsl:value-of select="@name"/>&nbsp;&nbsp;
              </td>
              <td>
                <xsl:value-of select="@value"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </fieldset>
    </div>

    <div class="tab-page" id="tab-page-4">
      <span class="tab">%configurationProperties%</span>

      <script type="text/javascript" language="JavaScript">
        tabPane1.addTabPage( document.getElementById( "tab-page-4" ) );
      </script>

      <fieldset>
        <legend>&nbsp;%configurationProperties%&nbsp;</legend>
        <table class="formtable">
          <tr>
            <td nowrap="true">
              <b>%name%</b>
            </td>
            <td width="100%">
              <b>%value%</b>
            </td>
          </tr>
          <xsl:for-each select="/vertical/model/configurationProperties/configurationProperty">
            <xsl:sort select="@name"/>
            <tr>
              <td nowrap="true"><xsl:value-of select="@name"/>&nbsp;&nbsp;
              </td>
              <td>
                <xsl:value-of select="@value"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </fieldset>
    </div>

  </xsl:template>

</xsl:stylesheet>
