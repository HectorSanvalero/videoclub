<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<h1>Clientes</h1>

<div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/clientes?action=new" class="btn btn-primary">+ Nuevo cliente</a>

    <form action="<%= request.getContextPath() %>/clientes" method="get" style="display:flex; gap:10px;">
        <input type="hidden" name="action" value="search">
        <input type="text" name="nombre" placeholder="Nombre" value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>">
        <input type="text" name="apellidos" placeholder="Apellidos" value="<%= request.getAttribute("apellidos") != null ? request.getAttribute("apellidos") : "" %>">
        <button type="submit" class="btn btn-secondary">Buscar</button>
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
            <a href="<%= request.getContextPath() %>/clientes?action=delete&id=<%= c.getId() %>" class="btn btn-danger"
               onclick="return confirm('¿Dar de baja este cliente?')">Baja</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<%@ include file="includes/footer.jsp" %>