<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Home Page </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>

    <jsp:include page="navbar.jsp"/>
    
    <div class="container" id="row-container">
        <div class="row">
            <div class="col-md-4">
                <div class="card" style="width: 18rem;" id="card-container-layout">
                    <div class="card-body">
                        <h5 class="card-title">Customer Login Portal</h5>
                        <p class="card-text">Login as a customer.<br> Search for rooms and make bookings.</p>
                        <a id="show-btn" href="#" class="btn btn-primary">Login</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" style="width: 18rem;" id="card-container-layout">
                    <div class="card-body">
                        <h5 class="card-title">Employee Login Portal</h5>
                        <p class="card-text">Login as an employee.<br> Convert bookings to rentings.</p>
                        <a id="show-btn" href="#" class="btn btn-primary">Login</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card" style="width: 18rem;" id="card-container-layout">
                    <div class="card-body">
                        <h5 class="card-title">Admin Login Portal</h5>
                        <p class="card-text">Login as a database admin.<br> Used to test out features (for grading purposes).</p>
                        <a id="show-btn" href="admin.jsp" class="btn btn-primary">Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

</html>