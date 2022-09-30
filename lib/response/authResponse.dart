class AuthRepsonse<T> {
  late Status status;
  late T data;
  late String msg;

  AuthRepsonse.loading(this.msg) : status = Status.LOADING;
  AuthRepsonse.completed(this.data) : status = Status.COMPLETED;
  AuthRepsonse.error(this.msg) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $msg \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
