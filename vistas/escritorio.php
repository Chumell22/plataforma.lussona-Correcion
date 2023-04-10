<?php
//Activacion de almacenamiento en buffer
ob_start();
//iniciamos las variables de session
session_start();

if (!isset($_SESSION["nombre"])) {
    header("Location: sign-in.php");
} else  //Agrega toda la vista
{

    require 'header.php';
    // var_dump($_SESSION);
    require_once '../modelos/Consultas.php';


?>
<div class="card my-10 position-relative m-5  start-50 translate-middle">
        <div class="card-header p-0 position-relative mt-n4 mx-4 z-index-2">
            <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3">Dashboard</h6>
            </div>
        </div>
        <div class="card-body px-4 pt-3 text-center">
            <h4>Bienvenido a tu calendario, <?php echo $_SESSION['nombre'] ?></h4>
            <?php
            require_once '../modelos/Sala.php';
            $sala = new Sala();
            $s= $sala->mostraru($_SESSION['idusuario']);
            //var_dump($s);
            ?>
            <h5>Este es tu departamento</h5>
            <table class="table table-striped table-responsive table-sm">
                <tbody>
                    <tr>
                        <td class="text-end"><b>Departamento:</b></td>
                        <td class="text-start"><?= $s['nombre'] ?></td>
                    </tr>
                    <tr>
                        <td class="text-end"><b>Ubicacion:</b></td>
                        <td class="text-start"><?= $s['ubicacion'] ?></td>
                    </tr>
                    <tr>
                        <td class="text-end"><b>Descripcion:</b></td>
                        <td class="text-start"><?= $s['descripcion'] ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

<div class="container">
    <div class="row no-gutters">
        <div class="col-sm-12 my-n12 m-5">
            <div id="carouselExampleIndicators" class="carousel slide">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                    <img src="../assets/imagenes/carrusel3.jpg" class="d-block w-100" alt="..." width="450px" height="450px">
                    </div>
                    <div class="carousel-item">
                    <img src="../assets/imagenes/carrusel2.jpg" class="d-block w-100" alt="..."width="450px" height="450px">
                    </div>
                    <div class="carousel-item">
                    <img src="../assets/imagenes/carrusel4.jpg" class="d-block w-100" alt="..."width="450px" height="450px">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
    </div>
</div>


    <?php
    require 'footer.php';
    ?>
<?php
}
ob_end_flush(); //liberar el espacio del buffer

