/*
 * Copyright 2012. Bloomberg Finance L.P.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:  The above
 * copyright notice and this permission notice shall be included in all copies
 * or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */


import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;

import com.bloomberglp.blpapi.Datetime;
import com.bloomberglp.blpapi.Event;
import com.bloomberglp.blpapi.Element;
import com.bloomberglp.blpapi.InvalidRequestException;
import com.bloomberglp.blpapi.Logging;
import com.bloomberglp.blpapi.Message;
import com.bloomberglp.blpapi.MessageIterator;
import com.bloomberglp.blpapi.Name;
import com.bloomberglp.blpapi.Request;
import com.bloomberglp.blpapi.Service;
import com.bloomberglp.blpapi.Session;
import com.bloomberglp.blpapi.SessionOptions;

public class Main
{
  private static final Name SECURITY_DATA = new Name("securityData");
  private static final Name SECURITY = new Name("security");
  private static final Name FIELD_DATA = new Name("fieldData");
  private static final Name RESPONSE_ERROR = new Name("responseError");
  private static final Name SECURITY_ERROR = new Name("securityError");
  private static final Name FIELD_EXCEPTIONS = new Name("fieldExceptions");
  private static final Name FIELD_ID = new Name("fieldId");
  private static final Name ERROR_INFO = new Name("errorInfo");
  private static final Name CATEGORY = new Name("category");
  private static final Name MESSAGE = new Name("message");

  private String            d_host;
  private int               d_port;
  private ArrayList<String> d_securities;
  private ArrayList<String> d_fields;
  private String d_start, d_end;
  private Boolean           d_adjusted;
  private String            d_symsuffix;
  public PrintWriter out_file_writer;

  /**
   * @param args
   */
  public static void main(String[] args) throws Exception
  {
    System.out.println("Get Day-end prices");
    Main example = new Main();
    example.run(args);
    if ( example.out_file_writer != null ) {
      example.out_file_writer.flush();
      example.out_file_writer.close();
    }
  }

  public Main()
  {
    // d_host = "192.168.91.28";
    d_host = "192.168.91.172";
    // d_host = "127.0.0.1";
    // d_port = 8194;
    d_port = 10194;
    d_securities = new ArrayList<String>();
    d_fields = new ArrayList<String>();
    d_adjusted = false;
    d_symsuffix = "";
  }

  private void run(String[] args) throws Exception
  {
    if (!parseCommandLine(args)) return;

    SessionOptions sessionOptions = new SessionOptions();
    sessionOptions.setServerHost(d_host);
    sessionOptions.setServerPort(d_port);

    System.out.println("Connecting to " + d_host + ":" + d_port);
    Session session = new Session(sessionOptions);
    if (!session.start()) {
      System.err.println("Failed to start session.");
      return;
    }
    if (!session.openService("//blp/refdata")) {
      System.err.println("Failed to open //blp/refdata");
      return;
    }

    try {
      sendRefDataRequest(session);
    } catch (InvalidRequestException e) {
      e.printStackTrace();
    }

    // wait for events from session.
    eventLoop(session);

    session.stop();
  }

  private void eventLoop(Session session) throws Exception
  {
    boolean done = false;
    while (!done) {
      Event event = session.nextEvent();
      if (event.eventType() == Event.EventType.PARTIAL_RESPONSE) {
        System.out.println("Processing Partial Response");
        processResponseEvent(event);
      }
      else if (event.eventType() == Event.EventType.RESPONSE) {
        System.out.println("Processing Response");
        processResponseEvent(event);
        done = true;
      } else {
        MessageIterator msgIter = event.messageIterator();
        while (msgIter.hasNext()) {
          Message msg = msgIter.next();
          System.out.println(msg.asElement());
          if (event.eventType() == Event.EventType.SESSION_STATUS) {
            if (msg.messageType().equals("SessionTerminated") ||
                msg.messageType().equals("SessionStartupFailure")) {
              done = true;
            }
          }
        }
      }
    }
  }

  // return true if processing is completed, false otherwise
  private void processResponseEvent(Event event)
    throws Exception
    {
      MessageIterator msgIter = event.messageIterator();
      while (msgIter.hasNext()) {
        Message msg = msgIter.next();
        //            System.out.println(msg);

        Element securityData = msg.getElement("securityData");
        String ticker = securityData.getElementAsString("security");

        System.out.println(ticker);
        Element fieldDataArray = securityData.getElement("fieldData");
        for (int j = 0; j < fieldDataArray.numValues(); ++j) {
          Element fieldData = fieldDataArray.getValueAsElement(j);
          String row = "";
          for (int k = 0; k < fieldData.numElements(); ++k) {
            Element field = fieldData.getElement(k);
            System.out.println("\t" + field.name() + " = "
                + field.getValueAsString());

            if ( field.name().toString().equals("date") ) {
              row += field.getValueAsString() + "," + ticker;
            } else {
              row += "," + field.getValueAsString();
            }

            //                    if ( this.out_file_writer != null && field.name().toString().equals( d_fields.get(0) ) ) {
            //                        row += field.getValueAsString() + "\n";
            //                        this.out_file_writer.write(row);
            // for kevin
            //                        this.out_file_writer.write( ticker.split(" ")[0] + "," + field.getValueAsString() + "\n" );
            //                    }
          }
          if ( this.out_file_writer != null )
            this.out_file_writer.write(row + "\n");
        }


        if (msg.hasElement(RESPONSE_ERROR)) {
          printErrorInfo("REQUEST FAILED: ", msg.getElement(RESPONSE_ERROR));
          continue;
        }

      }
    }

