<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ include file="includes/header.jsp" %>

<%
    Pelicula pelicula = (Pelicula) request.getAttribute("pelicula");
%>

<h1>Detalle de película</h1>

<div class="card">
    <% if (pelicula.getImagen() != null && !pelicula.getImagen().isEmpty()) { %>
    <img src="<%= request.getContextPath() %>/icons/<%= pelicula.getImagen() %>"
         alt="<%= pelicula.getTitulo() %>"
         style="max-width:200px; margin-bottom:20px;">
    <% } %>

    <p><strong>Título:</strong> <%= pelicula.getTitulo() %></p>
    <p><strong>Género:</strong> <%= pelicula.getGenero() %></p>
    <p><strong>Año:</strong> <%= pelicula.getAnyo() %></p>
    <p><strong>Director:</strong> <%= pelicula.getDirector() %></p>
    <p><strong>Disponible:</strong> <%= pelicula.isDisponible() ? "Sí" : "No" %></p>

    <div style="margin-top:20px;">
        <a href="<%= request.getContextPath() %>/peliculas?action=edit&id=<%= pelicula.getId() %>" class="btn btn-primary">Editar</a>
        <a href="<%= request.getContextPath() %>/peliculas" class="btn btn-secondary">Volver</a>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>