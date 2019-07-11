Projekt zaliczeniowy z Technologi XML 

Wykorzystane Technologie XQUERY 

1. Celem uruchomienia projektu:
-nale¿y stworzyæ now¹ aplikacjê w existdb 
http://<host>:<port>/exist/apps/doc/development-starter.xml
-nastêpnie dodaæ do kolekcji nastêpuj¹ce pliki: 
	> hello.xql - raport pdf XSL FO
 	> hello2.xql - - raport pdf XSL FO
	> index.html  - g³ówny plik
- w modules: 
	> w pliku app.xql podmieniæ zawartoœæ

Dorzuciæ dane.xml do modules i do folderu g³ównego

W hello2.xql i hello.xql istotne: 

let $insert2 := "//JED_ADM[NAZWA='" || $value || "']" - konkatenacja stringa- zamiast + jest ||
Na samym pocz¹tku sprawdzane s¹ parametry w linku, celem przypisania i wykorzystania parametru w œcie¿ce for-each linia 55

Zapis do pdf: 
gdzie: let $drama := doc("modules/dane.xml") - wskazanie pliku do transformacji
       let $test := - wskazanie sposobu transformacji

let $tablefo := transform:transform($drama,$test,())
let $pdf := xslfo:render($tablefo, "application/pdf", (), ())
return response:stream-binary($pdf, "application/pdf", "output.pdf")

<fo:root> - plik root, zawsze wystêpuje w pliku
    <fo:layout-master-set>
             <fo:simple-page-master master-name="wzorzec1" page-width="210mm" page-height="297mm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">
                         <fo:region-body margin="3cm"/>
                         </fo:simple-page-master>
             </fo:layout-master-set> - ustawienia strony raportu
             <fo:page-sequence master-reference="wzorzec1">
                     <fo:flow flow-name="xsl-region-body" font-family="Arial">
                        <fo:block font-size="20" text-align="center">Raport</fo:block>
                     <xsl:apply-templates select="//POLSKA"/>  - istotna kwestia apply templates, pozwala zaaplikowaæ schemat 
                     </fo:flow>
             </fo:page-sequence>
</fo:root>

W app.xql:
function app:showTESTGraph() - generacja grafu (SVG)

edit2.xhtml - XFORMS umo¿liwia edycjê danych pliku xml

