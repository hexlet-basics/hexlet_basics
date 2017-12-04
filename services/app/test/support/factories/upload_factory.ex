defmodule HexletBasics.UploadFactory do
  defmacro __using__(_opts) do
    quote do
      def upload_factory do
        %HexletBasics.Upload{}
      end
    end
  end
end
