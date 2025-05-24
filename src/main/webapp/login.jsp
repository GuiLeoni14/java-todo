<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <%@include file="base-head.jsp"%>
    
    <style>
	    .hidden {
	      display: none;
	    }
  	</style>
  </head>
  <body>
  <%@include file="modal.html"%>
    <%@include file="nav-menu.jsp"%>
  
    <div class="d-flex flex-column min-vh-100 bg-light">
      <main class="flex-grow-1 d-flex justify-content-center align-items-center">
        <div class="card shadow-sm p-4" style="margin-left: auto; margin-right: auto; width: 100%; max-width: 400px; display: flex; flex-direction: column; gap:10px; justify-content: center;">
          
          <h2 class="text-center mb-4">Login</h2>
          
          <form action="/crud-manager/login" method="POST" style="display: flex; flex-direction: column; gap: 10px;">
            <div class="mb-3">
              <label for="user_login_id" class="form-label">Login (e-mail)</label>
              <input type="text" class="form-control" id="user_login_id" name="user_login" required />
            </div>
            
            <div class="mb-3">
              <label for="user_pw_id" class="form-label">Senha</label>
              <input type="password" class="form-control" id="user_pw_id" name="user_pw" required />
            </div>
            
            <div class="d-grid mb-3">
              <button type="submit" class="btn btn-dark btn-lg">Logar</button>
            </div>
            
            <c:if test="${param.erro == 'true'}">
			    <span class="text-danger small">Usuário ou senha inválidos.</span>
			</c:if>
          </form>
          
        </div>
      </main>
    </div>
  </body>
</html>