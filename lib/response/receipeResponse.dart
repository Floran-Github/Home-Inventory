class ReceipeResponse<T> {
  late Status status;
  late String msg;
  late T data;

  ReceipeResponse.loading(this.msg) : status = Status.LOADING;
  ReceipeResponse.completed(this.data) : status = Status.COMPLETED;
  ReceipeResponse.error(this.msg) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $msg \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR}