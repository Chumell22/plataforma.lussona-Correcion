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
  if ($_SESSION['crear-reserva'] == 1) {
    require_once '../modelos/Reserva.php';
    $id = $_SESSION['idusuario'];
    $reservas = new Reserva();
    $resultado = $reservas->listar();
?>
    <style>
      .input-disabled {
        width: 30px;
        text-align: center;
        border-radius: 6px;
      }
    </style>
    <div class="row md-5">
      <?php
      if ($resultado->num_rows < 8) { ?>
        <div class="col-md-3 m-8 my-5">
          <div class="sticky-top mb-3">
            <div class="card">
              <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                  <h6 class="text-white text-capitalize ps-3">Formulario de reservas</h6>
                </div>
              </div>
              <div class="card-body px-3 pb-2">
                <!-- the events -->
                <div id="external-events">
                  <form name="formulario" id="formulario" method="POST">

                    <!-- <input type="hidden" name="idreserva" id="idreserva"> -->
                    <input type="hidden" name="nombre" id="nombre">
                    <!-- <div class="input-group input-group-static is-filled focused is-focused mb-4">
                      <label>Reserva a Nombre de:</label>
                    </div> -->

                    <div class="input-group input-group-static mb-4">
                      <label>Periodo de Reseva:</label>
                      <select name="periodo" id="periodo" class="form-control" required>
                        <option value="Periodo 1">Periodo 1</option>
                        <option value="Periodo 2">Periodo 2</option>
                        <option value="Periodo 3">Periodo 3</option>
                        <option value="Periodo 4">Periodo 4</option>
                        <option value="Periodo 5">Periodo 5</option>
                        <option value="Periodo 6">Periodo 6</option>
                        <option value="Periodo 7">Periodo 7</option>
                        <option value="Periodo 8">Periodo 8</option>
                      </select>
                    </div>

                    

                    <div class="input-group input-group-static mb-4">
                      <label>Desde:</label>
                      <!-- <input type="datetime-local" class="form-control" name="desde" id="desde" required> -->
                      <input class="form-control" id="desde" name="desde" type="text" autocomplete="off" readonly="true">

                    </div>

                    <div class="input-group input-group-static mb-4">
                      <label>Hasta:</label>
                      <!-- <input type="datetime-local" class="form-control" name="hasta" id="hasta" required> -->
                      <input class="form-control" id="hasta" name="hasta" type="text" autocomplete="off" readonly="true">
                    </div>

                    <div class="form-check my-3 px-0">
                      <label>Servicios:</label>
                      <table style="width:100%">
                        <thead>
                          <tr>
                            <th style="text-align:center">Dis</th>
                            <th style="text-align:center">Cant</th>
                            <th style="text-align:center">Servicio</th>
                            <th style="text-align:center">--</th>
                          </tr>
                        </thead>
                        <tbody id="services">
                        </tbody>
                      </table>
                    </div>

                    <div class="input-group input-group-static mb-4">
                      <label>Descripci:</label>
                      <textarea rows="3" class="form-control" name="descripcion" id="descripcion"></textarea>
                    </div>


                    <div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
                      <button class="btn bg-gradient-primary" type="submit" id="btnGuardar"><i class="fa fa-save"></i>Guardar</button>
                      <button class="btn bg-gradient-danger" onclick="cancelarform()" type="button"><i class="fa fa-arrow-circle-left"></i> Cancelar</button>
                    </div>

                  </form>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

          </div>
        </div>
      <?php } ?>
      <!-- /.col -->
      <div class="col-md-6 my-4">
        <div class="card">
          <div class="card-header p-1 position-relative mt-n4 mx-3 z-index-2">
            <div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3">
              <h6 class="text-white text-capitalize ps-3">Calendario</h6>
            </div>
          </div>
          <div class="card-body p-2">
            <!-- THE CALENDAR -->
            <div id="calendar"></div>
          </div>
          <!-- /.card-body -->
        </div>
        <!-- /.card -->
      </div>
      <!-- /.col -->
    </div>
    <!-- /.row -->
    <!-- <div class="row">
            <div class="col-12">
              <div class="card my-4">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                  <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                    <h6 class="text-white text-capitalize ps-3">Lista de reservas</h6>
                  </div>
                </div>
                <div class="card-body px-0 pb-2">
                  <table id="tblistado" class="table-responsive table py-4 px-3">
                    <thead>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Fecha Inicio</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Fecha de Fin</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Sala</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Monto</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Descripcion</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Reservado</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder text-center opacity-7 ps-2">Observaciones</th>
                      <th></th>
                    </thead>
                    <tbody></tbody>
                  </table>
                  <div class="mt-5" id="feedback"></div>
                </div>
              </div>
            </div>
          </div> -->
    </div><!-- /.container-fluid -->
    </section>
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
      <div class="toast align-items-center text-bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true" id="liveToast" style="background-color: #ff00008c; color: #fff">
        <div class="d-flex">
          <div class="toast-body">
            El botón de guardar se activará hasta que selecciones la fecha con los días permitidos
          </div>
        </div>
      </div>
    </div>


    </div>


    <!-- Control Sidebar -->

    <!-- /.control-sidebar -->

    <!-- ./wrapper -->

    <!-- jQuery -->

    <!-- fullCalendar 2.2.5 -->




  <?php


  } //Llave de la condicion if de la variable de session

  else {
    require 'noacceso.php';
  }


  require 'footer.php';


  ?>

  <!-- Bootstrap -->
  <!-- jQuery UI -->
  <script src="../plugins/jquery-ui/jquery-ui.min.js"></script>
  <!-- fullCalendar 2.2.5 -->
  <script src="../plugins/moment/moment.min.js"></script>
  <script src="../plugins/fullcalendar/main.js"></script>

  <script src="./scripts/reservas.js"></script>
  <!-- AdminLTE for demo purposes -->

  <!-- Page specific script -->
  <script src="../public/js/JsBarcode.all.min.js"></script>
  <script src="../public/js/jquery.PrintArea.js"></script>
  <script src="../assets/js/plugins/jquery.datetimepicker.full.min.js"></script>
  <script type="text/javascript">
    
    var fechasOcupadas = [];
    $(function() {
      $.datetimepicker.setLocale('es');
      $.ajax({
        url: "../ajax/reserva.php?op=getDates",
        method: "GET",
        dataType: 'JSON'
      }).done(function(data) {
        fechasOcupadas = data;
      });
    });

    window.addEventListener("load", function() {
      setTimeout(loadDatetimepicker, 500);
    }, false);


    function loadDatetimepicker() {
      minDate: new Date()
      $('#desde').datetimepicker({
        defaultSelect: false,
        disabledWeekDays: [1, 2, 3, 5, 6],
        disabledDates: fechasOcupadas,
        allowBlank: false,
        defaultTime:'15:00',
        timepicker: false,
        // onSelectDate: function(ct,$i){
        //   alert('');
        // }
        minDate: new Date()
      });

      minDate: new Date()
      $('#hasta').datetimepicker({
        defaultSelect: false,
        disabledWeekDays: [1, 2, 3, 5, 6],
        allowBlank: false,
        defaultTime:'12:00',
        timepicker: false,
        datepicker:false,
        // onSelectDate: function(ct,$i){
        //   alert('');
        // }
        minDate: new Date()
      });

      $('.button-add-service').click(function() {
        var serviceDis = $(this).data("service-disp");
        var serviceid = $(this).data("serviceid");
        var account = parseInt($('.service-' + serviceid).val());
        account = account + 1;
        $('.service-' + serviceid).val(account);
        if (serviceDis <= account) {
          $(this).prop("disabled", true)
        } else {
          $('.btn-remove-service-' + serviceid).prop("disabled", false)
        }
      });
      $('.button-remove-service').click(function() {
        var serviceDis = $(this).data("service-disp");
        var serviceid = $(this).data("serviceid");
        var account = parseInt($('.service-' + serviceid).val());
        account = account - 1;
        $('.service-' + serviceid).val(account);
        console.log(account)
        if (0 >= account) {
          $(this).prop("disabled", true)
          console.log(account)
        } else {
          $('.btn-add-service-' + serviceid).prop("disabled", false)
        }
      });

      $('#desde').change(function() {
        var fechadesde = moment($(this).val()).add(0, 'days').format('YYYY-MM-DDTHH:mm');
        $(this).val(fechadesde);
        var fechainicio = moment($(this).val()).format('dddd');

        if (fechainicio == "Sunday") {
          var fechahasta = moment($(this).val()).add(93, 'hours').format('YYYY-MM-DDTHH:mm');
          $('#hasta').val(fechahasta);
        } else if (fechainicio == "Thursday") {
          var fechahasta = moment($(this).val()).add(69, 'hours').format('YYYY-MM-DDTHH:mm');
          $('#hasta').val(fechahasta);
        }
      });
    }
  </script>
<?php

}
ob_end_flush(); //liberar el espacio del buffer
?>