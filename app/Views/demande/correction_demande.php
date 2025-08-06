<!DOCTYPE html>
<html lang="en">
<body>
<?php echo view('sidebar.php');?>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Demande</h1>      
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Correction du formulaire de demande de congé</h5>
              <form id="MyForm" action="<?=base_url('demande/update_demande')?>" enctype='multipart/form-data' method='POST'>
                <input type="hidden" name="ID_DEMANDE" value="<?=$donnees->ID_DEMANDE?>">
                <div class="row">
                  <div class="col-md-6">
                    <label>Type de congé</label><font color="red">*</font>
                    <select name="ID_TYPE_CONGE" id="ID_TYPE_CONGE" class="form-control">
                      <option value="">Sélectionner</option>
                      <?php
                        foreach ($type_conge as $key)
                        {
                          if($donnees->ID_TYPE_CONGE==$key->ID_TYPE_CONGE)
                          {
                            echo '<option value='.$key->ID_TYPE_CONGE.' selected>'.$key->DESC_TYPE_CONGE.'</option>';
                          }
                          else
                          {
                            echo '<option value='.$key->ID_TYPE_CONGE.'>'.$key->DESC_TYPE_CONGE.'</option>';
                          }
                        }
                      ?>
                    </select>
                    <font id="error_ID_TYPE_CONGE" color="red"></font>
                    <br>
                  </div>
                  <div class="col-md-6">
                    <label>Date début</label><font color="red">*</font>
                    <input type="date" min="<?=date('Y-m-d')?>" name="DATE_DEBUT" id="DATE_DEBUT" class="form-control" value="<?=date('d-m-Y',strtotime($donnees->DATE_DEBUT))?>?>">
                    <font id="error_DATE_DEBUT" color="red"></font>
                    <br>
                  </div>
                  <div class="col-md-6">
                    <label>Date fin</label><font color="red">*</font>
                    <input type="date" min="<?=date('Y-m-d')?>" name="DATE_FIN" id="DATE_FIN" class="form-control" value="<?=date('d-m-Y',strtotime($donnees->DATE_FIN))?>">
                    <font id="error_DATE_FIN" color="red"></font>
                    <br>
                  </div>
                </div>
              </form>
              <button style="float:right;" id="btnsave" class="btn btn-primary" onclick="save()">Modifier</button>             
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</body>
</html>
<script>
  function save()
  {
    var statut = 1;
    $('#error_DATE_FIN').text('')
    $('#error_ID_TYPE_CONGE').text('')
    $('#error_DATE_DEBUT').text('')
    if($('#DATE_FIN').val()=='')
    {
      statut = 2;
      $('#error_DATE_FIN').text('Ce champ est obligatoire')
    }

    if($('#ID_TYPE_CONGE').val()=='')
    {
      statut = 2;
      $('#error_ID_TYPE_CONGE').text('Ce champ est obligatoire')
    }

    if($('#DATE_DEBUT').val()=='')
    {
      statut = 2;
      $('#error_DATE_DEBUT').text('Ce champ est obligatoire')
    }

    if(statut == 1)
    {
      $('#MyForm').submit();
    }
  }
</script>