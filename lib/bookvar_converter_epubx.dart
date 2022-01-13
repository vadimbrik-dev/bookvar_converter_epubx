library bookvar_converter_epubx;

import 'package:bookvar/bookvar.dart';
import 'package:epubx/epubx.dart';

Future<Book> convertEpubToBook(EpubBook epubBook) async {
  final images = _loadImages(epubBook);

  return epubBook.Chapters!
      .map((chapter) => parse(chapter.HtmlContent!, images))
      .toList();
}

List<ImageRecord> _loadImages(EpubBook epubBook) {
  if (epubBook.Content?.Images == null) {
    return [];
  }

  final images = epubBook.Content!.Images!.values;
  return images.map(_EpubToImageRecord.convert).toList();
}

extension _EpubToImageRecord on ImageRecord {
  static ImageRecord convert(EpubByteContentFile file) =>
      ImageRecord(buffer: file.Content ?? [], filename: file.FileName ?? '');
}
