xquery version "3.0";
declare namespace xslfo="http://exist-db.org/xquery/xslfo";



(: echo a list of all the URL parameters  :)
let $parameters :=  request:get-parameter-names()
let $value := request:get-parameter($parameters, '')

let $drama := doc("modules/dane.xml")
let $xslfo := doc("hello.xsl")
let $insert2 := "//JED_ADM[@TYP='" || $value || "']"


let $test := <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
    <xsl:output method="xml" version="1.0" indent="yes"/>
    <xsl:template match="/">
    <fo:root>
    <fo:layout-master-set>
             <fo:simple-page-master master-name="wzorzec1" page-width="210mm" page-height="297mm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">
                         <fo:region-body margin="3cm"/>
                         </fo:simple-page-master>
             </fo:layout-master-set>
             <fo:page-sequence master-reference="wzorzec1">
                     <fo:flow flow-name="xsl-region-body" font-family="Arial">
                        <fo:block font-size="20" text-align="center">Raport</fo:block>
                     <xsl:apply-templates select="//POLSKA"/>
                     </fo:flow>
             </fo:page-sequence>
    </fo:root>
    </xsl:template>
<xsl:template match="POLSKA">
  <fo:table>
  <fo:table-header>
      <fo:table-row>
        <fo:table-cell>
          <fo:block font-weight="bold">Nazwa</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold">Typ</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold">Ludnosc</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold">Wys_MIN</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold">Wys_MAX</fo:block>
        </fo:table-cell>
      </fo:table-row>
</fo:table-header>
    <fo:table-body>
      <xsl:for-each select="{$insert2}">
        <fo:table-row>
          <fo:table-cell border-style="inset" border-width="2pt" padding="2pt" background-repeat="repeat" display-align="center">
                <fo:block>
                    <xsl:value-of select="NAZWA"/>
                </fo:block>
            </fo:table-cell>
              <fo:table-cell border-style="inset" border-width="2pt" padding="2pt" background-repeat="repeat" display-align="center">
                <fo:block>
                    <xsl:value-of select="@TYP"/>
                </fo:block>
            </fo:table-cell>
             <fo:table-cell border-style="inset" border-width="2pt" padding="2pt" background-repeat="repeat" display-align="center">
                <fo:block>
                    <xsl:value-of select="LUDNOSC"/>
                </fo:block>
            </fo:table-cell>
              <fo:table-cell border-style="inset" border-width="2pt" padding="2pt" background-repeat="repeat" display-align="center">
                <fo:block>
                    <xsl:value-of select="WYSOKOSC_MIN"/>
                </fo:block>
            </fo:table-cell>
              <fo:table-cell border-style="inset" border-width="2pt" padding="2pt" background-repeat="repeat" display-align="center">
                <fo:block>
                    <xsl:value-of select="WYSOKOSC_MAX"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
      </xsl:for-each>
    </fo:table-body>
  </fo:table>
</xsl:template>
</xsl:stylesheet>



let $tablefo := transform:transform($drama,$test,())
let $pdf := xslfo:render($tablefo, "application/pdf", (), ())
return response:stream-binary($pdf, "application/pdf", "output.pdf")

