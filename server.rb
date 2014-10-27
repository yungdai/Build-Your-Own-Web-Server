require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started

loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets.chomp) && !line.empty?  # Read the request and collect it until it's empty
    lines << line
  end
  puts lines                                        # Output the full request to stdout


  # This is how you open the filename index.html
  # first set up the variable filename to index.html
  # filename = "index.html"

  # since this is not how the real world works.  I'm going to get the filename from the server response
  filename = lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')
  # setup the response to be the actual file in the directory from the variable filename

  # Check to see if the filname exists in the directory
  if File.exists?(filename)
    body = File.read(filename)
    #if the file name is found, set the response variable to the open the file
    success_header = "HTTP/1.1 200 OK\r\n"
    success_header += "Content-Type: text/html\r\n"
    success_header += "Content-Length: #{body.size}\r\n" # #{body.size} counts the amount of characters in the body variable.
    success_header += "Connection: close\r\n"
    success_header += "\r\n"

    # This variable equal to th format of how you want the response to come out
    response = success_header + body
    # response = File.read(filename) + success_header
  else

    # defining the not_found_header to be sent to the browser before the text of "File Not Found"
    body = "File Not Found"
    not_found_header = "HTTP/1.1 404 Not Found\r\n"
    not_found_header += "Content-Type: text/plain\r\n"
    not_found_header += "Content-Length: #{body.size}\r\n" # #{body.size} counts the amount of characters in the body variable.
    not_found_header += "Connection: close\r\n"
    not_found_header += "\r\n"
    response = not_found_header + body
  end

  # output the response to the browser
  client.puts(response)
  client.puts(Time.now.ctime)                       # Output the current time to the client
  client.close                                      # Disconnect from the client
end
