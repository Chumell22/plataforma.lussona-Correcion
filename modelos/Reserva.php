<?php
require '../config/conexion.php';
if (!isset($_SESSION['idusuario'])) session_start();
class Reserva
{
    public function __construct()
    {
    }

    public function insertar($idusuario, $periodo, $desde, $hasta, $descripcion, $servicios)
    {
        //$idusuario = $_SESSION['idusuario'];
        //$sql = "INSERT INTO schedule_list (reserved_by, schedule_remarks, datetime_start, datetime_end, periodo,status) 
        //            VALUES ('$idusuario', '$descripcion', '$desde', '$hasta', '$periodo', 1)";
        $idreservanew = 85;//ejecutarConsulta_retornarID($sql);
        // var_dump($idreservanew);
        $num_elementos = 0;
        $sw = true;
        // var_dump($servicios);
        


        
        while ($num_elementos < count($servicios)) {


            for ($i=0; $i < $servicios[$num_elementos]->quantity; $i++) {
                $serviceid = $servicios[$num_elementos]->serviceid;
                $sql_detalle = "INSERT INTO servicio_reserva (
                                        servicio_id,
                                        reserva_id
                                    )
                                    VALUES (
                                        '$serviceid',
                                        '$idreservanew'
                                    )";
            }
            ejecutarConsulta($sql_detalle) or $sw = false;

            $num_elementos = $num_elementos + 1;
        }

