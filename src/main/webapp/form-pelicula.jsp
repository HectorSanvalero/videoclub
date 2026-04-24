<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ include file="includes/header.jsp" %>

<%
    Pelicula pelicula = (Pelicula) request.getAttribute("pelicula");
    boolean esEdicion = pelicula != null;
%>

<h1><%= esEdicion ? "Editar película" : "Nueva película" %></h1>

<div class="card">
    <form action="<%= request.getContextPath() %>/peliculas" method="post" enctype="multipart/form-data">
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
            <input type="number" name="anyo" min="1888" max="2099"
                   onkeydown="return event.keyCode !== 69 && event.keyCode !== 187 && event.keyCode !== 189"
                   value="<%= esEdicion ? pelicula.getAnyo() : "" %>">
        </div>

        <div class="form-group">
            <label>Director</label>
            <input type="text" name="director"
                   pattern="[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+"
                   title="Solo letras y espacios"
                   value="<%= esEdicion ? pelicula.getDirector() : "" %>">
        </div>

        <div class="form-group">
            <label>Imagen</label>
            <input type="file" name="imagen" accept="image/*">
            <% if (esEdicion && pelicula.getImagen() != null && !pelicula.getImagen().isEmpty()) { %>
            <p style="color:#aaa; font-size:0.85rem;">Imagen actual: <%= pelicula.getImagen() %></p>
            <% } %>
        </div>

        <div class="form-group">
            <label>Stock (unidades disponibles)</label>
            <input type="number" name="stock" min="0" required
                   value="<%= esEdicion ? pelicula.getStock() : "1" %>">
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