  private void sendRefDataRequest(Session session) throws Exception
  {
    Service refDataService = session.getService("//blp/refdata");
    Request request = refDataService.createRequest("HistoricalDataRequest");

    // Add securities to request
    Element securities = request.getElement("securities");

    for (String security : d_securities) {
      if (d_symsuffix == "") securities.appendValue(security);
      else securities.appendValue(security + d_symsuffix);
    }

    // Add fields to request
    Element fields = request.getElement("fields");
    for (String field : d_fields) {
      fields.appendValue(field);
    }

    if ( d_adjusted ) {
      System.out.println(">>> You are requesting adjusted prices.");
      request.set("adjustmentNormal", true);
      request.set("adjustmentAbnormal", true);
      request.set("adjustmentSplit", true);
    } else {
      System.out.println(">>> You are requesting NON-adjusted prices.");
      request.set("adjustmentNormal", false);
      request.set("adjustmentAbnormal", false);
      request.set("adjustmentSplit", false);
    }

    request.set("startDate", d_start);
    request.set("endDate", d_end);

    System.out.println("Sending Request: " + request);
    session.sendRequest(request, null);
  }

  private void registerCallback(int verbosity)
  {
    Logging.Callback loggingCallback = new Logging.Callback() {
      public void onMessage(long threadId, Level level, Datetime dateTime,
          String loggerName, String message) {
        System.out.println(dateTime + "  " + loggerName + " [" + level.toString() + "] Thread ID = "
            + threadId + " " + message);
      }
    };

    Level logLevel = Level.OFF;
    if (verbosity > 0) {
      switch (verbosity) {
        case 1:
          logLevel = Level.INFO;
          break;
        case 2:
          logLevel = Level.FINE;
          break;
        case 3:
          logLevel = Level.FINER;
          break;
        default:
          logLevel = Level.FINEST;
          break;
      }
    }
    Logging.registerCallback(loggingCallback, logLevel);
  }

  private boolean parseCommandLine(String[] args) throws Exception
  {
    int verbosity = 0;
    for (int i = 0; i < args.length; ++i) {
      if (args[i].equalsIgnoreCase("-s")) {
        d_securities.add(args[i+1]);
      }
      else if (args[i].equalsIgnoreCase("-f")) {
        d_fields.add(args[i+1]);
      }
      else if (args[i].equalsIgnoreCase("-o")) {
        FileWriter fw = new FileWriter( args[i+1], false);
        this.out_file_writer = new PrintWriter(fw);
        //                this.out_file_writer.write("code,price\n");
      }
      else if (args[i].equalsIgnoreCase("-ip")) {
        d_host = args[i+1];
      }
      else if (args[i].equalsIgnoreCase("-p")) {
        d_port = Integer.parseInt(args[i+1]);
      }
      else if (args[i].equalsIgnoreCase("-v")) {
        ++verbosity;
      }
      else if (args[i].equalsIgnoreCase("-start")) {
        d_start = args[i+1];
      }
      else if (args[i].equalsIgnoreCase("-end")) {
        d_end = args[i+1];
      }
      else if (args[i].equalsIgnoreCase("-adjusted")) {
        d_adjusted = args[i+1].equalsIgnoreCase("true");
      }
      else if (args[i].equalsIgnoreCase("-symsuffix")) {
        d_symsuffix = args[i+1];
      }
    }

    if (verbosity > 0) {
      registerCallback(verbosity);
    }
    // handle default arguments
    if (d_securities.isEmpty()) {
      d_securities.add("IBM US Equity");
    }

    if (d_fields.isEmpty()) {
      // If no pass filed, last; otherwise, field
      //            d_fields.add("PX_LAST");
      System.out.println("Field should be given, e.g. PX_LAST");
      return false;
    }

    if ( this.d_start == null || this.d_end == null ) {
      System.out.println("Date should be given.");
      return false;
    }

    //        if ( this.out_file_writer == null ) {
    //            System.out.println("Output file should be given.");
    //            return false;
    //        }

    return true;
  }

  private void printErrorInfo(String leadingStr, Element errorInfo)
    throws Exception
    {
      System.out.println(leadingStr + errorInfo.getElementAsString(CATEGORY) +
          " (" + errorInfo.getElementAsString(MESSAGE) + ")");
    }

  private void printUsage()
  {
    System.out.println("Usage:");
    System.out.println("\tRetrieve reference data ");
    System.out.println("\t\t[-s \t<security = IBM US Equity>");
    System.out.println("\t\t[-f \t<field = PX_LAST>");
    System.out.println("\t\t[-ip\t<ipAddress = localhost>");
    System.out.println("\t\t[-p \t<tcpPort = 8194>");
    System.out.println("\t\t[-v \tVerbose");
  }
}

