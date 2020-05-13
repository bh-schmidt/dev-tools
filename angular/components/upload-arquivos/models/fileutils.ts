export class FileUtils {
    static getName(fileName: string) {
        if (fileName && fileName.match(/[.]/))
            return fileName.substr(0, fileName.lastIndexOf('.'))
        if (fileName)
            return fileName.substr(0, fileName.length)
        else
            return null;
    }

    static getExtension(fileName: string) {
        if (fileName && fileName.match(/[.]/))
            return fileName.substr(fileName.lastIndexOf('.') + 1, fileName.length)
        else
            return null;
    }
}