
# Unit Testing in Ruby

> [Unit Testing in Ruby](https://www.cloudbees.com/blog/unit-testing-in-ruby)

En su [artículo sobre pruebas unitarias](http://martinfowler.com/bliki/UnitTest.html), Martin Fowler menciona que realmente una unidad puede cambiar dependiendo de la escuela de pensamiento de la que provengas. Muchos del mundo orientado a objetos consideran la Clase como la unidad, mientras que aquellos en el mundo de la programación funcional consideran la Función como la unidad.

Aunque Ruby es un lenguaje orientado a objetos, tiendo a ver el método/función como la unidad. Esto es lo que debe probarse, centrándose en aquellos métodos que componen la interfaz pública de una clase en particular. Los métodos privados se pueden probar a través de sus interfaces públicas, lo que permite que la implementación real de ellos cambie y se refactorice según sea necesario.

En este artículo, veremos varias formas en las que podemos realizar pruebas unitarias en Ruby. Veremos cómo podemos aislar nuestras unidades de sus dependencias y también cómo podemos verificar que nuestro código funciona correctamente.

## Testing es importante... y dogmático

Solo tienes que mirar hasta DHH para ver que [con las pruebas vienen las opiniones](http://david.heinemeierhansson.com/2014/tdd-is-dead-long-live-testing.html).

Con las pruebas, hay muchas buenas razones para impulsar el aislamiento completo de una unidad a otra o para permitir que el sistema funcione en conjunto tal como se creó, con dependencias y todo. Lo más importante es que realmente realice pruebas, sin importar la metodología que siga.

No estoy totalmente en contra de probar métodos privados si puede ayudar al programador a verificar que funcionan correctamente, especialmente como parte de TDD, por lo que debe dejarse en manos de la persona la decisión. Solo tenga en cuenta que es más probable que cambie la implementación privada que la API pública: es más probable que estas pruebas se reescriban y/o se eliminen por completo cuando ya no sean útiles.

Las pruebas y el [desarrollo basado en pruebas](https://en.wikipedia.org/wiki/Test-driven_development) deberían ayudarlo a escribir un mejor código en el que tenga más confianza. Sigue la metodología que te ayude a lograrlo.

## ¿Qué debe probarse?

Dado que vamos a probar métodos, ¿qué es lo que realmente probamos? ¿Qué estamos tratando de probar poniéndolos a prueba? Lo que hay que preguntar es cuál es el propósito del método. Eso es lo que se debe probar. ¿Qué se propone lograr?

Me imagino que hay otros, pero voy a agrupar el propósito de un método en tres categorías diferentes:
1. Devuelve un valor.
2. Pasa el trabajo a otro lugar
3. Provoca un efecto secundario.

## ¿Qué no se debe probar?

Cuando se realizan pruebas unitarias, es importante evitar probar todo el sistema (lo que sería una prueba de integración). También es especialmente importante evitar las dependencias externas, entre las peores se encuentra una llamada a una API externa.

Las dependencias externas pueden fallar y fallarán. Debe planificar lo que sucede si una API externa está inactiva, pero no debe probar que hace su trabajo correctamente. No se preocupe por eso mientras se enfoca en lo que está haciendo su unidad de código.

Al evitar las dependencias externas, también está ayudando a acelerar sus pruebas. Leer desde un archivo o hablar con una base de datos es lento, y hablar con una API HTTP externa es aún más lento. Además, lo más probable es que no quieran que acceda a su API cada vez que usted (o su servidor de CI) ejecute el conjunto de pruebas.

## Ejemplos de pruebas unitarias

El código que vamos a usar en los siguientes ejemplos incluye varias clases, todas relacionadas con un sistema de tarjetas de regalo.

Habrá una clase `Giftcard`, que en una aplicación `Rails` sería un modelo `ActiveRecord`. Habrá otra clase llamada `Giftcards::Repository`, cuyo trabajo es realizar diferentes acciones en la tarjeta de regalo, como crear una nueva, consultar el saldo, ajustar el saldo y cancelar la tarjeta de regalo. Por último, tenemos una serie de adaptadores diferentes cuyo trabajo es hablar con el emisor de cada tarjeta de regalo.

Trabajaremos con un adaptador `Cardex` y un adaptador de prueba (un adaptador falso para usar en pruebas).

```ruby
class Giftcard
  attr_accessor :card_number, :pin, :issuer, :cancelled_at

  def self.create!(options)
    self.new.tap do |giftcard|
      options.each do |key, value|
        giftcard.send("#{key}=", value) if giftcard.respond_to?("#{key}=")
      end
    end
  end

  def masked_card_number
    "#{'X' * (card_number.length - 4)}#{last_four_digits}"
  end

  def cancel!
    self.cancelled_at = Time.now
    save!
  end

  def save!
    true
  end

  private

  def last_four_digits
    card_number[-4..-1]
  end
end
```

A continuación tenemos nuestra clase `Giftcards::Repository`, el puente entre la clase `Giftcard` y las diferentes clases de adaptadores.

```ruby
module Giftcards
  class Repository
    attr_reader :adapter

    def initialize(adapter)
      @adapter = adapter
    end

    def create(amount_cents, currency)
      details = adapter.create(amount_cents, currency)
      Giftcard.create!({
        card_number: details[:card_number],
        pin: details[:pin],
        currency: currency,
        issuer: adapter::NAME
      })
    end

    def balance(giftcard)
      adapter.balance(giftcard.card_number)
    end

    def adjust(giftcard, amount_cents)
      adapter.adjust(giftcard.card_number, amount_cents)
    end

    def cancel(giftcard)
      amount_cents = balance(giftcard)
      adjust(giftcard, -amount_cents)
      giftcard.cancel!
      giftcard
    end
  end
end
```

Luego están los adaptadores, que aún no están completamente desarrollados, pero para los propósitos de este ejemplo, funcionarán bien. Su interfaz está bloqueada y pueden implementarse y probarse individualmente en un momento posterior.

Aquí es donde irían todas las desagradables llamadas SOAP (si ha trabajado con emisores de tarjetas de regalo reales, sabrá de lo que estoy hablando), o si tiene suerte, una API JSON (muy dudoso).

```ruby
module Giftcards
  module Adapters
    class BaseAdapter
      # To be implemented
    end

    class Cardex < BaseAdapter
      # To be implemented
    end

    class Test < BaseAdapter
      NAME = 'test'.freeze

      def create(amount_cents, currency)
        pool = (0..9).to_a
        {
          card_number: (0..11).map{ |n| pool.sample }.join,
          pin: (0..4).map{ |n| pool.sample }.join,
          currency: currency
        }
      end

      def balance(card_number)
        100
      end

      def adjust(card_number, amount_cents)
        balance(card_number) + amount_cents
      end

      def cancel(giftcard)
        true
      end
    end
  end
end
```

## Aislando las dependencias

El aislamiento de estas dependencias se puede lograr utilizando la inyección de dependencia, mediante la cual inyecta dependencias de código auxiliar (un contenedor de API específco para probar y que devuelve una respuesta enlatada de inmediato), o utilizando alguna forma de prueba doble o simulación/aplicación de métodos.

### Usando dobles

Los dobles son una especie de versión "falsa" de los objetos dependientes. La mayoría de las veces son representaciones incompletas, que solo exponen los métodos necesarios para realizar la prueba. Rspec viene con una gran biblioteca llamada [rspec-mock](https://github.com/rspec/rspec-mocks) que incluye todo tipo de formas diferentes de producir estos dobles.

Un ejemplo, que usaremos a continuación, es crear una instancia falsa de la clase `Giftcard` que solo tiene el método card_number (y el valor que devuelve).

```ruby
instance_double('Giftcard', card_number: 12345)
```

### Mocking de las solicitudes HTTP

Hay varias formas de simular solicitudes HTTP, pero no las analizaremos aquí. En un artículo que escribí sobre los [microservicios en Rails](http://blog.codeship.com/architecting-rails-apps-as-microservices/), hay un ejemplo bastante bueno sobre cómo simular una solicitud HTTP usando la gema de `Faraday`.

Otras formas de simular solicitudes HTTP pueden implicar el uso de la gema [webmock](https://github.com/bblimke/webmock). O puede usar [VCR](https://github.com/vcr/vcr), que hace una solicitud real una vez, graba la respuesta y luego usa la respuesta grabada a partir de ese momento.

### Stubing métodos

Debido a la forma en que está escrito Ruby, en realidad podemos reemplazar el método de un objeto con una versión falsa. Esto se hace en rspec con el siguiente código:

```ruby
allow(adapter).to receive(:adjust) { 50 }
```

Ahora, cuando se llame a `adapter.adjust`, se devolverá el valor 50 pase lo que pase, en lugar de realizar la costosa llamada SOAP al servicio real. La prueba completa queda de la siguiente manera:

```ruby
describe Giftcards::Repository do
  describe '#adjust' do
    let(:adapter)    { Giftcards::Adapters::Cardex.new }
    let(:repository) { Giftcards::Repository.new(adapter) }
    let(:giftcard)   do
      Giftcard.new do |giftcard|
        giftcard.card_number = '12345'
      end
    end

    it 'returns new balance' do
      allow(adapter).to receive(:adjust) { 50 }
      expect(repository.adjust(giftcard, -50)).to eq(50)
    end
  end
end
```

### Inyección de dependencia

La inyección de dependencia es donde pasar las dependencias a un objeto. En este caso, en lugar de que la clase `Giftcards::Repository` decida qué adaptador usará, podemos pasarle explícitamente el adaptador, poniendo más control en manos de la persona que llama.

Esta técnica nos ayuda con las pruebas, porque podemos reemplazar el objeto real con uno creado específicamente para las pruebas.

```ruby
adapter = Giftcards::Adapters::Test.new
repository = Giftcards::Repository.new(adapter)
```

## Verificando que nuestro código funcione como se espera

La verdadera razón por la que escribimos pruebas es para que estar seguros de que nuestro código funciona como se espera. Tratar con las dependencias está bien, pero si no nos ayuda a verificar que nuestro código funciona, no tiene sentido.

### Probando el valor de retorno

La forma más simple de prueba unitaria es verificar que nuestra función devuelve el valor correcto cuando se llama. Aquí no hay efectos secundarios... simplemente lo llamamos y esperamos que regrese un resultado.

```ruby
describe Giftcard do
  describe '#masked_card_number' do
    it 'masks number correctly' do
      giftcard = Giftcard.new
      giftcard.card_number = '123456780012'
      expect(giftcard.masked_card_number).to eq('XXXXXXXX0012')
    end
  end
end
```

### Probando otro método

Hay casos en los que el propósito del método es enviar algún tipo de trabajo a otro método. O en otras palabras, llama a un método. Escribamos una prueba para verificar que este otro método fue llamado correctamente. Rspec en realidad tiene un mecanismo para descubrir esto, donde podemos asegurarnos de que un objeto recibió una determinada llamada de método con argumentos específicos.

```ruby
describe Giftcards::Repository do
  describe '#balance' do
    let(:adapter)    { Giftcards::Adapters::Test.new }
    let(:repository) { Giftcards::Repository.new(adapter) }
    let(:giftcard)   { instance_double('Giftcard', card_number: 12345) }

    it 'returns balance for giftcard' do
      expect(repository.balance(giftcard)).to eq(100)
    end

    it 'calls the balance of adapter' do
      expect(repository.adapter).to receive(:balance).with(giftcard.card_number)
      repository.balance(giftcard)
    end
  end
end
```

### Probando los efectos secundarios

Por último, nuestro método puede producir algunos efectos secundarios. Estos pueden ser cualquier cosa, desde cambiar el estado de un objeto (el valor de una variable de instancia) hasta escribir en la base de datos o en un archivo. Lo importante es verificar tanto el estado anterior como el posterior, para estar seguros de que ocurrió el efecto secundario.

```ruby
describe Giftcard do
  describe '#cancel!' do
    it 'updates cancelled_at field to current time' do
      giftcard = Giftcard.new
      expect(giftcard.cancelled_at).to eq(nil)
      giftcard.cancel!
      expect(giftcard.cancelled_at).to be_a(Time)
    end
  end
end
```

### Responsabilidad única

Si su método no cae en una de las tres categorías anteriores, lo que significa que su propósito no está definido por un resultado, una llamada de método o un efecto secundario, tal vez esté haciendo demasiado. En ese caso, debe dividir aún más en varios métodos de un solo propósito.

Siguiendo el [principio de responsabilidad única](https://en.wikipedia.org/wiki/Single_responsibility_principle), su código será mucho más fácil de probar.

## Conclusión

Hemos cubierto varias formas diferentes de aislar dependencias en nuestro código mientras escribimos pruebas unitarias, así como también cómo verificar que el método hace lo que se supone que debe hacer. La parte más importante de la prueba es realmente hacerla. Vi en Twitter recientemente una cita inspirada en Beyonce que parece apropiada ahora:

    Si amas tu código, pruébalo.
    
