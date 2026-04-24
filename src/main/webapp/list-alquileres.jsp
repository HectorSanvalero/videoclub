<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.svalero.videoclub.domain.Alquiler" %>
<%@ page import="com.svalero.videoclub.domain.Pelicula" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<% if (request.getAttribute("error") != null) { %>
<p class="error"><%= request.getAttribute("error") %></p>
<% } %>

<%
    List<Alquiler> alquileres = (List<Alquiler>) request.getAttribute("alquileres");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
    LocalDate hoy = LocalDate.now();
%>

<h1>Alquileres</h1>

<div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/alquileres?action=new" class="btn btn-primary">+ Nuevo alquiler</a>

    <form action="<%= request.getContextPath() %>/alquileres" method="get" style="display:flex; gap:10px;">
        <input type="hidden" name="action" value="search">
        <select name="estado">
            <option value="">Todos los estados</option>
            <option value="activo" <%= "activo".equals(request.getAttribute("estado")) ? "selected" : "" %>>Activo</option>
            <option value="devuelto" <%= "devuelto".equals(request.getAttribute("estado")) ? "selected" : "" %>>Devuelto</option>
        </select>
        <input type="date" name="fechaInicio"
               value="<%= request.getAttribute("fechaInicio") != null ? request.getAttribute("fechaInicio") : "" %>">
        <button type="submit" class="btn btn-secondary">Buscar</button>
        <a href="<%= request.getContextPath() %>/alquileres" class="btn btn-danger">Limpiar</a>
    </form>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Película</th>
        <th>Cliente</th>
        <th>Fecha inicio</th>
        <th>Fecha devolución</th>
        <th>Estado</th>
        <th>Precio</th>
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

                boolean retrasado = "activo".equals(a.getEstado())
                        && a.getFechaDevolucion() != null
                        && a.getFechaDevolucion().isBefore(hoy);
    %>
    <tr style="<%= retrasado ? "background-color:#3a0a0a;" : "" %>">
        <td><%= a.getId() %></td>
        <td><%= tituloPelicula %></td>
        <td><%= nombreCliente %></td>
        <td><%= a.getFechaInicio() %></td>
        <td>
            <%= a.getFechaDevolucion() != null ? a.getFechaDevolucion() : "-" %>
            <% if (retrasado) { %>
            <span style="color:#e94560; font-weight:bold;">⚠ RETRASO</span>
            <% } %>
        </td>
        <td><%= a.getEstado() %></td>
        <td><%= a.getPrecio() %> €</td>
        <td>
            <% if ("activo".equals(a.getEstado())) { %>
            <a href="<%= request.getContextPath() %>/alquileres?action=devolver&id=<%= a.getId() %>"
               class="btn btn-secondary"
               onclick="return confirm('¿Marcar como devuelto?')">Devolver</a>
            <% } %>
            <a href="<%= request.getContextPath() %>/alquileres?action=eliminar&id=<%= a.getId() %>"
               class="btn btn-danger"
               onclick="return confirm('¿Estás seguro de que deseas eliminar este alquiler?')">Eliminar</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<%@ include file="includes/footer.jsp" %>