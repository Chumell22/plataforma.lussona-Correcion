var tabla;
//Funcion que se ejecuta al inicio
$(function () {
    $('#desde').change(function (){
        //Variable array de días de la semana
    var weekday = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
        //Creación de variable y asignación de la variable al día de la semana correspondiente
    var dayselect = weekday[new Date($(this).val()).getDay()]; 
        //Variable array de días no permitidos
    var dayNotAllow = ['Monday','Tuesday','Wednesday','Friday', 'Saturday'];
        //Variable dias permitidos

    var dayPermision = ['Sunday', 'Thursday']
        //Foreach que se recorre del array de los días no permitidos
        //Variable day obtiene el valor del día en cada recorrido
    dayNotAllow.forEach(function(day) {
            //Validación que el día seleccionado este en los días no permitidos
        if(dayselect == day){
            alert('Estos días no son permitidos')
            $('#btnGuardar').prop('disabled', true);
            const toastLiveExample = document.getElementById('liveToast')
            const toast = new bootstrap.Toast(toastLiveExample)
            toast.show()
        }
    });

    dayPermision.forEach(function(day) {
        if (dayselect == day) {
            $('#btnGuardar').prop('disabled', false);
        }
    })
});

    //Termina lo de #desde 
    $('#hasta').change(function (){
        //Variable array de días de la semana
    var weekday = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
        //Creación de variable y asignación de la variable al día de la semana correspondiente
    var dayselect = weekday[new Date($(this).val()).getDay()]; 
        //Variable array de días no permitidos
    var dayNotAllow = ['Monday','Tuesday','Wednesday','Friday','Saturday'];

    var dayPermision = ['Sunday', 'Thursday']

        //Foreach que se recorre del array de los días no permitidos
        //Variable day obtiene el valor del día en cada recorrido
    dayNotAllow.forEach(function(day) {
            //Validación que el día seleccionado este en los días no permitidos
        if(dayselect == day){
            alert('Estos días no son permitidos')
            $('#btnGuardar').prop('disabled', true);
            const toastLiveExample = document.getElementById('liveToast')
            const toast = new bootstrap.Toast(toastLiveExample)
            toast.show()
        }
    });

    dayPermision.forEach(function(day) {
        if (dayselect == day) {
            $('#btnGuardar').prop('disabled', false);
        }
    })
});
    // document.$('#nombre').val()title = "Reservas"
    mostrarform(false)
    listar()
    $("#formulario").on("submit", function (e) {
    guardaryeditar(e);
})

    // $("#desde").prop("type", "datetime-local");
    // $("#hasta").prop("type", "datetime-local");
    // console.log($("#servicios"))
    $.post("../auth/Auth.php?op=id", function (data) {
    $("#nombre").val(data)
}).done(function() {
    $.ajax({
        url: "../ajax/services.php?function=servicesAvailable",
        data: { userid: $('#nombre').val() },
        type: "GET",
        success: function (data) {
            $("#services").html(data);
        },
        error: function (error) {
            console.log(error);
        }
    });
});
})

//funcion limpiar
function limpiar() {
    $("#idreserva").val("");
    // $("#nombre").val("");
    $("#periodo").val("Dia");
    $("#desde").val("");
    $("#hasta").val("");
    // $("#costo").val("");
    // $("#servicios[]")[0].checked = false;
    $("#descripcion").val("");
    $("#btnGuardar").prop("disabled", false);

}

//funcion mostrar formulario

function mostrarform(flag) {
    limpiar();

    if (flag) {
        $("#listadoregistros").hide();
        $("#formularioregistros").show();
        $("#btnGuardar").prop("disabled", false);
        $("#btnagregar").hide();
    }
    else {

        $("#listadoregistros").show();
        $("#formularioregistros").hide();
        $("#btnagregar").show();
    }
}


//Funcion cancelarform
function cancelarform() {
    limpiar();
    mostrarform(false);
}

//Funcion listar

