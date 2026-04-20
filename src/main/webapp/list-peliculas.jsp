<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ include file="includes/header.jsp" %>

<h1>Películas</h1>

<div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/peliculas?action=new" class="btn btn-primary">+ Nueva película</a>

    <form action="<%= request.getContextPath() %>/peliculas" method="get" style="display:flex; gap:10px;">
        <input type="hidden" name="action" value="search">
        <input type="text" name="titulo" placeholder="Título" value="<%= request.getAttribute("titulo") != null ? request.getAttribute("titulo") : "" %>">
        <input type="text" name="genero" placeholder="Género" value="<%= request.getAttribute("genero") != null ? request.getAttribute("genero") : "" %>">
        <button type="submit" class="btn btn-secondary">Buscar</button>
    </form>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Título</th>
        <th>Género</th>
        <th>Año</th>
        <th>Director</th>
        <th>Disponible</th>
        <th>Acciones</th>
    </tr>
    <%
        List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
        if (peliculas != null) {
            for (Pelicula p : peliculas) {
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getTitulo() %></td>
        <td><%= p.getGenero() %></td>
        <td><%= p.getAnyo() %></td>
        <td><%= p.getDirector() %></td>
        <td><%= p.isDisponible() ? "Sí" : "No" %></td>
        <td>
            <a href="<%= request.getContextPath() %>/peliculas?action=view&id=<%= p.getId() %>" class="btn btn-secondary">Ver</a>
            <a href="<%= request.getContextPath() %>/peliculas?action=edit&id=<%= p.getId() %>" class="btn btn-primary">Editar</a>
            <a href="<%= request.getContextPath() %>/peliculas?action=delete&id=<%= p.getId() %>" class="btn btn-danger"
               onclick="return confirm('¿Dar de baja esta película?')">Baja</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<%@ include file="includes/footer.jsp" %>