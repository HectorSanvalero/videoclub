<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Cliente" %>
<%@ include file="includes/header.jsp" %>

<%
    Cliente cliente = (Cliente) request.getAttribute("cliente");
    boolean esEdicion = cliente != null;
%>

<h1><%= esEdicion ? "Editar cliente" : "Nuevo cliente" %></h1>

<div class="card">
    <form action="<%= request.getContextPath() %>/clientes" method="post">
        <input type="hidden" name="action" value="<%= esEdicion ? "edit" : "new" %>">
        <% if (esEdicion) { %>
        <input type="hidden" name="id" value="<%= cliente.getId() %>">
        <% } %>

        <div class="form-group">
            <label>Nombre</label>
            <input type="text" name="nombre" required
                   value="<%= esEdicion ? cliente.getNombre() : "" %>">
        </div>

        <div class="form-group">
            <label>Apellidos</label>
            <input type="text" name="apellidos" required
                   value="<%= esEdicion ? cliente.getApellidos() : "" %>">
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required
                   value="<%= esEdicion ? cliente.getEmail() : "" %>">
        </div>

        <div class="form-group">
            <label>Teléfono</label>
            <input type="text" name="telefono"
                   value="<%= esEdicion ? cliente.getTelefono() : "" %>">
        </div>

        <div style="display:flex; gap:10px;">
            <button type="submit" class="btn btn-primary">
                <%= esEdicion ? "Guardar cambios" : "Crear cliente" %>
            </button>
            <a href="<%= request.getContextPath() %>/clientes" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>