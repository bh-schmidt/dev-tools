import { Component, Input, OnChanges, OnInit, SimpleChanges, ViewChildren, QueryList, ElementRef, Output, EventEmitter } from '@angular/core';
import { ChaveValor } from 'app/models/chave-valor';
import { ConfiguracaoAutoComplete, TipoDeBusca, TipoDeComparacao } from './auto-complete-configuration';

const PrimeiroIndexArray = 0;
const TabKeyCode = 9;
const EnterKeyCode = 13;
const ShiftKeyCode = 16;
const CtrlKeyCode = 17;
const AltKeyCode = 18;
const CapsLockKeyCode = 20;
const ArrowLeftKeyCode = 37;
const ArrowUpKeyCode = 38;
const ArrowRightKeyCode = 39;
const ArrowDownKeyCode = 40;

@Component({
    selector: 'app-auto-complete',
    templateUrl: './auto-complete.component.html',
    styleUrls: ['./auto-complete.component.css']
})
export class AutoCompleteComponent implements OnInit, OnChanges {
    @Input() configuracao: ConfiguracaoAutoComplete = {
        tipoDeBusca: TipoDeBusca.BuscaInterna,
        tipoDeComparacao: TipoDeComparacao.Contem
    }
    @Input() itemSelecionado: UpperCaseItem = null;
    @Input() itens: ChaveValor[] = [];
    @Input() placeholder: string = '';
    @Output() onSelect = new EventEmitter<ChaveValor>();
    @Output() onFocus = new EventEmitter();
    @Output() onBlur = new EventEmitter();
    @Output() keyUp = new EventEmitter<string>();
    @ViewChildren('itemElement') itemElements: QueryList<ElementRef>;

    busca: string = '';
    listaVisivel = false;
    indexSelecao: number = null;
    upperCaseItens: UpperCaseItem[] = [];

    constructor() { }

    ngOnInit() {
    }

    ngOnChanges(changes: SimpleChanges): void {
        if (changes['itens']) {
            this.onItensChanges(changes['itens'].currentValue);
        }
    }

    onItensChanges(itens: ChaveValor[]){
        this.convertToUpperCase(itens)

        if(this.configuracao.tipoDeBusca === TipoDeBusca.BuscaInterna){
            this.limparItemSelecionadoCasoInexistente();
        }
    }

    convertToUpperCase(itens: ChaveValor[]){
        if(!itens){
            return
        }

        return new Promise(() => {
            this.upperCaseItens = itens.map(i => {return {description: (i.valor as string).toUpperCase(), item: i}})
        })
    }

    filtrarItens(): UpperCaseItem[] {
        if (!this.itens || !this.upperCaseItens) {
            return []
        }

        if (!this.busca) {
            return this.upperCaseItens
        }

        const busca = this.busca.toUpperCase()

        if(this.configuracao.tipoDeComparacao === TipoDeComparacao.ComecaCom){
            return this.upperCaseItens.filter(p => p.description.startsWith(busca));
        }

        return this.upperCaseItens.filter(p => p.description.includes(busca))
    }

    onComponentFocus() {
        this.exibirLista()
        this.limparItemSelecionadoCasoInexistente()
        this.onFocus.emit()
    }

    onComponentBlur() {
        this.ocultarLista()
        this.limparItemSelecionadoCasoInexistente()
        this.onBlur.emit()
    }

    onSelectItem(item: UpperCaseItem) {
        if (!item) {
            return
        }

        this.itemSelecionado = item
        this.ocultarLista()
        this.onSelect.emit(item.item)
    }

    onKeyDown(event: KeyboardEvent) {
        this.exibirLista()

        if (event.keyCode == ArrowUpKeyCode) {
            event.preventDefault()
            this.aumentarIndexSelecao()
            this.scrollInto()
            return
        }
        if (event.keyCode === ArrowDownKeyCode) {
            event.preventDefault()
            this.diminuirIndexSelecao()
            this.scrollInto()
            return
        }
        if (event.keyCode === EnterKeyCode) {
            this.selecionarItemViaTecla()
            return
        }

        if(!this.deveLimparOItemSelecionado(event.keyCode)){
            return;
        }

        this.limparItemSelecionado();
        this.limparIndexSelecao();
    }

