<?php 
namespace App\Controllers\demande;
use App\Controllers\BaseController;
use App\Models\My_Model;

class demande extends BaseController
{
    public function __construct()
    {
        $this->My_Model = new My_Model();
    }
    public function index() 
    {
        $data = $this->urichk();
        $db =\Config\Database::connect();
        $query_type_conge = $db->query("SELECT * FROM type_conge WHERE EST_ACTIVE=1");
        $data['type_conge'] = $query_type_conge->getResult();
        return view('demande\formulaire_demande_conge',$data);
    }

    public function liste()
    {
        $data = $this->urichk();
        $db =\Config\Database::connect();
        $query = $db->query("SELECT * FROM demande_conge as demande join users ON users.USER_ID=demande.ID_USER join type_conge typ ON typ.ID_TYPE_CONGE=demande.ID_TYPE_CONGE join etape_validation etap on etap.ID_ETAPE_VALIDATION=demande.ID_ETAPE_VALIDATION WHERE demande.ID_ETAPE_VALIDATION IN (SELECT etape_fonction.ID_ETAPE_VALIDATION FROM etape_fonction WHERE etape_fonction.ID_FONCTION=".session()->get('function_id').")");
        $data['donnees'] = $query->getResult();

        $type_decision = $db->query("SELECT * FROM type_decision");
        $data['type_decision'] = $type_decision->getResult();

        return view("App\Views\demande\demande_list",$data);
    }

    public function save_demande()
    {
        $ID_USER=session()->get('user_id');
        $ID_TYPE_CONGE=$this->request->getPost('ID_TYPE_CONGE');
        $DATE_DEBUT=$this->request->getPost('DATE_DEBUT');
        $DATE_FIN=$this->request->getPost('DATE_FIN');

        $table='demande_conge';
        $datacolumsinsert = array('ID_USER' => $ID_USER,'ID_TYPE_CONGE'=>$ID_TYPE_CONGE,'ID_ETAPE_VALIDATION' => 3,'DATE_DEBUT'=>$DATE_DEBUT,'DATE_FIN'=>$DATE_FIN);
        $ID_DEMANDE=$this->save($table,$datacolumsinsert); 

        //insertion dans historique
        $table='historique_demande';
        $datacolumsinsert = array('ID_DEMANDE'=>$ID_DEMANDE,'ID_USER'=>$ID_USER,'ID_ETAPE_VALIDATION' => 1);
        $this->save($table,$datacolumsinsert);

        return redirect('demande/liste');        
    }

    public function view_update($ID_DEMANDE) 
    {
        $data = $this->urichk();
        $db =\Config\Database::connect();
        $query = $db->query("SELECT * FROM demande_conge as demande join users ON users.USER_ID=demande.ID_USER join type_conge type ON type.ID_TYPE_CONGE=demande.ID_TYPE_CONGE where ID_DEMANDE=".$ID_DEMANDE);
        $data['donnees'] = $query->getRow();

        $query_type_conge = $db->query("SELECT * FROM type_conge");
        $data['type_conge'] = $query_type_conge->getResult();
        return view('demande\correction_demande',$data);
    }

    public function update_demande()
    {
        $ID_USER=session()->get('user_id');
        $ID_DEMANDE=$this->request->getPost('ID_DEMANDE');
        $ID_TYPE_CONGE=$this->request->getPost('ID_TYPE_CONGE');
        $DATE_DEBUT=$this->request->getPost('DATE_DEBUT');
        $DATE_FIN=$this->request->getPost('DATE_FIN');

        $table='demande_conge';
        $condition=array('ID_DEMANDE'=>$ID_DEMANDE);
        $datacolumsinsert = array('ID_USER' => $ID_USER,'ID_TYPE_CONGE'=>$ID_TYPE_CONGE,'ID_ETAPE_VALIDATION' => 3,'DATE_DEBUT'=>$DATE_DEBUT,'DATE_FIN'=>$DATE_FIN);
        $this->update($table,$condition,$datacolumsinsert);

        //insertion dans historique
        $table='historique_demande';
        $datacolumsinsert = array('ID_DEMANDE'=>$ID_DEMANDE,'ID_USER'=>$ID_USER,'ID_ETAPE_VALIDATION' => 2);
        $this->save($table,$datacolumsinsert); 

        return redirect('demande/liste');
    }

    public function decision()
    {
        $ID_DEMANDE=$this->request->getPost('ID_DEMANDE');
        $OBSERVATION=$this->request->getPost('OBSERVATION');
        $ID_USER=session()->get('user_id');
        $ID_TYPE_DECISION=$this->request->getPost('ID_TYPE_DECISION');
        $ID_ETAPE_VALIDATION=$this->request->getPost('ID_ETAPE_VALIDATION');

        $db =\Config\Database::connect();
        $query = $db->query("SELECT ID_ETAPE_SUIVANT FROM etape_validation where ID_ETAPE_VALIDATION=".$ID_ETAPE_VALIDATION);
        $type_conge = $query->getRow();

        if($ID_TYPE_DECISION==2)
        {
            $ID_ETAPE_VALIDATION=0;
        }
        elseif($ID_TYPE_DECISION==3)
        {
            $ID_ETAPE_VALIDATION=2;
        }
        else
        {
            $ID_ETAPE_VALIDATION=$type_conge->ID_ETAPE_SUIVANT;
        }

        $table='demande_conge';
        $condition=array('ID_DEMANDE'=>$ID_DEMANDE);
        $datacolumsinsert = array('ID_ETAPE_VALIDATION' => $ID_ETAPE_VALIDATION);
        $this->update($table,$condition,$datacolumsinsert);

        //insertion dans historique
        $table='historique_demande';
        $datacolumsinsert = array('ID_DEMANDE'=>$ID_DEMANDE,'OBSERVATION'=>$OBSERVATION,'ID_USER'=>$ID_USER,'ID_ETAPE_VALIDATION' => 2);
        $this->save($table,$datacolumsinsert);

        return redirect('demande/liste');
    }
}