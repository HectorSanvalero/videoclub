<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<% if (request.getAttribute("error") != null) { %>
<p class="error"><%= request.getAttribute("error") %></p>
<% } %>

<h1>Clientes</h1>

<div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/clientes?action=new" class="btn btn-primary">+ Nuevo cliente</a>

    <form action="<%= request.getContextPath() %>/clientes" method="get" style="display:flex; gap:10px;">
        <input type="hidden" name="action" value="search">
        <input type="text" name="nombre" placeholder="Nombre"
               value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>">
        <input type="text" name="apellidos" placeholder="Apellidos"
               value="<%= request.getAttribute("apellidos") != null ? request.getAttribute("apellidos") : "" %>">
        <button type="submit" class="btn btn-secondary">Buscar</button>
        <a href="<%= request.getContextPath() %>/clientes" class="btn btn-danger">Limpiar</a>
    </form>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Email</th>
        <th>Teléfono</th>
        <th>Activo</th>
        <th>Acciones</th>
    </tr>
    <%
        List<Cliente> clientes = (List<Cliente>) request.getAttribute("clientes");
        if (clientes != null) {
            for (Cliente c : clientes) {
    %>
    <tr>
        <td><%= c.getId() %></td>
        <td><%= c.getNombre() %></td>
        <td><%= c.getApellidos() %></td>
        <td><%= c.getEmail() %></td>
        <td><%= c.getTelefono() %></td>
        <td><%= c.isActivo() ? "Sí" : "No" %></td>
        <td>
            <a href="<%= request.getContextPath() %>/clientes?action=view&id=<%= c.getId() %>" class="btn btn-secondary">Ver</a>
            <a href="<%= request.getContextPath() %>/clientes?action=edit&id=<%= c.getId() %>" class="btn btn-primary">Editar</a>
            <% if (c.isActivo()) { %>
            <a href="<%= request.getContextPath() %>/clientes?action=delete&id=<%= c.getId() %>" class="btn btn-danger"
               onclick="return confirm('¿Dar de baja este cliente?')">Baja</a>
            <% } else { %>
            <a href="<%= request.getContextPath() %>/clientes?action=alta&id=<%= c.getId() %>" class="btn btn-primary"
               onclick="return confirm('¿Dar de alta este cliente?')">Alta</a>
            <% } %>
            <a href="<%= request.getContextPath() %>/clientes?action=eliminar&id=<%= c.getId() %>" class="btn btn-danger"
               onclick="return confirm('¿Estás seguro de que deseas eliminar este cliente?')">Eliminar</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<%@ include file="includes/footer.jsp" %>