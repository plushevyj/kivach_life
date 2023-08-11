import 'dart:isolate';

class ConvertTo<R> {
  Future<List<R>> list(List data, builder) async {
    return await Isolate.run(() => data.map<R>((e) => builder(e)).toList());
  }

  Future<R> item(data, builder) async => await Isolate.run(() => builder(data));
}
