defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  @doc """
  Transform input `%Recipient{}` to an `Ecto.Changeset`.
  """
  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  @doc """
  Send promotion information to recipients.
  """
  def send_promo(_recipient, _attrs) do
    {:ok, %Recipient{}}
  end
end
