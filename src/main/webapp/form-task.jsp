<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
</head>
<body>
    <%@include file="nav-menu.jsp"%>

    <div id="container" class="container-fluid">
        <h3 class="page-header">${not empty task ? "Editar Tarefa" : "Cadastrar Tarefa"}</h3>

        <form action="${pageContext.request.contextPath}/task/${action}" method="POST">
            <input type="hidden" name="taskId" value="${task.id}"/>

            <div class="row">
                <div class="form-group col-md-6">
                    <label for="description">Descrição</label>
                    <input type="text" class="form-control" id="description" name="description"
                           placeholder="Descrição da tarefa" required
                           value="${task.description}"
                           oninvalid="this.setCustomValidity('Por favor, informe a descrição.')"
                           oninput="setCustomValidity('')"/>
                </div>

                <div class="form-group col-md-3">
                    <label for="status">Status</label>
                    <select id="status" class="form-control" name="status" required
                            oninvalid="this.setCustomValidity('Por favor, selecione o status.')"
                            oninput="setCustomValidity('')">
                        <option value="" disabled ${empty task.status ? "selected" : ""}>Selecione</option>
                        <option value="PENDING" ${task.status == 'PENDING' ? "selected" : ""}>Pendente</option>
                        <option value="IN_PROGRESS" ${task.status == 'IN_PROGRESS' ? "selected" : ""}>Em andamento</option>
                        <option value="DONE" ${task.status == 'DONE' ? "selected" : ""}>Concluída</option>
                    </select>
                </div>

                <div class="form-group col-md-3">
                    <label for="dueDate">Data Limite</label>
                    <input type="date" class="form-control" id="dueDate" name="dueDate"
                           value="${task.dueDate}" />
                </div>
            </div>

            <div class="row">
                <div class="form-group col-md-6">
                    <label for="userId">Usuário Responsável</label>
                    <select id="userId" class="form-control" name="userId" required
                            oninvalid="this.setCustomValidity('Por favor, selecione um usuário.')"
                            oninput="setCustomValidity('')">
                        <option value="" disabled ${empty task.userId ? "selected" : ""}>Selecione um usuário</option>
                        <c:forEach var="u" items="${users}">
                            <option value="${u.id}" ${task.userId == u.id ? "selected" : ""}>
                                ${u.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <hr />
            <div id="actions" class="row pull-right">
                <div class="col-md-12">
                    <a href="${pageContext.request.contextPath}/tasks" class="btn btn-default">Cancelar</a>
                    <button type="submit" class="btn btn-primary">${not empty task ? "Atualizar Tarefa" : "Cadastrar Tarefa"}</button>
                </div>
            </div>
        </form>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
