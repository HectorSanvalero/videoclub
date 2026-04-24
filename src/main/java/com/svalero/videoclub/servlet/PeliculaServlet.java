package com.svalero.videoclub.servlet;

import com.svalero.videoclub.dao.PeliculaDao;
import com.svalero.videoclub.domain.Pelicula;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/peliculas")
public class PeliculaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            PeliculaDao peliculaDao = new PeliculaDao();

            switch (action) {
                case "view":
                    int idView = Integer.parseInt(request.getParameter("id"));
                    Pelicula pelicula = peliculaDao.findById(idView);
                    request.setAttribute("pelicula", pelicula);
                    request.getRequestDispatcher("/view-pelicula.jsp").forward(request, response);
                    break;

                case "new":
                    request.getRequestDispatcher("/form-pelicula.jsp").forward(request, response);
                    break;

                case "edit":
                    int idEdit = Integer.parseInt(request.getParameter("id"));
                    Pelicula peliculaEdit = peliculaDao.findById(idEdit);
                    request.setAttribute("pelicula", peliculaEdit);
                    request.getRequestDispatcher("/form-pelicula.jsp").forward(request, response);
                    break;

                case "delete":
                    int idDelete = Integer.parseInt(request.getParameter("id"));
                    peliculaDao.delete(idDelete);
                    response.sendRedirect(request.getContextPath() + "/peliculas");
                    break;

                case "search":
                    String titulo = request.getParameter("titulo") != null ? request.getParameter("titulo") : "";
                    String genero = request.getParameter("genero") != null ? request.getParameter("genero") : "";
                    List<Pelicula> resultados = peliculaDao.search(titulo, genero);
                    request.setAttribute("peliculas", resultados);
                    request.setAttribute("titulo", titulo);
                    request.setAttribute("genero", genero);
                    request.getRequestDispatcher("/list-peliculas.jsp").forward(request, response);
                    break;

                default:
                    List<Pelicula> peliculas = peliculaDao.findAll();
                    request.setAttribute("peliculas", peliculas);
                    request.getRequestDispatcher("/list-peliculas.jsp").forward(request, response);
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
            PeliculaDao peliculaDao = new PeliculaDao();
            Pelicula pelicula = new Pelicula();

            pelicula.setTitulo(request.getParameter("titulo"));
            pelicula.setGenero(request.getParameter("genero"));
            pelicula.setAnyo(Integer.parseInt(request.getParameter("anyo")));
            pelicula.setDirector(request.getParameter("director"));
            pelicula.setImagen(request.getParameter("imagen"));
            pelicula.setDisponible(true);
            pelicula.setStock(Integer.parseInt(request.getParameter("stock")));

            if ("edit".equals(action)) {
                pelicula.setId(Integer.parseInt(request.getParameter("id")));
                peliculaDao.update(pelicula);
            } else {
                peliculaDao.save(pelicula);
            }

            response.sendRedirect(request.getContextPath() + "/peliculas");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}