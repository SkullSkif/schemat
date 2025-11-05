void setup() {
  // Настройка скорости последовательного порта
  UBRR0H = 0;
  UBRR0L = 103; // 9600 бод при 16 МГц
  UCSR0B = (1 << TXEN0); // Включить передачу
  UCSR0C = (1 << UCSZ01) | (1 << UCSZ00); // 8 бит данных

  // Настройка АЦП
  ADMUX = (1 << REFS0); // Опорное напряжение AVcc, канал ADC0 (по умолчанию MUX=0)
  ADCSRA = (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); // Включить АЦП, предделитель 128
}

void loop() {
  // Запуск измерения
  ADCSRA |= (1 << ADSC);
  // Ожидание окончания преобразования
  while (ADCSRA & (1 << ADSC));

  // Чтение результата 10-битного АЦП
  int adcValue = ADC;

  // Вывод значения в терминал в виде строки
  printInt(adcValue);
  printString("\r\n");

  // Задержка около 500 мс
  for (volatile long i = 0; i < 800000; i++);
}

// Вывод целого числа в последовательный порт
void printInt(int number) {
  char buf[6];
  int i = 0, j, k;
  if (number == 0) {
    UDR0 = '0';
    while (!(UCSR0A & (1 << UDRE0)));
    return;
  }
  while (number > 0) {
    buf[i++] = '0' + (number % 10);
    number /= 10;
  }
  for (j = i - 1; j >= 0; j--) {
    UDR0 = buf[j];
    while (!(UCSR0A & (1 << UDRE0)));
  }
}

// Вывод строки в последовательный порт
void printString(const char *s) {
  while (*s) {
    UDR0 = *s++;
    while (!(UCSR0A & (1 << UDRE0)));
  }
}
