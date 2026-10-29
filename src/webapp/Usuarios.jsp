<%@ page import="org.gerdoc.service.UsuarioService" %>
<%@ page import="org.gerdoc.service.impl.UsuarioServiceImpl" %>
<%@ page import="org.gerdoc.model.Usuario" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <h1>Usuarios</h1>
    <%
        UsuarioService usuarioService = new UsuarioServiceImpl( );
        List<Usuario> usuarios = usuarioService.findAll( );
    %>
    <button type="button" class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#usuarioModal" onclick="nuevoUsuario()" >
        Agregar usuario
    </button>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Nombre</th>
            <th scope="col">Edad</th>
            <th scope="col">Promedio</th>
            <th scope="col">Acción</th>
        </tr>
        </thead>
        <%
            int i = 0;
            for (Usuario usuario : usuarios)
            {
        %>
                <tbody>
                    <tr>
                        <th scope="row"><%=++i%></th>
                        <td>
                            <a href="Usuario.jsp?id=<%= usuario.getId( ) %>" class="link-primary link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover">
                                <%= usuario.getNombre( ) %>
                            </a>
                        </td>
                        <td><%= usuario.getEdad( )%></td>
                        <td><%= usuario.getPromedio( )%></td>
                        <td>
                            <!-- BOTÓN EDITAR -->

                            <button type="button" class="btn btn-warning btn-sm btn-editar" data-bs-toggle="modal" data-bs-target="#usuarioModal"
                                    data-id="<%= usuario.getId( ) %>" data-nombre="<%= usuario.getNombre( ) %>" data-edad="<%= usuario.getEdad( ) %>"
                                    data-promedio="<%= usuario.getPromedio( ) %>" >
                                Editar
                            </button>
                            <!-- BOTÓN BORRAR -->
                            <form action="UsuarioServlet" method="post" style="display:inline;">
                                <input type="hidden" name="accion" value="delete">
                                <input type="hidden" name="id" value="<%= usuario.getId( ) %>">
                                <button type="submit" class="btn btn-danger btn-sm"
                                        onclick="return confirm('¿Seguro que deseas borrar este usuario?');">
                                    Borrar
                                </button>
                            </form>
                        </td>
                    </tr>
                </tbody>
        <%
            }
        %>
    </table>
    <a href="index.jsp" class="btn btn-secondary">Home</a>
</div>
<!-- Popup / Modal con formulario -->
<div class="modal fade" id="usuarioModal" tabindex="-1" aria-labelledby="usuarioModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="usuarioModalLabel">Formulario de usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>

            <form action="UsuarioServlet" method="post" id="formUsuario">
                <input type="hidden" id="accion" name="accion" value="save" />
                <input type="hidden" id="id" name="id" value="">
                <div class="modal-body">

                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>

                    <div class="mb-3">
                        <label for="edad" class="form-label">Edad</label>
                        <input type="number" class="form-control" id="edad" name="edad" required>
                    </div>

                    <div class="mb-3">
                        <label for="promedio" class="form-label">Promedio</label>
                        <input type="number" step="0.01" class="form-control" id="promedio" name="promedio" required>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Cerrar
                    </button>

                    <button type="submit" class="btn btn-primary">
                        Guardar usuario
                    </button>
                </div>
            </form>

        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<!-- JAVASCRIPT -->

<script>
    function nuevoUsuario()
    {
        document.getElementById("formUsuario").reset();
        document.getElementById("id").value = "0";
        document.getElementById("accion").value = "save";
        document.getElementById("usuarioModalLabel").textContent = "Agregar usuario";
        document.getElementById("btnGuardar").textContent = "Guardar usuario";
    }
    const modalUsuario = document.getElementById("usuarioModal");
    modalUsuario.addEventListener("show.bs.modal",
        function(event)
        {
            const boton = event.relatedTarget;
            if (!boton || !boton.classList.contains("btn-editar"))
            {
                return;
            }
            const id = boton.getAttribute("data-id");
            const username = boton.getAttribute("data-username");
            const password = boton.getAttribute("data-contraseña");
            const rol_id = boton.getAttribute("data-rolId");
            const alumno_id = boton.getAttribute("data-rolId");
            document.getElementById("id").value = id;
            document.getElementById("nombre").value = nombre;
            document.getElementById("edad").value = edad;
            document.getElementById("promedio").value = promedio;
            document.getElementById("accion").value = "update";
            document.getElementById("usuarioModalLabel").textContent = "Editar usuario";
            document.getElementById("btnGuardar").textContent = "Actualizar usuario";
        }
    );
</script>
</body>
</html>