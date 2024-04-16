defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(options :: opts) :: {:ok, opts} | {:err, error}

  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  
  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) do
    case rem(frame_number, 4) do
      0 -> %DancingDots.Dot { dot | opacity: dot.opacity / 2 }
      _ -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    with [velocity: velocity] <- opts,
      {true, _velocity} <- {is_number(velocity), velocity} do
      {:ok, opts}
    else
      {false, velocity} -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
      _ -> {:error, "The :velocity option is required, and its value must be a number. Got: nil"}
    end

  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, [velocity: velocity]) do
    zoom_factor = (frame_number - 1) * velocity

    %DancingDots.Dot { dot | radius: dot.radius + zoom_factor }
  end
end
