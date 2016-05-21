require 'require_models'


class ManagerData < StransClient

  RAIO_TERRA = 6378.137 #KM

  def load_data
    @linhas = get(:linhas)
    @linha_paradas = {}
    @parada_linhas = {}
    @linhas.each do |l|
      paradas = get(:paradas_linha, l.codigoLinha)
      @linha_paradas[l.codigoLinha] = paradas
      if(!paradas.kind_of?(Erro))
        paradas.each do |p|
          @parada_linhas[p.codigoParada] = [] if @parada_linhas[p.codigoParada].nil?
          @parada_linhas[p.codigoParada] << p.linha
        end
      end
    end
  end

  #pega as paradas com distancia máxima
  # da localização passada.
  def parada_form(long, lat, dist)
    paradas = {}
    get(:paradas).each do |parada|
      if(!parada.long.nil? && !parada.long.nil?)
        dLong = calc_distan(long, parada.long)
        dLat  = calc_distan(lat, parada.lat)

        #mutiplicacao do sen da metade da distancia da Lat;
        msmdl = Math::sin(dLat/2) * Math::sin(dLat/2)
        #mutiplicaçao cos da Latitude * PI
        mclPI = Math::cos(lat * Math::PI / 180) * Math::cos(parada.lat * Math::PI / 180)
        #mutiplicacao da metade do seno
        mmds = Math::sin(dLong/2) * Math::sin(dLong/2)
        a = msmdl + mclPI * mmds

        c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
        d = RAIO_TERRA * c
        dist_parada = d * 1000 # distancia em metros

        #puts dist_parada
        if(dist_parada < dist)
          paradas[d] = parada
        end
      end
    end
    paradas
  end

  def linhas_parada(codigoParada)
    load_data() if @linhas.nil?
    @parada_linhas[codigoParada]
  end

  private

  #Calcula da diferenca entre duas lats ou longs.
  def calc_distan(pos1, pos2)
    (pos1 - pos2) * Math::PI / 180
  end

end
