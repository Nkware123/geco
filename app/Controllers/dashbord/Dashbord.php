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
    // print_r($data);die();
  	return view("dashbord/Dashbord_view",$data);
  }
}

?>