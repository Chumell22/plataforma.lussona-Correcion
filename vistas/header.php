<?php
if (strlen(session_id()) < 1) //Si la variable de session no esta iniciada
{
  session_start();
}
require_once '../config/global.php';

?>

<!DOCTYPE html>
<html>

<head>
  <!--Navegador lateral-->
  <link rel="stylesheet" href="../assets/css/menuside.css">
  
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title><?= PRO_NOMBRE ?></title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="../assets/css/material-dashboard.min.css" rel="stylesheet" />
  <link rel="apple-touch-icon" href="../public/img/apple-touch-icon.png">
  

  
  <!--BoxIcons-->
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

  <!--Jquery-->
  <link href='https://code.jquery.com/jquery-3.1.1.js'>
  <link href='https://code.jquery.com/jquery-3.1.1.min.js'>


  <!--DATATABLES-->
  <link rel="stylesheet" href="../public/datatables/jquery.dataTables.min.css">
  <link rel="stylesheet" href="../public/datatables/buttons.dataTables.min.css">
  <link rel="stylesheet" href="../public/datatables/responsive.dataTables.min.css">
  <link rel="stylesheet" href="../assets/css/jquery.datetimepicker.min.css">
  <!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.11.4/datatables.min.css" />

  <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.11.4/datatables.min.js"></script> -->

  <!-- <link rel="stylesheet" href="../public/css/bootstrap-select.min.css"> -->

<body>
<style>
    tbody>tr {
      text-align: center;
      z-index:2;
      
    }

    .xdsoft_datetimepicker .xdsoft_calendar td{
      color: #fff!important;
      background-color: #03a9f4!important;
    }
  </style>

  <!-- fullCalendar -->
<link rel="stylesheet" href="../plugins/fullcalendar/main.min.css">
</head>


<nav class="sidebar close" >
  <header>
    <div class="image-text">
      <span class="image">
        <img src="../assets/imagenes/lussona-blanco.png" alt="logo_lusosna">
      </span>


      <div class="text header-text">
        <span class="name">Lussona</span>
      </div>
    </div>

    <i class='bx bxs-chevron-right toggle'></i>
  </header>

  <div class="menu-bar">
      <div class="menu">
          <ul class="menu-links">
            <li class="nav-link">
              <a href="escritorio.php">
                  <i class='bx bxs-home-alt-2 icon' ></i>
                  <span class="text nav-text">Mi Perfil</span>
              </a>
            </li>
            <?php
            if ($_SESSION['crear-reserva'] === 1){
            echo '<li class="nav-link">
                <a href="reservas.php">
                  <i class="bx bxs-calendar-plus icon"></i>
                  <span class="text nav-text">Crear Reservas</span>
              </a>
            </li>';
            }
            if ($_SESSION['listar-reservas'] === 1){
            echo '<li class="nav-link">
              <a href="listareserva.php">
                <i class="bx bxs-calendar icon"></i>
                  <span class="text nav-text">Mis Reservas</span>
              </a>
            </li>';
            }
            if ($_SESSION['editar-reservas'] === 1){
            echo '<li class="nav-link">
              <a href="reserva.php">
                  <i class="bx bx-list-ul icon"></i>
                  <span class="text nav-text">Lista de Reservas</span>
              </a>
            </li>';
            }
            if ($_SESSION['listar-usuarios'] === 1) {
            echo '<li class="nav-link">
              <a href="usuario.php">
                  <i class="bx bx-user icon"></i>
                  <span class="text nav-text">Lista de Usuarios</span>
              </a>
            </li>';
            }
            if ($_SESSION['listar-departamentos'] === 1){
            echo '<li class="nav-link">
              <a href="lista_salas.php">
                  <i class="bx bx-building-house icon" ></i>
                  <span class="text nav-text">Departamentos</span>
              </a>
            </li>';
            }
            if ($_SESSION['listar-servicios'] === 1) {
            echo '<li class="nav-link">
              <a href="listaservicios.php">
                  <i class="bx bxs-cart icon"></i>
                  <span class="text nav-text">Servicios</span>
              </a>
            </li>';
            }
            ?>
          </ul>
      </div>
</nav>

<script src="../assets/js/menu.js"></script>
<!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" navbar-scroll="true">
      <div class="container-fluid py-1 px-3">
        <nav aria-label="breadcrumb">
          <!--<h6 class="font-weight-bolder mb-0">Lussona</h6>-->
        </nav>
        <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
          <div class="ms-md-auto pe-md-3 d-flex align-items-center">
            <div class="input-group input-group-outline">
            </div>
          </div>
          <div class="navbar-nav justify-content-end position-absolute top-0 end-0">
            <li class="nav-item d-flex dropdown align-items-center">
              <a href="javascript:;" class="nav-link text-body font-weight-bold px-0" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fa fa-user me-sm-1"></i>
                <span class="d-sm-inline d-none">
                  <?php echo $_SESSION['nombre']; ?>
                </span>
              </a>
              <ul class=" dropdown-menu  dropdown-menu-end  px-2 py-3 me-sm-n4" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item border-radius-md" href="../ajax/usuario.php?op=salir">
                  <div class="d-flex py-1">
                    <div class="my-auto">
                      </div>
                      <div class="d-flex flex-column justify-content-center">
                        <h6 class="text-sm font-weight-normal mt-2">
                          <span class="font-weight-bold">Cerrar Sesión</span>
                        </h6>
                      </div>
                    </div>
                  </a>
                </ul>
              </li>
              <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
                  <div class="sidenav-toggler-inner">
                    <i class="sidenav-toggler-line"></i>
                    <i class="sidenav-toggler-line"></i>
                    <i class="sidenav-toggler-line"></i>
                  </div>
                </a>
              </li>
            </div>
          </div>
        </div>
      </nav>
      <!-- End Navbar -->
      <div class="container-fluid py-4">
        <div class="row min-vh-80 h-100">
          <div class="col-12">
          </body>
        </html>
  
                        


        