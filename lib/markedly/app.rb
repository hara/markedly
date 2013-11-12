# coding: utf-8
require 'eventmachine'
require 'em-websocket'
require 'launchy'

module Markedly
  class App
    def self.run!(source, options = {})
      App.new(source, options).run!
    end

    def initialize(source, options = {})
      @document = Document.new(source, options)
      @options = options
    end

    def run!
      return @document.export if @options[:export]
      preview
    end

    private

    def preview
      @document.convert
      puts "Open '%s'" % @document.uri
      Launchy.open(@document.uri)

      EM.run do

        @channel = EM::Channel.new

        debug "Start WebSocket Server (ws://localhost:#{@document.port})"
        EM::WebSocket.start(host: '0.0.0.0', port: @document.port) do |ws|
          ws.onopen do
            subscriber = @channel.subscribe do |message|
              ws.send(message)
            end

            debug "client #{subscriber} connected"

            ws.onclose do
              @channel.unsubscribe(subscriber)
              debug "client #{subscriber} closed"
            end
          end
        end

        EM.defer do
          mtime = last_mtime = File.mtime(@document.source)
          loop do
            mtime = File.mtime(@document.source)
            if mtime > last_mtime
              puts "file modified"
              @document.convert
              @channel.push 'updated'
            end
            last_mtime = mtime
            sleep @options[:interval]
          end
        end
      end
    end

    def debug(message)
      puts message if @options[:debug]
    end
  end
end