function listar() {
    tabla = $('#tblistado')
    .dataTable({
            "aProcessing": true, //Activamos el procesamiento del datatables
            "aServerSide": true, //Paginacion y filtrado realizados por el servidor
            dom: "Bfrtip", //Definimos los elementos del control de tabla
            buttons: [
                'copyHtml5',
                'excelHtml5',
                'csvHtml5',
                'pdf'
                ],
            "ajax": {
                url: '../ajax/reserva.php?op=listar',
                type: "get",
                dataType: "json",
                error: function (e) {
                    console.log(e.responseText);
                    $("#feedback").html(e.responseText)
                }
            },
            "bDestroy": true,
            "iDisplayLength": 10, //Paginacion
            "order": [[1, "desc"]] //Ordenar (Columna, orden)

        })
    .DataTable();
}


//funcion para guardar o editar
function guardaryeditar(e) {
    e.preventDefault(); //No se activará la acción predeterminada del evento
    $("#btnGuardar").prop("disabled", true);
    var formData = new FormData($("#formulario")[0]);
    let [nombre, periodo, desde, hasta, servicios, descripcion] = formData;
    var test = $("input[name*='servicios[]']");
    var services = [];
    $(test).each(function(i, item){
        var service = {
            serviceid: $(item).data('serviceid'),
            quantity: $(item).val()
        }
        services.push(service);
    });
    var servicesArray = { services: services }
    var jsonString = JSON.stringify(servicesArray);
    $.ajax({
        url: "../ajax/reserva.php?op=guardaryeditar",
        type: "POST",
        data: {
            nombre: nombre[1],
            periodo: periodo[1],
            desde: desde[1],
            hasta: hasta[1],
            descripcion: $.trim($("#descripcion").val()),
            servicios: jsonString
    },
    cache: false,
    beforeSend: function( xhr ) {
        console.log(jsonString);
    }, 
    success: function (datos) {
        console.log("Responde metodo php guardar y editar");
        console.log(datos);
            //bootbox.alert(datos);
        
                tabla.ajax.reload();
           // location.reload();
                bootbox.alert({
            message: datos,
            callback: function () {
                location.reload(true); }
                });

            },
            error: function (error) {
        //    bootbox.alert(datos);
            console.log("error: ");
            console.log(error);
        }
    });

        limpiar();
        mostrarform(false)
    //location.reload();
    }


    function mostrar(idreserva) {
        $("#nombre").prop("readonly", true);

        $("#hasta").prop("type", "text"); $("#desde").prop("type", "text");

        $.post(
            "../ajax/reserva.php?op=mostrar",
            { idreserva: idreserva },
            function (data, status) {
                data = JSON.parse(data);
                mostrarform(true);

                $("#idreserva").val(data.idreserva);
                $("#nombre").val(data.nombre);
                $("#desde").val(data.desde);
                $("#hasta").val(data.hasta);
                $("#periodo").val(data.periodo);
                $("#descripcion").val(data.descripcion);
            }
            );
        $.post(
            "../ajax/reserva.php?op=serviciosListed&id=" + idreserva,
            function (data) {
                $("#servicios").html(data);
            }
            )

    }



//funcion para descativar categorias

    function desactivar(idreserva) {
        bootbox.confirm("¿Estas seguro de desactivar la Reserva?", function (result) {
            if (result) {
                $.post(
                    "../ajax/reserva.php?op=desactivar",
                    { idreserva: idreserva },
                    function (e) {
                        bootbox.alert(e);
                        tabla.ajax.reload();

                    }
                    );
            }
        });
    }


    function activar(idreserva) {
        bootbox.confirm("¿Estas seguro de activar la Reserva?", function (result) {
            if (result) {
                $.post(
                    "../ajax/reserva.php?op=activar",
                    { idreserva: idreserva },
                    function (e) {
                        bootbox.alert(e);
                        tabla.ajax.reload();

                    }
                    );
            }
        });
    }


