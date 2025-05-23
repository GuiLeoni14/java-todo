<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
</head>
<body>
    <%@include file="modal.html"%>
    <%@include file="nav-menu.jsp"%>

    <div id="container" class="container-fluid">
        <div id="alert" style="${not empty message ? 'display: block;' : 'display: none;'}" 
             class="alert alert-dismissable ${alertType eq 1 ? 'alert-success' : 'alert-danger'}">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            ${message}
        </div>

        <div id="top" class="row">
            <div class="col-md-6">
                <h3>Tarefas</h3>
            </div>

            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/task/form" 
                   class="btn btn-danger pull-right h2">
                   <span class="glyphicon glyphicon-plus"></span>&nbspAdicionar Tarefa
                </a>
            </div>
        </div>

        <hr />

        <div id="list" class="row">
            <div class="table-responsive col-md-12">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Descrição</th>
                            <th>Status</th>
                            <th>Data Limite</th>
                            <th>Usuário</th>
                            <th>Editar</th>
                            <th>Excluir</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="task" items="${tasks}">
                            <tr>
                                <td>${task.description}</td>
                                <td>${task.status}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty task.dueDate}">
                                            ${task.dueDate}
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:forEach var="u" items="${users}">
                                        <c:if test="${u.id == task.userId}">
                                            ${u.name}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <a class="btn btn-info btn-xs" 
                                       href="${pageContext.request.contextPath}/task/form?taskId=${task.id}">
                                       <span class="glyphicon glyphicon-edit"></span>
                                    </a>
                                </td>
                                <td>
                                    <a class="btn btn-danger btn-xs modal-remove"
                                       data-task-id="${task.id}" 
                                       data-task-desc="${task.description}"
                                       data-toggle="modal" data-target="#delete-modal">
                                       <span class="glyphicon glyphicon-trash"></span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            setTimeout(function () {
                $("#alert").slideUp(500);
            }, 3000);

            $(".modal-remove").click(function () {
                var taskDesc = $(this).data('task-desc');
                var taskId = $(this).data('task-id');
                $(".modal-body #hiddenValue").text("a tarefa '" + taskDesc + "'");
                $("#id").attr("value", taskId);
                $("#form").attr("action", "task/delete");
            });
        });
    </script>
</body>
</html>
