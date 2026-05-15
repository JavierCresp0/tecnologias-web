<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Template de empresa -->
  <xsl:template match="/">
    <xsl:apply-templates select="/empresa"/>
  </xsl:template>

  <!-- Template de empresa -->
  <xsl:template match="empresa">
    <html>
      <head>
        <title>Ej 2.3 - 2.1</title>
      </head>
      <body>
        <h1>
          <xsl:value-of select="@nombre"/> — <xsl:value-of select="@pais"/>
        </h1>

        <xsl:apply-templates select="departamento"/>

        <p>Total empleados: <xsl:value-of select="count(departamento/empleado)"/></p>
      </body>
    </html>
  </xsl:template>

  <!-- Template de departamento -->
  <xsl:template match="departamento">
    <h2>
      <xsl:value-of select="@nombre"/> (Código: <xsl:value-of select="@codigo"/>) — Responsable: <xsl:value-of select="@responsable"/>
    </h2>

    <table>
      <tr>
        <th>ID</th><th>Nombre</th><th>Puesto</th><th>Tipo</th><th>Edad</th><th>Salario</th>
      </tr>

      <xsl:apply-templates select="empleado">
        <xsl:sort select="salario" order="descending"/>
      </xsl:apply-templates>

      <!-- fila con salario promedio -->
      <tr>
        <td colspan="5">Salario promedio</td>
        <td> 
          <p><xsl:value-of select="sum(empleado/salario) div count(empleado)"/></p>
        </td>
      </tr>
    </table>
  </xsl:template>

  <!-- Template de empleado -->
  <xsl:template match="empleado">
    
    <tr>
      <xsl:if test="@tipo='Temporal'">
        <xsl:attribute name="style">background:#ddd;</xsl:attribute>
      </xsl:if>

      <td><xsl:value-of select="@id"/></td>
      <td><xsl:value-of select="nombre"/></td>
      <td><xsl:value-of select="@puesto"/></td>
      <td><xsl:value-of select="@tipo"/></td>
      <td><xsl:value-of select="edad"/></td>
      <td>
          <xsl:if test="salario &gt; 3000">
            <b><xsl:value-of select="salario"/></b>
          </xsl:if>
          <xsl:if test="salario &lt;= 3000">
            <xsl:value-of select="salario"/>
          </xsl:if>
      </td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
