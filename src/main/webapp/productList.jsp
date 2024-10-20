<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "com.sparebyte.models.Product" %>
<%@ page import = "com.sparebyte.service.product.IProductService" %>
<%@ page import = "com.sparebyte.service.product.ProductServiceImpl" %>
<%@ page import = "java.util.ArrayList" %>

<% String logoutUrl = "logout.jsp"; %>
    
<% 	
	String username = (String) session.getAttribute("user");
	String role = (String) session.getAttribute("role");
	
	String index = "";
	
	if(role.equals("admin")){
		index = "indexAdmin.jsp";
	}
	
	if (role.equals("inventory-Manager")){
		index = "indexInventoryManager.jsp";
	}
	
	if(role.equals("manager")){
		index = "indexManager.jsp";
	}
	
	if(role.equals("user")){
		index = "index.jsp";
	}
%> 
  
<!DOCTYPE html>


<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	
	<style>
	
		body{
			background-color:#f2f6fc;
			color:#69707a;
		}
		.container{
			margin-top: 50px;
			margin-bottom: 50px;
		}
		
		.card-img-top{
			height: 300px;
			object-fit: cover;
		}
		
		label{
			margin-bottom: 5px;
			margin-left: 5px;
		}
		
	</style>
	
	<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
	<title>Product List</title>
</head>

<body>

