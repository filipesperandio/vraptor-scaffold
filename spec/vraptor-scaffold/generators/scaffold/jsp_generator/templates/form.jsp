<head>
  <script src="/javascripts/Product.js"></script>
  <script src="/javascripts/ProductController.js"></script>
</head>

<c:if test="${not empty errors}">
<c:forEach items="${errors}" var="error">
<div class="control-group error">
  <label class="control-label" for="inputError"> ${error.category} - ${error.message}</label>
</div>
</c:forEach>
</c:if>

<script>
  product = ${json};
</script>

<div class="row" ng-controller="ProductController">
  <div class="span6">
    <div class="well">
      <form action="${pageContext.request.contextPath}/products" method="post" class="form-horizontal" id="productForm">
        <fieldset>
          <legend>product</legend>
          <c:if test="${not empty product.id}">
          <input type="hidden" name="product.id" value="${product.id}"
                 ng-model="product.id" />
          <input type="hidden" name="_method" value="put"/>
          </c:if>

                      <div class="control-group">
              <label class="control-label" for="product.name">
                Name
              </label>
              <div class="controls">
                <input type="text" name="product.name" id="product.name" value="${product.name}"
                       ng-model="product.name" />
              </div>
            </div>
                      <div class="control-group">
              <label class="control-label" for="product.myFlag">
                My flag
              </label>
              <div class="controls">
                <input type="text" name="product.myFlag" id="product.myFlag" value="${product.myFlag}"
                       ng-model="product.myFlag" />
              </div>
            </div>
          
          <div class="form-actions">
            <div class="pull-right">
              <button type="submit" class="btn btn-primary">Save!</button>
              <a href="${pageContext.request.contextPath}/products" class="btn">Cancel</a>
            </div>
          </div>
        </fieldset>
      </form>
    </div>
  </div>
  <div class="span6"></div>
</div>

