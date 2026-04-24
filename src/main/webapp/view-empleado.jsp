<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Empleado" %>
<%@ include file="includes/header.jsp" %>

<%
    Empleado empleado = (Empleado) request.getAttribute("empleado");
%>

<h1>Detalle de empleado</h1>

<div class="card">
    <p><strong>Nombre:</strong> <%= empleado.getNombre() %></p>
    <p><strong>Apellidos:</strong> <%= empleado.getApellidos() %></p>
    <p><strong>Email:</strong> <%= empleado.getEmail() %></p>
    <p><strong>Rol:</strong> <%= empleado.getRol() %></p>

    <div style="margin-top:20px;">
        <a href="<%= request.getContextPath() %>/empleados?action=edit&id=<%= empleado.getId() %>" class="btn btn-primary">Editar</a>
        <a href="<%= request.getContextPath() %>/empleados" class="btn btn-secondary">Volver</a>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>