<header>
	  <!-- Navbar -->
		<nav class="navbar navbar-expand-lg navbar-light bg-white">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button" data-mdb-toggle="collapse"
				  data-mdb-target="#navbar1" aria-controls="navbarExample01" aria-expanded="false"
				  aria-label="Toggle navigation">
				  <i class="fas fa-bars"></i>
				</button>
				
				<div class="collapse navbar-collapse justify-content-between" id="navbar1">
					<ul class="navbar-nav mb-2 mb-lg-0">
					  <li class="nav-item"><span class="navbar-text">Welcome! <%= username %> <%= role %></span></li>
					</ul>
					<ul class="navbar-nav mb-2 mb-lg-0 ms-auto">
						<li class="nav-item active"><a class="nav-link" aria-current="page" href="<%=index%>">Home</a></li>
						<li class="nav-item"> <a class="nav-link" href="userProfile.jsp">Profile</a></li>
						<li class="nav-item"><a class="nav-link" href="AboutUs.jsp">About us</a></li>
						<li class="nav-item"><a class="nav-link" href="AddProduct.jsp">Add Products</a></li>
						<li class="nav-item"><a class="nav-link" href="productList.jsp">Manage Products</a></li>
						<li class="nav-item"><a class="nav-link" href="">Manage Orders</a></li>
						<form method="post" action="<%= logoutUrl %>" class="d-flex align-items-center">
            				<input class="btn btn-outline-primary" type="submit" value="Logout">
          				</form>
					</ul>
				</div>
			</div>
		</nav>
	<!-- Navbar -->
	
	<!-- Background image -->
		<div class="p-5 text-center bg-image" style="
			background-image: url(./resources/indexBackground.jpg);
			height: 400px;">
			<div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
				<div class="d-flex justify-content-center align-items-center h-100">
					<div class="text-white">
						<br><br><br>
						<h1 class="mb-3">Products List</h1>
						<h4 class="mb-3">Spare Byte</h4>
						<h4>Computer Spare Part Sellers</h4>
						<br><br><br><br>
					</div>
				</div>
			</div>
		</div>
	<!-- Background image -->
	</header>
	
	<div class="container">
		<div class="row">
			<div class="col-8 offset-2">
				  <div class="input-group">
					    <input type="text" id="searchInput" placeholder="Search products" oninput="searchProducts()" class="form-control">
				  </div>
			</div>
		</div>
	</div>
	
	
	<div class="container">
		
		<div class="row">
			<div class="col-12">
				<table class="table table-dark" id="productTable">
					<thead>
						<tr>
						  <th scope="col">Product ID</th>
						  <th scope="col">Product Name</th>
						  <th scope="col">Product Desciption</th>
						  <th scope="col">Product Category</th>
						  <th scope="col">Product Brand</th>
						  <th scope="col">Product Model</th>
						  <th scope="col">Product Price</th>
						  <th scope="col">Product Stock</th>
						  <th scope="col">Edit</th>
						  <th scope="col">Delete</th>
						</tr>
					</thead>
					<tbody>
					
						<%	
							IProductService iProductService = new ProductServiceImpl();
							ArrayList<Product> arrayList = iProductService.getProducts();
						%>
						
						<%	for(Product product: arrayList){ %>
							<tr>
								<td><%= product.getProductID() %></td>
								<td><%= product.getProductName() %></td>
								<td><%= product.getProductDec() %></td>
								<td><%= product.getProductCategory() %></td>
								<td><%= product.getProductBrand() %></td>
								<td><%= product.getProductModel() %></td>
								<td>Rs.<%= product.getProductPrice() %></td>
								<td><%= product.getProductStock() %></td>
								<td>
									<form action="<%= request.getContextPath()%>/GetProductServlet" method="post">
											<div class="form-group">
												<input type="hidden" value="<%= product.getProductID() %>" name="productID">
												<input type="submit" value="Edit" class="btn btn-outline-light btn-sm">
											</div>
									</form>
								</td>
								<td>
									<form action="<%= request.getContextPath()%>/DeleteProductServlet" onsubmit="return confirmDelete(this)" method="post">
											<div class="form-group">
												<input type="hidden" value="<%= product.getProductID() %>" name="productID">
												<input type="submit" value="Delete" class="btn btn-outline-light btn-sm">
											</div>
									</form>
								</td>
							</tr>
						<%	} %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<footer class="text-center text-lg-start bg-white text-muted">
	  <!-- Section: Social media -->
		<section class="d-flex justify-content-center p-4 border-bottom border-top">
		
			<!-- Right -->
			<div>
			  <a href="" class="me-4 link-secondary"><i class="fab fa-facebook-f"></i></a>
			  <a href="" class="me-4 link-secondary"><i class="fab fa-twitter"></i> </a>
			  <a href="" class="me-4 link-secondary"><i class="fab fa-google"></i></a>
			  <a href="" class="me-4 link-secondary"><i class="fab fa-instagram"></i></a>
			  <a href="" class="me-4 link-secondary"><i class="fab fa-linkedin"></i></a>
			  <a href="" class="me-4 link-secondary"><i class="fab fa-github"></i></a>
			</div>
			<!-- Right -->
		</section>
		<!-- Section: Social media -->
	
		<!-- Section: Links  -->
		<section class="">
			<div class="container text-center text-md-start mt-5">
				<!-- Grid row -->
				<div class="row mt-3">
					<!-- Grid column -->
					<div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
						<!-- Content -->
							<h6 class="text-uppercase fw-bold mb-4"><i class="fas fa-gem me-3 text-secondary"></i>Spare Bytes</h6>
						<p>
						  Spare Bytes is a trusted provider of computer spare parts for businesses and individuals alike. 
						  We offer a wide selection of high-quality parts at competitive prices, including motherboards, CPUs, hard drives, and more.
						</p>
					</div>
					<!-- Grid column -->
			
					<!-- Grid column -->
					<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">CPU</h6>
						<p><a href="#!" class="text-reset">Motherboards</a></p>
						<p><a href="#!" class="text-reset">RAM</a></p>
						<p><a href="#!" class="text-reset">Graphic cards</a></p>
						<p><a href="#!" class="text-reset">Storage</a></p>
					</div>
					<!-- Grid column -->
			
					<!-- Grid column -->
					<div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4"> Useful links</h6>
						<p><a href="#!" class="text-reset">Pricing</a></p>
						<p><a href="#!" class="text-reset">Settings</a></p>
						<p><a href="#!" class="text-reset">Orders</a></p>
						<p><a href="#!" class="text-reset">Help</a></p>
					</div>
					<!-- Grid column -->
			
					<!-- Grid column -->
					<div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
						<!-- Links -->
						<h6 class="text-uppercase fw-bold mb-4">Contact</h6>
						<p><i class="fas fa-home me-3 text-secondary"></i>  Malabe, MB 10012, SL</p>
						<p><i class="fas fa-envelope me-3 text-secondary"></i>      info@sparebyte.com</p>
						<p><i class="fas fa-phone me-3 text-secondary"></i> +94 71 3446 678</p>
						<p><i class="fas fa-print me-3 text-secondary"></i> +94 76 1374 567</p>
					</div>
					<!-- Grid column -->
				</div>
				<!-- Grid row -->
			</div>
		</section>
		<!-- Section: Links  -->
	
		<!-- Copyright -->
		<div class="text-center p-4" style="background-color: rgba(0, 0, 0, 0.025);">
		  © 2023 Copyright Spare Bytes
		</div>
		<!-- Copyright -->
	</footer>
	<!-- Footer -->
	
	<script type="text/javascript">
		function confirmDelete(form){
			
			Swal.fire({
				title: 'Are you sure?',
				text: "You won't be able to revert this!",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes, delete it!'
				
			}).then((result) => {
					if (result.isConfirmed) {
					  
						Swal.fire(
						  'Deleted!',
						  'Your file has been deleted.',
						  'success',
						  
					   ).then(() => {
					   	
					         setTimeout(() => {
					        	 
					             form.submit();
					             
									}, 400);
				         });
					}
				})
				return false;
		}
		
		function searchProducts() {
			  var input, filter, table, tr, td, i, txtValue;
			  input = document.getElementById("searchInput");
			  filter = input.value.toUpperCase();
			  table = document.querySelector(".table");
			  tr = table.getElementsByTagName("tr");

			  for (i = 0; i < tr.length; i++) {
			    td = tr[i].getElementsByTagName("td");
			    for (var j = 0; j < td.length; j++) {
			      var cell = td[j];
			      if (cell) {
			        txtValue = cell.textContent || cell.innerText;
			        if (txtValue.toUpperCase().indexOf(filter) > -1) {
			          tr[i].style.display = "";
			          break;
			        } else {
			          tr[i].style.display = "none";
			        }
			      }
			    }
			  }
			}

	</script>

</body>

</html>
</html>