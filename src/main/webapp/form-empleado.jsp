<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.videoclub.domain.Empleado" %>
<%@ include file="includes/header.jsp" %>

<%
    Empleado empleado = (Empleado) request.getAttribute("empleado");
    boolean esEdicion = empleado != null;
%>

<h1><%= esEdicion ? "Editar empleado" : "Nuevo empleado" %></h1>

<div class="card">
    <form action="<%= request.getContextPath() %>/empleados" method="post">
        <input type="hidden" name="action" value="<%= esEdicion ? "edit" : "new" %>">
        <% if (esEdicion) { %>
        <input type="hidden" name="id" value="<%= empleado.getId() %>">
        <% } %>

        <div class="form-group">
            <label>Nombre</label>
            <input type="text" name="nombre" required
                   pattern="[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+"
                   title="Solo letras y espacios"
                   value="<%= esEdicion ? empleado.getNombre() : "" %>">
        </div>

        <div class="form-group">
            <label>Apellidos</label>
            <input type="text" name="apellidos" required
                   pattern="[A-Za-záéíóúÁÉÍÓÚüÜñÑ ]+"
                   title="Solo letras y espacios"
                   value="<%= esEdicion ? empleado.getApellidos() : "" %>">
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" required
                   value="<%= esEdicion ? empleado.getEmail() : "" %>">
        </div>

        <div class="form-group">
            <label>Contraseña</label>
            <input type="password" name="password" <%= esEdicion ? "" : "required" %>>
        </div>

        <div class="form-group">
            <label>Rol</label>
            <select name="rol" required>
                <option value="empleado" <%= esEdicion && "empleado".equals(empleado.getRol()) ? "selected" : "" %>>Empleado</option>
                <option value="admin" <%= esEdicion && "admin".equals(empleado.getRol()) ? "selected" : "" %>>Admin</option>
            </select>
        </div>

        <div style="display:flex; gap:10px;">
            <button type="submit" class="btn btn-primary">
                <%= esEdicion ? "Guardar cambios" : "Crear empleado" %>
            </button>
            <a href="<%= request.getContextPath() %>/empleados" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@ include file="includes/footer.jsp" %>