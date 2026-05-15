<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Ej 2.1</title>
      </head>

      <body>            
        <!-- a.a) Encabezado principal -->             
        <h1>
          <xsl:value-of select="/empresa/@nombre"/> — <xsl:value-of select="/empresa/@pais"/>
        </h1>

        
        <xsl:for-each select="/empresa/departamento">
          <!-- a.b) Una sección <h2> para departamento -->
          <h2>
            <xsl:value-of select="@nombre"/> (Código: <xsl:value-of select="@codigo"/>) — Responsable: <xsl:value-of select="@responsable"/>
          </h2>

          <!-- a.c) tabla con columnas  -->
          <table>
            <tr>
              <th>ID</th>
              <th>Nombre</th>
              <th>Puesto</th>
              <th>Tipo</th>
              <th>Edad</th>
              <th>Salario</th>
            </tr>

            <!-- b.a) Empleados deben estar ordenados por salario descendente -->
            <xsl:for-each select="empleado">
              <xsl:sort select="salario" order="descending"/>
              <tr>
                <!-- b.b) si es temporal, aplicamos estilo de fondo gris -->
                <xsl:if test="@tipo='Temporal'">
                  <xsl:attribute name="style">background:#ddd;</xsl:attribute>
                </xsl:if>

                <td><xsl:value-of select="@id"/></td>
                <td><xsl:value-of select="nombre"/></td>
                <td><xsl:value-of select="@puesto"/></td>
                <td><xsl:value-of select="@tipo"/></td>
                <td><xsl:value-of select="edad"/></td>

                <!-- b.c) salario en negrita si > 3000 -->
                <td>
                  <xsl:if test="salario &gt; 3000">
                      <b><xsl:value-of select="salario"/></b>
                  </xsl:if>
                  <xsl:if test="salario &lt;= 3000">
                      <xsl:value-of select="salario"/>
                  </xsl:if>
                </td>
              </tr>
            </xsl:for-each>

            <!-- c.a) fila con salario promedio por departamento -->
            <tr>
              <td colspan="5">Salario promedio</td>
              <td> 
                  <p><xsl:value-of select="sum(empleado/salario) div count(empleado)"/></p>
              </td>
            </tr>
          </table>
        </xsl:for-each>

        <!-- c.b) Total de empleados en toda la empresa -->
        <p>Total empleados: <xsl:value-of select="count(/empresa/departamento/empleado)"/></p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
