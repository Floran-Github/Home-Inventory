
class InventoryRepsonse<T> {
  late Status status;
  late String msg;
  late T data;

  InventoryRepsonse.loading(this.msg) : status = Status.LOADING;
  InventoryRepsonse.completed(this.data) : status = Status.COMPLETED;
  InventoryRepsonse.error(this.msg) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $msg \n Data : $data";
  }
}
enum Status { LOADING, COMPLETED, ERROR }