        return $sw;
    }

    public function validation($idusuario, $desde)
    {
        $sql = "CALL ValidateReservesForYear($idusuario, '$desde');";
        $response = select($sql);
        return $response;
    }

    public function editar($idreserva, $idusuario, $periodo, $desde, $hasta, $descripcion, $servicios)
    {
        // $idusuario = $_SESSION['idusuario'];
        $sql = "UPDATE schedule_list SET reserved_by='$idusuario', periodo = '$periodo', schedule_remarks = '$descripcion', datetime_start ='$desde', datetime_end = '$hasta'
                    WHERE id='$idreserva'";

        ejecutarConsulta($sql);
        $sqldel = "DELETE FROM servicio_reserva
                        WHERE reserva_id='$idreserva'";

        ejecutarConsulta($sqldel);
        $num_elementos = 0;
        $sw = true;

        while ($num_elementos < count($servicios)) {
            $sql_detalle = "INSERT INTO servicio_reserva (
                                    servicio_id,
                                    reserva_id
                                )
                                VALUES (
                                    '$servicios[$num_elementos]',
                                    '$idreserva'
                                )";

            ejecutarConsulta($sql_detalle) or $sw = false;

            $num_elementos = $num_elementos + 1;
        }

        return $sw;
    }

    //METODOS PARA ACTIVAR CATEGORIAS
    public function desactivar($idreserva)
    {
        $sql = "UPDATE schedule_list SET status='0' 
                    WHERE id='$idreserva'";

        return ejecutarConsulta($sql);
    }

    public function activar($idreserva)
    {
        $sql = "UPDATE schedule_list SET status='1' 
                    WHERE id='$idreserva'";

        return ejecutarConsulta($sql);
    }

    //METODO PARA MOSTRAR LOS DATOS DE UN REGISTRO A MODIFICAR
    public function mostrar($idreserva)
    {
        $sql = "SELECT  id as idreserva,
                            reserved_by as nombre,
                            schedule_remarks as descripcion,
                            datetime_start as desde,
                            datetime_end as hasta,
                            periodo,
                            costo,
                            status as condicion,
                            date_created as reg_date,
                            date_updated as upd_date
                    FROM schedule_list 
                    WHERE id='$idreserva'";

        return ejecutarConsultaSimpleFila($sql);
    }
    public function mostrar2($idreserva)
    {
        $sql = "SELECT  id as idreserva,
                            reserved_by as nombre,
                            schedule_remarks as descripcion,
                            datetime_start as desde,
                            datetime_end as hasta,
                            periodo,
                            costo,
                            status as condicion,
                            date_created as reg_date,
                            date_updated as upd_date
                    FROM schedule_list 
                    WHERE id='$idreserva'";

        return ejecutarConsultaSimpleFila2($sql);
    }

    //METODO PARA LISTAR LOS REGISTROS
    public function listar()
    {
        $sql = "SELECT s.`id`, d.room_name as Departamento_Nombre, u.nombre as Reservado_Por, s.`datetime_start` as Fecha_De_Inicio, s.`datetime_end` as Fecha_Fin, s.`status` FROM `schedule_list` as s JOIN usuario as u on u.idusuario = s.reserved_by JOIN departamentos as d on d.usuario_id = u.idusuario WHERE s.reserved_by =" . $_SESSION['idusuario'] . " AND s.status = 1";

        return ejecutarConsulta($sql);
    }


    
    public function listarTodo()
    {
        $sql = "SELECT d.room_name as Departamento_Nombre, schedule_remarks as descripcion,  u.nombre as Reservado_Por, s.`datetime_start` as Fecha_De_Inicio, s.`datetime_end` as Fecha_Fin, s.`status` FROM `schedule_list` as s JOIN usuario as u on u.idusuario = s.reserved_by JOIN departamentos as d on d.usuario_id = u.idusuario


        
WHERE s.reserved_by";

        return ejecutarConsulta($sql);
    }
    //METODO PARA LISTAR LOS REGISTROS Y MOSTRAR EN EL SELECT
    public function select()
    {
        $sql = "SELECT id as idreserva,
                            reserved_by as nombre,
                            schedule_remarks as descripcion,
                            datetime_start as desde,
                            datetime_end as hasta,
                            periodo,
                            costo,
                            status as condicion,
                            date_created as reg_date,
                            date_updated as upd_date
                    FROM schedule_list 
                    WHERE status = 1";

        return ejecutarConsulta($sql);
    }

    public function SelectSala()
    {
        $sql = "SELECT id as idsala, room_name as nombre
                    FROM departamentos 
                    WHERE 
                        status = 1
                    AND
                        reservado = 0";

        return ejecutarConsulta($sql);
    }

    public function SelectedSala()
    {
        $sql = "SELECT id as idsala, room_name as nombre
                    FROM departamentos 
                    WHERE 
                        status = 1";

        return ejecutarConsulta($sql);
    }

    //Guardar Servicio

    public function GuardarServicioReserva($reserva_id, $servicio_id)
    {
    $sql = "INSERT INTO servicio_reserva (
        reserva_id,
        servicio_id
        ) VALUES (
        '$reserva_id',
        '$servicio_id'
        )";
    return ejecutarConsulta($sql);
    }
    
    //Guardar Reserva
    public function GuardarReserva($reserved_by, $schedule_remarks, $datetime_start, $datetime_end, $periodo)
    {
        $sql = "INSERT INTO schedule_list (reserved_by, schedule_remarks, datetime_start, datetime_end, periodo, status) 
            VALUES ('$reserved_by', '$schedule_remarks', '$datetime_start', '$datetime_end', '$periodo', 1)";
            
        //ejecutarConsulta($sql);
        $reserveid = ejecutarConsulta_retornarID($sql);
        return $reserveid;
    }


    public function calendar()
    {
        $ID = $_SESSION['idusuario'];

        $sql = "SELECT 'Reservado' as descripcion, sl.datetime_start as desde, sl.datetime_end as hasta, sl.id, sl.reserved_by, dp.room_name FROM schedule_list sl INNER JOIN departamentos dp on sl.reserved_by = dp.usuario_id WHERE dp.room_name = (select room_name from departamentos WHERE usuario_id =  $ID )";
        // ;


        return ejecutarConsulta($sql);
    }


    public function getDates()
    {
        $ID = $_SESSION['idusuario'];

        $sql = "SELECT DATE_FORMAT(cast( datetime_start as DATE), '%Y/%m/%d') as fecha FROM schedule_list sl";
        // ;
        return ejecutarConsulta($sql);
    }

    public function reservafecha($desde, $hasta, $idsala)
    
    {
        $sql = "SELECT 
            DATE(v.datetime_start) as desde,
            DATE(v.datetime_end) as hasta,
            v.reserved_by as dueño,
            p.nombre as sala,
            v.costo,
            v.periodo,
            v.schedule_remarks as descripcion,
            v.status as estado                        
        FROM
            schedule_list v
        INNER JOIN departamento p
        ON v.departamento_id = p.id                    
        WHERE 
            DATE(v.datetime_start) >= '$desde'
        AND
            DATE(v.datetime_end) <= '$hasta'
        AND
            v.departamento_id = '$idsala'";

        return ejecutarConsulta($sql);
    }
}
