<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ include file="includes/header.jsp" %>

<%
    Pelicula pelicula = (Pelicula) request.getAttribute("pelicula");
    boolean esEdicion = pelicula != null;
%>

<h1><%= esEdicion ? "Editar película" : "Nueva película" %></h1>

<div class="card">
    <form action="<%= request.getContextPath() %>/peliculas" method="post">
        <input type="hidden" name="action" value="<%= esEdicion ? "edit" : "new" %>">
        <% if (esEdicion) { %>
        <input type="hidden" name="id" value="<%= pelicula.getId() %>">
        <% } %>

        <div class="form-group">
            <label>Título</label>
            <input type="text" name="titulo" required
                   value="<%= esEdicion ? pelicula.getTitulo() : "" %>">
        </div>

        <div class="form-group">
            <label>Género</label>
            <input type="text" name="genero"
                   value="<%= esEdicion ? pelicula.getGenero() : "" %>">
        </div>

        <div class="form-group">
            <label>Año</label>
            <input type="number" name="anyo"
                   value="<%= esEdicion ? pelicula.getAnyo() : "" %>">
        </div>

        <div class="form-group">
            <label>Director</label>
            <input type="text" name="director"
                   value="<%= esEdicion ? pelicula.getDirector() : "" %>">
        </div>

        <div class="form-group">
            <label>Imagen (nombre del archivo)</label>
            <input type="text" name="imagen"
                   value="<%= esEdicion && pelicula.getImagen() != null ? pelicula.getImagen() : "" %>">
        </div>

        <div style="display:flex; gap:10px;">
            <button type="submit" class="btn btn-primary">
                <%= esEdicion ? "Guardar cambios" : "Crear película" %>
            </button>
            <a href="<%= request.getContextPath() %>/peliculas" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>