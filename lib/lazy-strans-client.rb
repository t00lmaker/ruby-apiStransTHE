require_relative 'strans-client'

# cliente com alguns servicos facilitadores
class LazyStransClient < StransClient

  RAIO_TERRA = 6378.137 #KM

  # Constroi um cach para informações
  # Estaticas da api.
  def load
    @linhas = get(:linhas)
    return @linhas if @linhas.is_a? Erro
    @paradas_linha = {} # paradas de uma linha
    @linhas_parada = {} # linhas de uma parada
    @linhas.each do |l|
      paradas = get(:paradas_linha, l.codigoLinha)
      next if paradas.is_a? ErroStrans
      @paradas_linha[l.codigoLinha] = paradas
      paradas.each do |p|
      @linhas_parada[p.codigoParada] = [] unless @linhas_parada.key?(p.codigoParada)
      @linhas_parada[p.codigoParada] << p.linha
      end
    end
    @linhas_parada
  end

  #pega as paradas com distancia máxima
  # da localização passada.
  def paradas_proximas(long, lat, dist)
    long = long.to_f
    lat  = lat.to_f
    dist = dist.to_f
    paradas = []
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

        if(dist_parada < dist)
          parada.dist = dist_parada # metros
          paradas << parada
        end
      end
    end
    paradas
  end

  # Retrona todas as linhas de uma parada.
  def linhas_parada(codigoParada)
    codigoParada = codigoParada.to_i
    load() if @linhas.nil?
    @linhas_parada[codigoParada]
  end

  private

  # Calcula da diferenca entre duas lats ou longs.
  def calc_distan(pos1, pos2)
    (pos1 - pos2) * Math::PI / 180
  end

end
