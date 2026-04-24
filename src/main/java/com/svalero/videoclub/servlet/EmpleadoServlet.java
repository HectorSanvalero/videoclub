package com.svalero.videoclub.servlet;

import com.svalero.videoclub.dao.EmpleadoDao;
import com.svalero.videoclub.domain.Empleado;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/empleados")
public class EmpleadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            EmpleadoDao empleadoDao = new EmpleadoDao();

            switch (action) {
                case "new":
                    request.getRequestDispatcher("/form-empleado.jsp").forward(request, response);
                    break;

                case "view":
                    int idView = Integer.parseInt(request.getParameter("id"));
                    Empleado empleado = empleadoDao.findById(idView);
                    request.setAttribute("empleado", empleado);
                    request.getRequestDispatcher("/view-empleado.jsp").forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Empleado empleadoEdit = empleadoDao.findById(idEdit);
                    request.setAttribute("empleado", empleadoEdit);
                    request.getRequestDispatcher("/form-empleado.jsp").forward(request, response);
                    break;

                case "eliminar":
                    int idEliminar = Integer.parseInt(request.getParameter("id"));
                    com.svalero.videoclub.domain.Empleado empleadoSesion =
                            (com.svalero.videoclub.domain.Empleado) request.getSession().getAttribute("empleado");

                    if (empleadoSesion.getId() == idEliminar) {
                        request.setAttribute("error", "No puedes eliminar el empleado que está conectado actualmente.");
                        List<Empleado> empleadosError = empleadoDao.findAll();
                        request.setAttribute("empleados", empleadosError);
                        request.getRequestDispatcher("/list-empleados.jsp").forward(request, response);
                    } else {
                        boolean eliminado = empleadoDao.eliminar(idEliminar);
                        if (!eliminado) {
                            request.setAttribute("error", "Imposible eliminar. Existen alquileres vinculados a este empleado.");
                            List<Empleado> empleadosError = empleadoDao.findAll();
                            request.setAttribute("empleados", empleadosError);
                            request.getRequestDispatcher("/list-empleados.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/empleados");
                        }
                    }
                    break;

                default:
                    List<Empleado> empleados = empleadoDao.findAll();
                    request.setAttribute("empleados", empleados);
                    request.getRequestDispatcher("/list-empleados.jsp").forward(request, response);
                    break;
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            EmpleadoDao empleadoDao = new EmpleadoDao();
            Empleado empleado = new Empleado();

            empleado.setNombre(request.getParameter("nombre"));
            empleado.setApellidos(request.getParameter("apellidos"));
            empleado.setEmail(request.getParameter("email"));
            empleado.setPassword(request.getParameter("password"));
            empleado.setRol(request.getParameter("rol"));

            if ("edit".equals(action)) {
                empleado.setId(Integer.parseInt(request.getParameter("id")));
                empleadoDao.update(empleado);
            } else {
                empleadoDao.save(empleado);
            }

            response.sendRedirect(request.getContextPath() + "/empleados");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}