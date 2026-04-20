<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.videoclub.domain.Alquiler" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<%
    List<Alquiler> alquileres = (List<Alquiler>) request.getAttribute("alquileres");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
%>

<h1>Alquileres</h1>

<div style="margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/alquileres?action=new" class="btn btn-primary">+ Nuevo alquiler</a>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Película</th>
        <th>Cliente</th>
        <th>Fecha inicio</th>
        <th>Fecha devolución</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>
    <%
        if (alquileres != null) {
            for (Alquiler a : alquileres) {
                String tituloPelicula = "";
                String nombreCliente = "";

                for (Pelicula p : peliculas) {
                    if (p.getId() == a.getIdPelicula()) {
                        tituloPelicula = p.getTitulo();
                        break;
                    }
                }
                for (Cliente c : clientes) {
                    if (c.getId() == a.getIdCliente()) {
                        nombreCliente = c.getNombre() + " " + c.getApellidos();
                        break;
                    }
                }
    %>
    <tr>
        <td><%= a.getId() %></td>
        <td><%= tituloPelicula %></td>
        <td><%= nombreCliente %></td>
        <td><%= a.getFechaInicio() %></td>
        <td><%= a.getFechaDevolucion() != null ? a.getFechaDevolucion() : "-" %></td>
        <td><%= a.getEstado() %></td>
        <td>
            <% if ("activo".equals(a.getEstado())) { %>
            <a href="<%= request.getContextPath() %>/alquileres?action=devolver&id=<%= a.getId() %>"
               class="btn btn-secondary"
               onclick="return confirm('¿Marcar como devuelto?')">Devolver</a>
            <% } %>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<%@ include file="includes/footer.jsp" %>