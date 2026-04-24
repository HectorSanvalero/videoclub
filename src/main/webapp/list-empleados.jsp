<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.videoclub.domain.Empleado" %>
<%@ include file="includes/header.jsp" %>

<% if (request.getAttribute("error") != null) { %>
<p class="error"><%= request.getAttribute("error") %></p>
<% } %>

<h1>Empleados</h1>

<div style="margin-bottom:20px;">
    <a href="<%= request.getContextPath() %>/empleados?action=new" class="btn btn-primary">+ Nuevo empleado</a>
</div>

<table>
    <tr>
        <th>ID</th>
        <th>Nombre</th>
        <th>Apellidos</th>
        <th>Email</th>
        <th>Rol</th>
        <th>Acciones</th>
    </tr>
    <%
        List<Empleado> empleados = (List<Empleado>) request.getAttribute("empleados");
        if (empleados != null) {
            for (Empleado e : empleados) {
    %>
    <tr>
        <td><%= e.getId() %></td>
        <td><%= e.getNombre() %></td>
        <td><%= e.getApellidos() %></td>
        <td><%= e.getEmail() %></td>
        <td><%= e.getRol() %></td>
        <td>
            <a href="<%= request.getContextPath() %>/empleados?action=view&id=<%= e.getId() %>" class="btn btn-secondary">Ver</a>
            <a href="<%= request.getContextPath() %>/empleados?action=edit&id=<%= e.getId() %>" class="btn btn-primary">Editar</a>
            <a href="<%= request.getContextPath() %>/empleados?action=eliminar&id=<%= e.getId() %>" class="btn btn-danger"
               onclick="return confirm('¿Estás seguro de que deseas eliminar este empleado?')">Eliminar</a>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>

<%@ include file="includes/footer.jsp" %>