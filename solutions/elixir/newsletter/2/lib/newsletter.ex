defmodule Newsletter do
  def read_emails(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
  end

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    do_send_newsletter(read_emails(emails_path), open_log(log_path), send_fun)
  end

  defp do_send_newsletter([], file, _), do: close_log(file)

  defp do_send_newsletter([head | tail], file, send_fun) do
    if send_fun.(head) == :ok, do: log_sent_email(file, head)
    do_send_newsletter(tail, file, send_fun)
  end

end
