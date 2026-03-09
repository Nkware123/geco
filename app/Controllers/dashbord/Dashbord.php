<?php 
namespace App\Controllers\dashbord;

use App\Controllers\BaseController;
use App\Models\My_Model;
class Dashbord extends BaseController
{
  public function __construct()
  {
    // $this->My_Model = new My_Model();
  }
  public function index()
  {
    $data = $this->urichk();
    $data["data"]=$this->get_data()[0];

    $data2=$this->get_data()[1];
    $agences = array();
    $dem = array();

    foreach ($data2 as $demande)
    {
      $agences[] = $demande->DESC_AGENCE;
      $dem[] = $demande->nbr;
    }
    $data["data3"]=str_replace('"','',json_encode($dem));

    $data["data2"]=json_encode($agences);

    $data["employe"]=$db =\Config\Database::connect()->query("SELECT COUNT(USER_ID) AS NB_EMPLOYE FROM users")->getRow()->NB_EMPLOYE;

    // print_r($data["data3"]." ".$data["data2"]);die();
  	return view("dashbord/Dashbord_view",$data);
  }

  public function get_data($value='')
  {
    $db =\Config\Database::connect();
    $query_demande = $db->query("SELECT * FROM demande_conge JOIN type_conge ON type_conge.ID_TYPE_CONGE =demande_conge.ID_TYPE_CONGE JOIN users ON users.USER_ID=demande_conge.ID_USER ORDER BY ID_DEMANDE DESC");
    $query_demande = $query_demande->getResult();
    
    $query_demande_group = $db->query("SELECT COUNT(ID_DEMANDE) nbr,DESC_AGENCE FROM demande_conge JOIN type_conge ON type_conge.ID_TYPE_CONGE =demande_conge.ID_TYPE_CONGE JOIN users ON users.USER_ID=demande_conge.ID_USER JOIN agence ON agence.ID_AGENCE=users.USER_ID GROUP BY users.ID_AGENCE ORDER BY ID_DEMANDE DESC");
    $query_demande_group = $query_demande_group->getResult();
    return [$query_demande,$query_demande_group];
  }
}

?>