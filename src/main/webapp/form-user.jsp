<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <%@include file="base-head.jsp"%>
</head>
<body>
    <%@include file="nav-menu.jsp"%>

    <div id="container" class="container-fluid">
        <h3 class="page-header">${not empty user ? "Editar Usuário" : "Adicionar Usuário"}</h3>

        <form action="${pageContext.request.contextPath}/user/${action}" method="POST">
            <input type="hidden" value="${user.getId()}" name="userId">
            <div class="row">
                <div class="form-group col-md-3">
                    <label for="name">Nome</label>
                    <input type="text" class="form-control" id="name" name="name" 
                           required placeholder="Nome do usuário"
                           value="${user.getName()}"
                           oninvalid="this.setCustomValidity('Informe o nome do usuário.')"
                           oninput="setCustomValidity('')">
                </div>

                <div class="form-group col-md-3">
                    <label for="gender">Sexo</label>
                    <select id="gender" class="form-control selectpicker" name="gender" 
                            required oninvalid="this.setCustomValidity('Informe o sexo')"
                            oninput="setCustomValidity('')">
                        <option value="" disabled ${not empty user ? "" : "selected"}>Selecione o sexo</option>
                        <option value="F" ${user.getGender() == 'F' ? "selected" : ""}>Feminino</option>
                        <option value="M" ${user.getGender() == 'M' ? "selected" : ""}>Masculino</option>
                    </select>
                </div>

                <div class="form-group col-md-3">
                    <label for="mail">E-mail</label>
                    <input type="email" class="form-control" id="mail" name="mail" 
                           required placeholder="E-mail do usuário"
                           value="${user.getEmail()}"
                           oninvalid="this.setCustomValidity('Informe o e-mail do usuário.')"
                           oninput="setCustomValidity('')">
                </div>

                <div class="form-group col-md-3">
                    <label for="password">Senha</label>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="${not empty user ? 'Deixe em branco para manter' : 'Digite a senha'}"
                           ${empty user ? "required" : ""}
                           oninvalid="this.setCustomValidity('Informe a senha.')"
                           oninput="setCustomValidity('')">
                </div>
            </div>

            <hr />
            <div id="actions" class="row pull-right">
                <div class="col-md-12">
                    <a href="${pageContext.request.contextPath}/users" class="btn btn-default">Cancelar</a>
                    <button type="submit" class="btn btn-primary">
                        ${not empty user ? "Alterar Usuário" : "Cadastrar Usuário"}
                    </button>
                </div>
            </div>
        </form>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
