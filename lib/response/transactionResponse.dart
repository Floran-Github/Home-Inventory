class TransactionResponse<T> {
  late Status status;
  late T data;
  late String msg;

  TransactionResponse.loading(this.msg) : status = Status.LOADING;
  TransactionResponse.completed(this.data) : status = Status.COMPLETED;
  TransactionResponse.error(this.msg) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $msg \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
