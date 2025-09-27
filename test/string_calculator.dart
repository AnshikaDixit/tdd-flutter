class StringCalculator{
  int add(String numbers){
    if(numbers.isEmpty){
      return 0;
    }
    return numbers.split(',').map(int.parse).reduce((a, b) => a + b);
  }
}

void main(){
  StringCalculator calculator = StringCalculator();
  print(calculator.add(""));
  print(calculator.add("1"));
  print(calculator.add("1,2"));
}