<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<%
    Cliente cliente = (Cliente) request.getAttribute("cliente");
%>

<h1>Detalle de cliente</h1>

<div class="card">
    <p><strong>Nombre:</strong> <%= cliente.getNombre() %></p>
    <p><strong>Apellidos:</strong> <%= cliente.getApellidos() %></p>
    <p><strong>Email:</strong> <%= cliente.getEmail() %></p>
    <p><strong>Teléfono:</strong> <%= cliente.getTelefono() %></p>
    <p><strong>Activo:</strong> <%= cliente.isActivo() ? "Sí" : "No" %></p>

    <div style="margin-top:20px;">
        <a href="<%= request.getContextPath() %>/clientes?action=edit&id=<%= cliente.getId() %>" class="btn btn-primary">Editar</a>
        <a href="<%= request.getContextPath() %>/clientes" class="btn btn-secondary">Volver</a>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>