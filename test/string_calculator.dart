class StringCalculator{
  int add(String numbers){
    if(numbers.isEmpty){
      return 0;
    }

   String delimiterPattern = r'[,\n]'; 

  // Check if a delimiter is defined at the start of the string
  if (numbers.startsWith('//')) {
    int newlineIndex = numbers.indexOf('\n');
    if (newlineIndex != -1) {
      String customDelimiter = numbers.substring(2, newlineIndex);
      delimiterPattern = RegExp.escape(customDelimiter); // escape for regex
      numbers = numbers.substring(newlineIndex + 1);     // remove delimiter line
    }
  }


    return 
     numbers.split(RegExp(delimiterPattern))
     .map(int.parse).reduce((a, b) => a + b);
  }
}

void main(){
  StringCalculator calculator = StringCalculator();
  print(calculator.add(""));
  print(calculator.add("1"));
  print(calculator.add("1,2,345,346456457,758678,789890890,23423434,6787979,9809809,45,23,2323,2443,43,45,2,1,324,5,5676,8787,989,8988876765,544545,55,46565,565676763434,33232,323232,3232323"));
  print(calculator.add("1\n2,3"));
  print(calculator.add("//;\n1;2;"));
}