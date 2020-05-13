import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { BaseComponent } from 'app/shared/base-component';
import { ToastrService } from 'toastr-ng2';
import { Arquivo } from 'app/models/shared/arquivo';
import { ParametroSistemaService } from 'app/shared/services/shared/parametro-sistema.service';
import { ParametroSistema } from 'app/models/shared/parametro-sistema';
import { LoaderService } from 'app/shared/loader/loader.service';
import { TAMANHO_MAXIMO_ARQUIVO } from 'app/shared/const/parametros';
import { FileUtils } from 'app/shared/utils/fileutils';

@Component({
    selector: 'app-upload-arquivos',
    templateUrl: './upload-arquivos.component.html',
    styleUrls: ['./upload-arquivos.component.css']
})
export class UploadArquivosComponent extends BaseComponent implements OnInit {
    @Input() nome: string;
    @Input() arquivosPermitidos: string[] = [
        'xlsx',
        'xls',
        'doc',
        'docx',
        'pdv',
        'csv',
        'txt',
        'xml',
        'json'
    ];
    @Output() onArquivoChanges: EventEmitter<Arquivo[]> = new EventEmitter<Arquivo[]>();


    file: File;
    arquivos: Arquivo[] = [];
    parametroTamanhoArquivo: ParametroSistema;

    constructor(
        toastrService: ToastrService,
        protected loader: LoaderService,
        private parametroSistemaService: ParametroSistemaService) {
        super(toastrService, loader);
    }

    ngOnInit() {
        this.buscarParametroTamanhoArquivo();
    }

    buscarParametroTamanhoArquivo() {
        this.loader.queue('carregaParametro');
        this.parametroSistemaService.buscarParametro(TAMANHO_MAXIMO_ARQUIVO)
            .then(res => {
                this.parametroTamanhoArquivo = res;
                this.loader.dequeue('carregaParametro');
            })
            .catch(err => {
                console.log(err);
                super.exibeMensagemErro('Um erro ocorreu no servidor.');
                this.loader.dequeue('carregaParametro');
            });
    }

    onUploadFile(evt) {
        this.file = null;
        const files = evt.target.files;
        const file = files[0];

        if (this.validarArquivo(file)) {
            const arquivo = new Arquivo();
            arquivo.nomeArquivo = FileUtils.getName(file.name);
            arquivo.extensao = FileUtils.getExtension(file.name);

            this.fileToByteArray(file, arquivo);
        }
    }

    validarArquivo(file: File) {
        if (!file) {
            this.toastrService.error('O arquivo está vazio!');
            return false;
        } else if (FileUtils.getName(file.name).length > 50) {
            this.toastrService.error('O nome do arquivo excede o tamanho máximo de 50 caracteres!');
            return false;
        } else if (!this.arquivosPermitidos.some(x => x === FileUtils.getExtension(file.name))) {
            this.toastrService.error(`Este tipo de arquivo não é permitido.`);
            return false;
        } else if (file.size > Number(this.parametroTamanhoArquivo.valor)) {
            this.toastrService.error(`O tamanho do arquivo é muito grande.`);
            return false;
        }

        return true;
    }

    downloadArquivo(arquivo: Arquivo) {
        const blob = this.convertBase64String(arquivo.fileEncoded);
        saveAs(blob, `${arquivo.nomeArquivo}.${arquivo.extensao}`);
        this.onArquivoChanges.emit(this.arquivos);
    }

    excluirArquivo(anexo: Arquivo) {
        const index = this.arquivos.indexOf(anexo);
        if (index >= 0) {
            this.arquivos.splice(index, 1);
        }
        this.onArquivoChanges.emit(this.arquivos);
    }

    private fileToByteArray(file: File, arquivo: Arquivo) {
        const scope = this;
        const reader = new FileReader();

        reader.onload = _handleReaderLoaded.bind(this);
        reader.readAsDataURL(file);

        function _handleReaderLoaded(e) {
            let result = e.target.result;

            if (result.indexOf('base64') !== -1) {
                result = result.split('base64,')[1];
            }

            arquivo.fileEncoded = result;

            if (!scope.arquivos.some(x => x.fileEncoded === arquivo.fileEncoded)) {
                scope.arquivos.push(arquivo);
                scope.onArquivoChanges.emit(scope.arquivos);
            }
        }

    }

    private convertBase64String(b64Data: string): Blob {

        const byteCharacters = atob(b64Data);
        const byteNumbers = new Array(byteCharacters.length);
        for (let i = 0; i < byteCharacters.length; i++) {
            byteNumbers[i] = byteCharacters.charCodeAt(i);
        }

        const byteArray = new Uint8Array(byteNumbers);

        const blob = new Blob([byteArray]);

        return blob;
    }
}
