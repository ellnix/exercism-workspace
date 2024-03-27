defmodule Newsletter do
  def read_emails(path) do
    with {:ok, content}  <- File.read(path) do
      content
        |> String.split("\n")
        |> Enum.reject(& &1 == "")
    end
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)
    Enum.each(read_emails(emails_path), fn email -> send_one(email, log, send_fun) end)
    close_log(log)
  end

  defp send_one(email, log, send_fun) do
    with :ok <- send_fun.(email) do
      log_sent_email(log, email)
    end
  end
end
