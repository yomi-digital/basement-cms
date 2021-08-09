<?php
$permission_level = 2;
include('inc/initialize.php');
$internal_route = 'nft';
$subroot = '../';
?>
<!DOCTYPE HTML>
<html>
<?php include('layout/header.php'); ?>

<body>
  <style>
    .fa-spinner {
      animation: spin 1.2s infinite ease-in-out
    }

    @keyframes spin {
      from {
        transform: rotateZ(0);
      }

      to {
        transform: rotateZ(360deg);
      }
    }
  </style>
  <div class="bmt-container" id="nft">
    <?php include('layout/menu.php'); ?>
    <div class="bmt-page-header">
      <a :href="'/bmt/nfts/'+previousPage" style="color:#333"><i class="fa fa-chevron-left"></i></a>
      <span style="margin: 0 10px;">{{nft.title}}</span>
    </div>
    <div class="bmt-page">
      <div class="row">
        <div class="col-xs-12" v-show="appLoading" style="display: flex; flex-direction:row; justify-content:center">
          <div v-show="appLoading"><i class="fa fa-spinner" style="font-size: 30px; margin:100px auto;"></i></div>
        </div>
        <div class="col-xs-12" v-show="!appLoading">
          <div class="pad20">
            <div class="portlet">
              <div class="portlet-body" style="margin: 0 auto;display: flex;justify-content: center;flex-direction: column;">
                <div style="text-align: center; display:flex; flex-direction:column; margin:0 auto 30px auto" class="col-xs-11 col-md-6 col-lg-4">
                  <h2>Transfer NFT</h2>
                  <p style="color:#999">{{nft.title}}</p>
                  <form style="text-align: left;" @submit.prevent="transferNFT()">
                    <div style="margin: 15px 0;">
                      <label>Receiving address</label>
                      <input type="text" class="form-control" placeholder="To... (eg.0x000)" v-model="to">
                    </div>
                    <div style="margin: 15px 0;">
                      <label>Password confirm</label>
                      <input type="password" class="form-control" placeholder="Your password" v-model="password">
                    </div>
                    <button class="btn btn-primary" v-if="!loading" @click="transferNFT()">Trasferisci NFT</button>
                    <div v-show="loading" style="display: contents;"><i class="fa fa-spinner"></i> NFT in trasferimento, si prega di attendere la conferma..</div>
                    <h4 style="float: right;color:darkgreen" v-show="transferSuccess && !loading">NFT transferito con successo <span><i class="fa fa-check"></i></span></h4>
                    <h4 style="float: right;color:darkred" v-show="!transferSuccess && !loading" v-html="transferError"><span><i class="fa fa-times" style="margin-left: 4px;"></i></span></h4>
                  </form>
                </div>
                <div class="col-xs-12 col-md-9" style="margin: auto;">
                  <div style="display:flex; justify-content:space-between;align-items:center">
                    <h3>All NFT info</h3>
                    <a style="height:40px;display:flex;align-items:center" :href="'https://opensea.io/assets/matic/'+nft.contract+'/'+nft.tokenId" class="btn btn-primary" target="_blank">See on OpenSea</a>     
                  </div>
                  <pre>{{nft}}</pre>
                </div>
              </div>
            </div>
          </div>
          <!--content-->
        </div>
        <!--span10-->
      </div>
      <!--row-fluid-->
    </div>
  </div>
  <?php include('layout/footer.php'); ?>
  <script src="https://unpkg.com/vue@next"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js" integrity="sha512-bZS47S7sPOxkjU/4Bt0zrhEtWx0y0CRkhEp8IckzK+ltifIIE9EMIMTuT/mEzoIMewUINruDBIR/jJnbguonqQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script>
    const Nft = {
      data() {
        return {
          nft: {},
          to: '',
          tokenId: -1,
          password: '',
          loading: false,
          transferSuccess: false,
          transferError: '',
          previousPage: localStorage.getItem('page'),
          appLoading: true,
          transferBlock: false
        }
      },
      methods: {
        async transferNFT() {
          if(!this.transferBlock) {
            const app = this
            if (!app.loading) {
              app.loading = true
              app.transferSuccess = false
              let res = await axios.post('<?php echo umi_url; ?>/nfts/transfer', {
                from: "fd1c570050046924e947e7f0e0bd3d373be3690e954c04f6ac7ac4d4fbb348d6",
                tokenId: app.tokenId,
                to: app.to,
                contract: "0x58f44B5f9D7EEd33054B7F184d6C44A6AF6bb88b",
                password: app.password
              })
              if (res.data.error == true) {
                app.transferSuccess = false
                app.transferError = res.data.message
              } else {
                app.transferSuccess = true
              }
              app.loading = false
            }
          }
          else alert("NFT transfer blocked")
        },
      },
      async mounted() {
        let res = await axios.get('<?php echo umi_url; ?>/nfts/<?php echo explode("/bmt/nft/", $_SERVER["REQUEST_URI"])[1]; ?>')
        this.nft = res.data
        this.tokenId = this.nft.tokenId
        this.appLoading = false
        console.log(this.tokenId)
        //Check if is possible to mint
        if(this.tokenId > 0) {
          this.transferBlock = false
        }
        else {
          this.transferBlock = true
        }
      }
    }

    Vue.createApp(Nft).mount('#nft')
  </script>
</body>

</html>