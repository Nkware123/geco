<!DOCTYPE html>
<html lang="en">
<?php echo view('sidebar.php')?>
<body>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Dashboard</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">Home</a></li>
          <li class="breadcrumb-item active">Dashboard</li>
        </ol>
      </nav>
      <div class="col-md-6">
        <select name="filtre" class="form-control" id="filtre">
          <option value="1">Aujourd'hui</option>
          <option value="2">Ce mois</option>
          <option value="3">Cette année</option>
        </select>
      </div>
    </div><!-- End Page Title -->

    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-8">
          <div class="row">

            <!-- Sales Card -->
            <div class="col-xxl-4 col-md-6">
              <div class="card info-card sales-card">
                <div class="card-body">
                  <h5 class="card-title">Demandes <span></span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-cart"></i>
                    </div>
                    <div class="ps-3">
                      <h6 style="float: right;"><?php echo count($data) ?></h6>
                      <!-- <span class="text-success small pt-1 fw-bold">12%</span> <span class="text-muted small pt-2 ps-1">increase</span> -->
                    </div>
                  </div>
                </div>

              </div>
            </div><!-- End Sales Card -->

            <!-- Revenue Card -->
            <div class="col-xxl-4 col-md-6">
              <div class="card info-card revenue-card">
                <div class="card-body">
                  <h5 class="card-title">Revenue <span>| Aujourd'hui</span></h5>

                  <div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                      <i class="bi bi-currency-dollar"></i>
                    </div>
                    <div class="ps-3">
                      <h6>$3,264</h6>
                      <!-- <span class="text-success small pt-1 fw-bold">8%</span> <span class="text-muted small pt-2 ps-1">increase</span> -->

                    </div>
                  </div>
                </div>

              </div>
            </div><!-- End Revenue Card -->            

            <!-- Reports -->
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <h5 class="card-title">Demande par Agence</h5>

                  <!-- Line Chart -->
                  <div id="reportsChart" style="width:100%; height:400px;"></div>

                   <script>
                    // Configuration de base
                    Highcharts.chart('reportsChart', {
                        chart: {
                            type: 'column'  // Type de graphique
                        },
                        title: {
                            text: ''
                        },
                        xAxis: {
                            categories: <?=$data2?>
                        },
                        yAxis: {
                            title: {
                                text: 'Demande'
                            }
                        },
                        series: [{
                            name: 'Agence',
                            data: <?=$data3?>
                        },]
                    });
                </script>
                  <!-- End Line Chart -->

                </div>

              </div>
            </div><!-- End Reports -->       

          </div>
        </div><!-- End Left side columns -->

        <!-- Right side columns -->
        <div class="col-lg-4">

          <!-- Recent Activity -->
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Demande récente</h5>

              <div class="activity">
                <?php 
                // Prendre seulement les 5 premiers éléments
                $limitedData = array_slice($data, 0, 5);
                foreach ($limitedData as $value) {?>
                <div class="activity-item d-flex">
                  <div class="activite-label">32 min</div>
                  <i class='bi bi-circle-fill activity-badge text-success align-self-start'></i>
                  <div class="activity-content">
                    <?=$value->NOM_USER." ".$value->PRENOM_USER?> <a href="#" class="fw-bold text-dark"><?=$value->DESC_TYPE_CONGE?></a>
                  </div>
                </div><!-- End activity item-->
                <?php } ?>
                                

              </div>

            </div>
          </div><!-- End Recent Activity -->         

        </div><!-- End Right side columns -->

      </div>
    </section>

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>Mutec</span></strong>. All Rights Reserved
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>