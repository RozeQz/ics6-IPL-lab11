<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<TABLE class="table table-striped">
    <TR>
        <TH scope="col">#</TH>
        <TH scope="col">Число</TH>
        <TH scope="col">Квадрат числа</TH>
    </TR>
    <xsl:for-each select="output/palindromes/palindrome">
    <TR>
        <TD scope="row"><xsl:value-of select="@i"/></TD>
        <TD scope="row"><xsl:value-of select="number"/></TD>
        <TD scope="row"><xsl:value-of select="square"/></TD>
    </TR>
    </xsl:for-each>
</TABLE><BR/>

</xsl:template>
</xsl:stylesheet>