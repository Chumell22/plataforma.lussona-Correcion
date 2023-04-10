<?php
    require_once 'global.php';

    $conexion = new mysqli(DB_HOST,DB_USERNAME,DB_PASSWORD,DB_NAME);
    
    mysqli_query($conexion,'SET NAMES "'.DB_ENCODE.'"');

    if(mysqli_connect_errno())
    {
        printf("Fallo la conexion a la base de datos: %s\n",mysqli_connect_error());
        exit();
    }

    if(!function_exists('ejecutarConsulta'))
    {
        function select($query) {
            global $conexion;
            $stmt = $conexion->prepare($query);
            $stmt->execute();
            $stmt->store_result();
            $stmt->bind_result($message);
            $res = $stmt->fetch();
            $stmt->close() ;
            return $message;
        }

        function ejecutarConsulta($sql)
        {
            global $conexion;
            $query = $conexion->query($sql);
            return $query;
        }

        function ejecutarConsultaSimpleFila($sql)
        {
            global $conexion;
            $query = $conexion->query($sql);
            $row = $query->fetch_assoc();

            return $row;
        }
        function ejecutarConsultaSimpleFila2($sql)
        {
            global $conexion;
            $query = $conexion->query($sql);
            $row = $query->fetch_object();

            return $row;
        }

        function ejecutarConsulta_retornarID($sql)
        {
            global $conexion;
            $query = $conexion->query($sql);

            return $conexion->insert_id;
        }

        function limpiarCadena($str)
        {
            global $conexion;
            $str = mysqli_real_escape_string($conexion,trim($str));

            return htmlspecialchars($str);
        }
    }
