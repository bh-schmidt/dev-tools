import { Component, OnInit, Input } from '@angular/core';
import { Arquivo } from 'app/models/shared/arquivo';
import { ArquivoService } from 'app/shared/services/arquivo.service';
import { BaseComponent } from 'app/shared/base-component';
import { ToastrService } from 'toastr-ng2';
import { LoaderService } from 'app/shared/loader/loader.service';

@Component({
    selector: 'app-download-arquivos',
    templateUrl: './download-arquivos.component.html',
    styleUrls: ['./download-arquivos.component.css']
})
export class DownloadArquivosComponent extends BaseComponent implements OnInit {
    @Input() nome: string;
    @Input() arquivos: Arquivo[];

    constructor(
        private arquivoService: ArquivoService,
        toastr: ToastrService,
        loader: LoaderService
    ) {
        super(toastr, loader);
    }

    ngOnInit() {
    }

    downloadArquivo(arquivo: Arquivo) {
        this.loader.queue('downloadArquivo');
        this.arquivoService.obterArquivo(arquivo.guidArquivo)
            .then(res => {
                let nomeArquivo = arquivo.nomeArquivo;
                if (arquivo.extensao) {
                    nomeArquivo += '.' + arquivo.extensao;
                }

                this.downloadFile(res, nomeArquivo);
                this.loader.dequeue('downloadArquivo');
            })
            .catch(err => {
                console.log(err);
                super.exibeMensagemErro('Um erro ocorreu.');
                this.loader.dequeue('downloadArquivo');
            });
    }

    private downloadFile(arquivo: Arquivo, nomeArquivo: string) {
        const conteudo = atob(arquivo.fileBytes);
        const arraybuffer = new ArrayBuffer(conteudo.length);
        const view = new Uint8Array(arraybuffer);
        for (let i = 0; i < conteudo.length; i++) {
            view[i] = conteudo.charCodeAt(i) & 0xff;
        }
        const blob = new Blob([arraybuffer], { type: arquivo.extensao });
        saveAs(blob, nomeArquivo);
    }
}
