defmodule OOTest do
  use ExUnit.Case
  doctest OO

  test "Mammal sound (base object)" do
    assert Mammal.sound == :Silent
  end

  test "Dog sound (override method)" do
    assert Dog.sound == :Woff
  end

  test "Cat sound (override method)" do
    assert Cat.sound == :Mjau
  end

  test "Dog walk (inherited from base object)" do
    assert Dog.walk == :Walking
  end

  test "Cat walk (inherited from base object)" do
    assert Cat.walk == :Walking
  end

  test "Dog swim (inherited from base object)" do
    assert Dog.swim == :Swimming
  end

  test "Cat swim (override only in this object)" do
    assert Cat.swim == :Refuse
  end

  test "Tiger walk (3 levels of inheritance)" do
    assert Tiger.sound == :Roar
  end

  test "Tiger sound (3 levels of override)" do
    assert Tiger.sound == :Roar
  end

  test "Mammal parents" do
    assert Mammal.parents == [Mammal]
  end

  test "Dog parents" do
    assert Dog.parents == [Dog, Mammal]
  end

  test "Cat parents" do
    assert Cat.parents == [Cat, Mammal]
  end

  test "Tiger parents" do
    assert Tiger.parents == [Tiger, Cat, Mammal]
  end
end