//calendar 



    $(function () {

    /* initialize the external events
    -----------------------------------------------------------------*/
        function ini_events(ele) {
            ele.each(function () {

            // create an Event Object (https://fullcalendar.io/docs/event-object)
            // it doesn't need to have a start or end
                var eventObject = {
                title: $.trim($(this).text()) // use the element's text as the event title
            }

            // store the Event Object in the DOM element so we can get to it later
            $(this).data('eventObject', eventObject)

            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 1070,
                revert: true, // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            })

        })
        }

        ini_events($('#external-events div.external-event'))

    /* initialize the calendar
    -----------------------------------------------------------------*/
    //Date for the calendar events (dummy data)
        var date = new Date()
        var d = date.getDate(),
        m = date.getMonth(),
        y = date.getFullYear()

        var Calendar = FullCalendar.Calendar;
        var Draggable = FullCalendar.Draggable;

        var containerEl = document.getElementById('external-events');
        var checkbox = document.getElementById('drop-remove');
        var calendarEl = document.getElementById('calendar');

    // initialize the external events
    // -----------------------------------------------------------------

        new Draggable(containerEl, {
            itemSelector: '.external-event',
            eventData: function (eventEl) {
                return {
                    title: eventEl.innerText,
                    backgroundColor: window.getComputedStyle(eventEl, null).getPropertyValue('background-color'),
                    borderColor: window.getComputedStyle(eventEl, null).getPropertyValue('background-color'),
                    textColor: window.getComputedStyle(eventEl, null).getPropertyValue('color'),
                };
            }
        });

        var cal = new Array();
        var result;
        $.post(
            "../ajax/reserva.php?op=calendar",
            function (data, status) {
                result = JSON.parse(data);

                result.forEach(Element => {
                    cal.push(
                    {
                        "descripcion": Element.descripcion,
                        "desde": Element.desde,
                        "hasta": Element.hasta,
                        "id": Element.id
                    }

                    );
                });

                var calendar = new Calendar(calendarEl, {

                    locale: 'es',

                    headerToolbar: {
                        left: 'prev,next',
                        center: 'title',
                        right: 'dayGridMonth'
                    },
                    themeSystem: 'bootstrap',
                //Random default events
                    events: function (event, successCallback) {
                        var days = moment(event.end).diff(moment(event.start), 'days')
                        var events = []
                        Object.keys(cal).map(k => {
                            events.push({
                                title: cal[k].descripcion,
                                start: moment(cal[k].desde).format("YYYY-MM-DD HH:mm:ss"),
                                end: moment(cal[k].hasta).format("YYYY-MM-DD HH:mm:ss"),
                                backgroundColor: "rgb(" + getRandomInt(0, 255) + "," + getRandomInt(0, 255) + "," + getRandomInt(0, 255) + ")",
                                borderColor: "rgb(" + getRandomInt(0, 255) + "," + getRandomInt(0, 255) + "," + getRandomInt(0, 255) + ")",
                                'data-id': cal[k].id
                            })
                        })
                        successCallback(events)
                    },
                    editable: true,
                    selectable: true,
                droppable: true, // this allows things to be dropped onto the calendar !!!
                drop: function (info) {
                    // is the "remove after drop" checkbox checked?
                    if (checkbox.checked) {
                        // if so, remove the element from the "Draggable Events" list
                        info.draggedEl.parentNode.removeChild(info.draggedEl);
                    }
                }
            });

                calendar.render();
            // $('#calendar').fullCalendar()

            /* ADDING EVENTS */
            var currColor = '#3c8dbc' //Red by default
            // Color chooser button
            $('#color-chooser > li > a').click(function (e) {
                e.preventDefault()
                // Save color
                currColor = $(this).css('color')
                // Add color effect to button
                $('#add-new-event').css({
                    'background-color': currColor,
                    'border-color': currColor
                })
            })
            $('#add-new-event').click(function (e) {
                e.preventDefault()
                // Get value and make sure it is not null
                var val = $('#new-event').val()
                if (val.length == 0) {
                    return
                }

                // Create events
                var event = $('<div />')
                event.css({
                    'background-color': currColor,
                    'border-color': currColor,
                    'color': '#fff'
                }).addClass('external-event')
                event.text(val)
                $('#external-events').prepend(event)

                // Add draggable funtionality
                ini_events(event)

                // Remove event from text input
                $('#new-event').val('')
            })
        })

    });

//random color calendar
function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}
//end random color calendar 

