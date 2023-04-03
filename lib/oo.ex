defmodule OO do
  defmacro object(obj_expr, block, _opts \\ []) do
    {object, parent} = case obj_expr do
      {:"::", _, [obj, parent]} ->
        {obj, parent}
      obj ->
        {obj, nil}
    end

    OO.Builder.build(object, parent, block)
  end
end

defmodule OO.Builder do
  def build(object, parent, block) do
    quote do
      defmodule unquote(object) do
        parent_obj = unquote(parent)
        Module.register_attribute(__MODULE__, :parent, accumulate: false)
        Module.put_attribute(__MODULE__, :parent, parent_obj)
        Module.put_attribute(__MODULE__, :object, unquote(object))

        Module.register_attribute(__MODULE__, :properties, accumulate: true)

        unquote(block)

        def methods do
          built_ins = [
            object: 0,
            register: 2,
            clone: 0,
            clone: 1,
            methods: 0,
          ]

          __MODULE__.__info__(:functions) -- built_ins
        end

        def props() do
          props = @properties
          if parent() != nil do
             props ++ parent().props()
          else
            props
          end
        end

        def parent() do
          @parent
        end

        def parents() do
          parents(unquote(object), [unquote(object)])
        end

        def parents(module, acc) do
          parent = module.parent()
          if parent == nil do
             Enum.reverse(acc)
          else
            parent.parents(parent, [parent | acc])
          end
        end

        if parent_obj != nil do
          import Kernel, only: [function_exported?: 3]
          for {fun, arity} <- parent_obj.methods() do
            if function_exported?(__MODULE__, fun, arity) == false do
              method = OO.Builder.inherit_method(fun, arity, parent_obj)
              Code.eval_quoted(method, [], __ENV__)
            end
          end
        end
      end
    end
  end

  def inherit_method(method, arity, parent_obj) do
    args = (0..arity) |> Enum.drop(1) |> Enum.map(fn i -> {:"arg#{i}", [], OO} end)
    {:defdelegate, [context: Ao, import: Kernel],
      [{method, [], args}, [to: parent_obj]]}
  end
end
