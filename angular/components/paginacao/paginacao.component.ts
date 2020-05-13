import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { DadosPaginacao } from './models/dados-paginacao';

@Component({
    selector: 'app-paginacao',
    templateUrl: './paginacao.component.html',
    styleUrls: ['./paginacao.component.css']
})
export class PaginacaoComponent implements OnInit {
    @Input() totalRegistros = 0;
    @Input() registrosPorPagina = 30;
    @Input() numeroDeIcones = 7;
    @Input() paginaAtual = 1;
    @Output() onPaginacaoChanges = new EventEmitter<DadosPaginacao>();

    numeroPaginas = 1;
    paginasAnteriores = [];
    paginasPosteriores = [];

    listaRegistrosPorPagina: number[];

    constructor() { }

    ngOnInit() {
    }

    ngOnChanges(changes) {
        if (changes.totalRegistros || changes.registrosPorPagina) {
            this.atualizarNumeroPaginas();
            this.atualizarListaPaginas();
        }
        if (changes.registrosPorPagina) {
            this.prepararArrayRegistrosPorPagina();
        }

        this.atualizarListaPaginas();
    }

    prepararArrayRegistrosPorPagina() {
        const defaultValues = [10, 20, 30, 50, 100];
        this.listaRegistrosPorPagina = defaultValues;
        if (!defaultValues.some(x => x === this.registrosPorPagina)) {
            this.listaRegistrosPorPagina.push(this.registrosPorPagina);
            this.listaRegistrosPorPagina = this.listaRegistrosPorPagina.sort(function (a, b) { return a - b; });
        }
    }

    atualizarNumeroPaginas() {
        this.numeroPaginas = Math.floor(this.totalRegistros / this.registrosPorPagina);

        if ((this.totalRegistros % this.registrosPorPagina) !== 0) {
            this.numeroPaginas += 1;
            this.numeroPaginas = this.numeroPaginas;
        }
    }

    atualizarListaPaginas() {
        this.paginasAnteriores = [];
        this.paginasPosteriores = [];
        const paginas: number[] = [];
        const quantidadeIcones = Math.floor(this.numeroDeIcones / 2);
        for (let i = 0; i < this.numeroPaginas; i++) {
            paginas.push(i + 1);
        }

        const index = paginas.indexOf(this.paginaAtual);
        if (index !== -1) {
            const start = (index - quantidadeIcones) < 0 ? 0 : (index - quantidadeIcones);

            this.paginasAnteriores = paginas.slice(start, index);
            this.paginasPosteriores = paginas.slice(index + 1, index + quantidadeIcones + 1);
        }
    }

    selecionarPagina(pagina: number) {
        this.paginaAtual = pagina;
        this.atualizarListaPaginas();
        this.emit();
    }

    irParaPaginaAnterior() {
        if (this.paginaAtual > 1) {
            this.paginaAtual -= 1;
        }
        this.atualizarListaPaginas();
        this.emit();
    }

    irParaPaginaPosterior() {
        if (this.paginaAtual < this.numeroPaginas) {
            this.paginaAtual += 1;
        }
        this.atualizarListaPaginas();
        this.emit();
    }

    irParaPrimeiraPagina() {
        this.paginaAtual = 1;
        this.atualizarListaPaginas();
        this.emit();
    }

    irParaUltimaPagina() {
        this.paginaAtual = this.numeroPaginas;
        this.atualizarListaPaginas();
        this.emit();
    }

    selecionarRegistrosPorPagina() {
        this.atualizarNumeroPaginas();
        this.irParaPrimeiraPagina();
    }

    emit() {
        this.onPaginacaoChanges.emit(
            {
                paginaAtual: this.paginaAtual,
                registrosPorPagina: this.registrosPorPagina
            });

    }
}
