void setupPWM() {
    // Настройка порта D9 как выход (OC1A)
    DDRB |= (1 << DDB1);  // PB1 = Arduino D9
    
    // Настройка Timer1 для Fast PWM 10-bit
    TCCR1A = (1 << COM1A1) | (1 << WGM11) | (1 << WGM10);  // Non-inverting mode, Fast PWM 10-bit
    TCCR1B = (1 << WGM12) | (1 << CS11);  // Fast PWM 10-bit, prescaler 8
    
    // Установка начального значения ШИМ
    OCR1A = 0;
}

// Настройка АЦП
void setupADC() {
    // Настройка reference voltage = AVcc (5V)
    ADMUX = (1 << REFS0);
    
    // Включение АЦП и установка prescaler = 128 (16MHz/128 = 125kHz)
    //ADCSRA = (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
	ADCSRA = 0xFF;
}

// Настройка UART
void setupUART() {
    // Установка скорости 9600 бод
    UBRR0H = 0;
    UBRR0L = 103;  // Для 16MHz и 9600 бод
    
    // Включение transmitter
    UCSR0B = (1 << TXEN0);
    
    // Формат: 8 data bits, 1 stop bit
    UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);
}

// Функция отправки данных по UART
void UART_send(unsigned char data) {
    // Ожидание пустого буфера передачи
    while (!(UCSR0A & (1 << UDRE0)));
    
    // Отправка данных
    UDR0 = data;
}

// Функция отправки строки по UART
void UART_sendString(char* str) {
    while (*str) {
        UART_send(*str++);
    }
}

// Функция чтения АЦП
unsigned int readADC() {
    // Выбор канала ADC0 (A0) и установка бита начала преобразования
    ADMUX = (ADMUX & 0xF0) | (0 & 0x0F);
    ADCSRA |= (1 << ADSC);
    
    // Ожидание завершения преобразования
    while (ADCSRA & (1 << ADSC));
    
    // Чтение результата
    return ADC;
}

// Функция для преобразования числа в строку
void intToString(unsigned int value, char* buffer) {
    char temp[6];
    int i = 0, j = 0;
    
    // Преобразование числа в строку (обратный порядок)
    do {
        temp[i++] = (value % 10) + '0';
        value /= 10;
    } while (value > 0);
    
    // Разворот строки
    while (i > 0) {
        buffer[j++] = temp[--i];
    }
    buffer[j] = '\0';
}

int main(void) {
    // Настройка всех модулей
    setupPWM();
    setupADC();
    setupUART();
    
    // Переменные для управления ШИМ
    unsigned int pwmValue = 0;
    unsigned int adcValue = 0;
    char buffer[6];
    
    // Бесконечный цикл
    while (1) {
        // Расчет значения ШИМ для напряжения от 1В до 3В
        // При 5V reference и 10-bit ШИМ:
        // 1V = (1/5)*1023 = 205
        // 3V = (3/5)*1023 = 614
        // Плавное изменение от 205 до 614 и обратно
        
        // Увеличиваем значение ШИМ
        for (pwmValue = 205; pwmValue <= 614; pwmValue++) {
            OCR1A = pwmValue;  // Установка значения ШИМ
            
            // Чтение АЦП
            adcValue = readADC();
            
            // Отправка данных по UART
            UART_sendString("ADC: ");
            intToString(adcValue, buffer);
            UART_sendString(buffer);
            UART_sendString(" | PWM: ");
            intToString(pwmValue, buffer);
            UART_sendString(buffer);
            UART_sendString("\r\n");
            
            _delay_ms(10);  // Задержка 10мс
        }
        
        // Уменьшаем значение ШИМ
        for (pwmValue = 614; pwmValue >= 205; pwmValue--) {
            OCR1A = pwmValue;  // Установка значения ШИМ
            
            // Чтение АЦП
            adcValue = readADC();
            
            // Отправка данных по UART
            UART_sendString("ADC: ");
            intToString(adcValue, buffer);
            UART_sendString(buffer);
            UART_sendString(" | PWM: ");
            intToString(pwmValue, buffer);
            UART_sendString(buffer);
            UART_sendString("\r\n");
            
            _delay_ms(10);  // Задержка 10мс
        }
    }
    
    return 0;
}