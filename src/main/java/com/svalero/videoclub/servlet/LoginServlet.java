package com.svalero.videoclub.servlet;

import com.svalero.videoclub.dao.EmpleadoDao;
import com.svalero.videoclub.domain.Empleado;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            EmpleadoDao empleadoDao = new EmpleadoDao();
            Empleado empleado = empleadoDao.findByEmailAndPassword(email, password);

            if (empleado != null) {
                HttpSession session = request.getSession();
                session.setAttribute("empleado", empleado);
                session.setAttribute("rol", empleado.getRol());
                response.sendRedirect(request.getContextPath() + "/peliculas");
            } else {
                request.setAttribute("error", "Email o contraseña incorrectos");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}