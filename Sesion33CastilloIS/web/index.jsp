<%-- 
    Document   : index
    Created on : 16/01/2026, 02:40:28 AM
    Author     : NADIA
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Gráfica desde XML en JSP CASTILLO</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 20px; }
    .card { width: 720px; margin: 0 auto; padding: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-radius: 8px; }
    canvas { max-width: 100%; }
  </style>
  <!-- Chart.js CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
  <div class="card">
    <h2>Ventas mensuales CASTILLO</h2>

    <%-- Importa el XML y lo parsea --%>
    <c:import url="/WEB-INF/sales.xml" var="xmlData"/>
    <x:parse var="doc">${xmlData}</x:parse>

    <%-- Canvas para Chart.js --%>
    <canvas id="myChart" width="700" height="350"></canvas>

    <script>
      // Construimos las etiquetas (labels) y los datos leyendo el documento XML parseado
      var labels = [
        <x:forEach select="$doc/sales/month" var="m" varStatus="s">
          "<x:out select="$m/name"/>"<c:if test="${!s.last}">,</c:if>
        </x:forEach>
      ];

      var dataValues = [
        <x:forEach select="$doc/sales/month" var="m" varStatus="s">
          <x:out select="$m/value"/><c:if test="${!s.last}">,</c:if>
        </x:forEach>
      ];

      // Configuración de Chart.js
      const config = {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [{
            label: 'Ventas',
            data: dataValues,
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                stepSize: 20
              },
              title: {
                display: true,
                text: 'Unidades'
              }
            }
          },
          plugins: {
            legend: { display: true, position: 'top' },
            title: { display: false }
          }
        }
      };

      // Renderizamos la gráfica
      window.addEventListener('load', function(){
        const ctx = document.getElementById('myChart').getContext('2d');
        new Chart(ctx, config);
      });
    </script>
  </div>
</body>
</html>