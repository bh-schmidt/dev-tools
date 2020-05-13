export class ConfiguracaoAutoComplete{
    tipoDeBusca: TipoDeBusca
    tipoDeComparacao: TipoDeComparacao
}

export enum TipoDeBusca{
    BuscaInterna = 1,
    BuscaExterna = 2
}

export enum TipoDeComparacao{
    Contem = 1,
    ComecaCom = 2
}