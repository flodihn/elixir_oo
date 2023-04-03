# OO

=== WARNING, USE WITH EXTREME CAUTION ===

Object style inheritence in Elixir.

When you actually want to model behaviors of "real objects", mostly items or creatures for a virtual space, inheritence can be nice.

## Usage
Importing the OO module gives add the object keyword, which can be used instead of defmodule.

mammal.ex
```elixir
import OO

object Mammal do
  def walk() do
    :Walking
  end

  def swim() do
    :Swimming
  end

  def sound() do
    :Silent
  end
end
```

dog.ex
```elixir
import OO

object Dog :: Mammal do
  def sound() do
    :Woff
  end
end
```

cat.ex
```elixir
import OO

object Cat :: Mammal do
  def sound() do
    :Mjau
  end

  def swim() do
    :Refuse
  end
end
```

For more examples look in the test directory.

## TODO
 * Objects are "static" as in C++ or C#, it would be nice to support Python'ish objects which can be instanced and have their methods/properties changed in runtime.