    deveLimparOItemSelecionado(keyCode: number){
        const teclas = [
            TabKeyCode,
            ShiftKeyCode,
            CtrlKeyCode,
            AltKeyCode,
            CapsLockKeyCode,
            ArrowDownKeyCode,
            ArrowUpKeyCode,
            ArrowRightKeyCode,
            ArrowLeftKeyCode
        ]

        return !teclas.some(t => t === keyCode)
    }

    onKeyUp(){
        this.keyUp.emit(this.busca);
    }

    diminuirIndexSelecao() {
        var ultimoIndex = this.obterUltimoIndexDosItensFiltrados();

        if (this.indexSelecao == null || this.indexSelecao == undefined) {
            this.indexSelecao = PrimeiroIndexArray;
            return;
        }

        if (this.indexSelecao === ultimoIndex) {
            this.limparIndexSelecao();
            return;
        }

        this.indexSelecao++;
    }

    aumentarIndexSelecao() {
        var ultimoIndex = this.obterUltimoIndexDosItensFiltrados();

        if (this.indexSelecao == null || this.indexSelecao == undefined) {
            this.indexSelecao = ultimoIndex;
            return;
        }

        if (this.indexSelecao === PrimeiroIndexArray) {
            this.limparIndexSelecao()
            return;
        }

        this.indexSelecao--;
    }

    obterClasseSelecionado(item: UpperCaseItem) {
        const itensFiltrados = this.filtrarItens()

        if (!itensFiltrados) {
            return ''
        }

        const index = itensFiltrados.indexOf(item)

        if (index === this.indexSelecao) {
            return 'selected'
        }

        return ''
    }

    contemItensFiltrados() {
        const itensFiltrados = this.filtrarItens()

        return itensFiltrados && itensFiltrados.length > 0
    }

    private scrollInto(){
        if(this.indexSelecao === null || this.indexSelecao === undefined || !this.itemElements){
            return
        }

        const arrays = this.itemElements.toArray()

        const element = arrays[this.indexSelecao]

        if(!element){
            return
        }

        element.nativeElement.scrollIntoView({behavior: 'auto', block:'center'})
    }

    private limparItemSelecionado() {
        if(this.itemSelecionado){
            this.itemSelecionado = null;
            this.onSelect.emit(null)
        }
    }

    private limparIndexSelecao() {
        this.indexSelecao = null
    }

    private selecionarItemViaTecla() {
        const itensFiltrados = this.filtrarItens()

        if (!itensFiltrados) {
            return
        }

        const itemSelecionado = itensFiltrados[this.indexSelecao]

        if (!itemSelecionado) {
            return
        }

        this.onSelectItem(itemSelecionado)
    }

    private exibirLista() {
        this.listaVisivel = true
    }

    private ocultarLista() {
        this.listaVisivel = false

        this.atualizarBusca()

    }

    private atualizarBusca() {
        if (this.itemSelecionado) {
            this.busca = this.itemSelecionado.item.valor
        }
        else {
            this.busca = ''
        }
    }

    private obterUltimoIndexDosItensFiltrados() {
        const itensFiltrados = this.filtrarItens()

        if (!itensFiltrados) {
            return null
        }

        return itensFiltrados.length - 1
    }

    private contemItemNaLista(upperCaseItem: UpperCaseItem){
        return upperCaseItem && this.upperCaseItens.some(i => i.description === upperCaseItem.description)
    }

    private limparItemSelecionadoCasoInexistente(){
        if(!this.contemItemNaLista(this.itemSelecionado)){
            this.limparItemSelecionado()
            this.atualizarBusca()
        }
    }
}

class UpperCaseItem{
    description: string
    item: ChaveValor
}
