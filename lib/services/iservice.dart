abstract class IService<T> {
  T? findOne(int id);
  List<T> findMany();
  bool save(T value);
  bool delete(int id);
}
