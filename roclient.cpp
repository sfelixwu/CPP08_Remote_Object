
// ecs36b WR client

#include <iostream>

// JSON RPC part
#include <stdlib.h>
#include "roclient.h"
#include <jsonrpccpp/client/connectors/httpclient.h>

// for sleep()
#include <unistd.h>

using namespace jsonrpc;
using namespace std;

int
main(void)
{
  // HttpClient httpclient("http://169.237.6.102:8300");
  HttpClient httpclient("http://localhost:8300");
  roClient myClient(httpclient, JSONRPC_CLIENT_V2);
  Json::Value result;

  try {
    result = myClient.setGPSLabel("setGPSLabel", "Labeled_GPS",
				  "Teaching and Learning Complex", "1001");
    cout << result.toStyledString() << endl;
  } catch (JsonRpcException &e) {
    cerr << e.what() << endl;
  }

  try {
    result = myClient.dump2JSON("dump2JSON", "Labeled_GPS", "1001");
    cout << result.toStyledString() << endl;
  } catch (JsonRpcException &e) {
    cerr << e.what() << endl;
  }

  return 0;
}
