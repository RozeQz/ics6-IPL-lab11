<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<p>Ответ: <xsl:value-of select="output/result"/></p>
<table class="table table-striped">
    <tr>
        <th scope="col">#</th>
        <th scope="col">Число</th>
        <th scope="col">Квадрат числа</th>
    </tr>
    <xsl:for-each select="output/palindromes/palindrome">
    <tr>
        <td scope="row"><xsl:value-of select="@i"/></td>
        <td scope="row"><xsl:value-of select="number"/></td>
        <td scope="row"><xsl:value-of select="square"/></td>
    </tr>
    </xsl:for-each>
</table><br/>

</xsl:template>
</xsl:stylesheet>