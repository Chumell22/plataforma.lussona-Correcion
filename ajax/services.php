<?php
require_once '../modelos/Servicio.php';
$servicios = new Servicio();
switch ($_GET["function"]) {
    case 'servicesAvailable':
        $userid = $_GET["userid"];
        $res = $servicios->pluck();
        $serviceDis = 0;
        $count = 0;
        while ($row = $res->fetch_object()) {
            $servUsed = 0;
            $servicesused = $servicios->getServiceAvailableForUser($userid, $row->id);
            while ($row2 = $servicesused->fetch_assoc()) {
                $servUsed = $row2['serviceused'];
            }
            // ' . $row->id . '
            if (str_contains($row->nombre, "Moto")) {
                $serviceDis = 3;
            } else {
                $serviceDis = 2;
            }
            $serviceResult = $serviceDis - $servUsed;
            $buttons = "";
            $inputCount = "";
            if ($serviceResult!=0) {
                $inputCount = '<input class="disabled input-disabled service-' . $row->id . '" 
                        name="servicios[]" 
                        id="servicios[' . $count . ']"
                        data-serviceid="' . $row->id . '"
                        value="0"/>';
                $buttons = 
                    '<button class="btn btn-sm btn-success button-add-service btn-add-service-' . $row->id . '" 
                        data-serviceid="' . $row->id . '" 
                        data-service-disp="'. $serviceResult .'" 
                        type="button">+</button>
                        <button class="btn btn-sm btn-danger button-remove-service btn-remove-service-' . $row->id . '" 
                        data-serviceid="' . $row->id . '" 
                        type="button" disabled="true">-</button>';
            }
            echo '<tr> 
                    <td>' .$serviceResult. '</td>
                    <td>
                        '.$inputCount.'
                    </td> 
                    <td>' . $row->nombre . '</td>
                    <td>
                    '.$buttons.'
                    </td>
                    </tr>';
            $count++;
        }
        break;
}
?>
