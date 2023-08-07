#!/usr/bin/python3

import base64
import http.client
import json
import os
import re
import sys

class RequestExecutionContext:
    def __init__(self):
        self.directory = os.getenv("DATA_DIR")
        self.load_requests_responses()
        self.load_variables()

    def load_variables(self):
        self.variables = json.loads(self.get_file_content("variables.json"))
        self.variables = json.loads(self.replace_variables(self.get_file_content("variables.json")))

    def load_requests_responses(self):
        self.responses = json.loads(self.get_file_content("responses.json"))

    def exec_request(self, request_name):
        request_definition = self.replace_variables(self.get_file_content(request_name))

        request = self.parse_http_request(request_definition)

        if request["protocol"] == "http":
            conn = http.client.HTTPConnection(request["host"])
            conn.request(request["method"],request["path"], request["payload"].encode("utf-8"), request["headers"])
            res = conn.getresponse()
        else:
            conn = http.client.HTTPSConnection(request["host"])
            conn.request(request["method"],request["path"], request["payload"].encode("utf-8"), request["headers"])
            res = conn.getresponse()

        data = res.read()
        response = data.decode("utf-8")

        response_status_text = str(res.status) + " - " + res.reason
        response_headers_text = ""
        response_headers = {}
        for header in res.headers.keys():
            response_headers[header] = res.headers[header]
            response_headers_text = response_headers_text + header + ":" + res.headers[header] + "\n"
        response_details = response_status_text + "\n\n" + response_headers_text

        self.responses[request_name] = {
                "status": res.status,
                "reason": res.reason,
                "headers": response_headers,
                "body": response
                }
        response_file = open(self.directory + "/responses.json", "w")
        response_file.write(json.dumps(self.responses))
        response_file.close()

        print(response_details, file=sys.stderr)
        print(response)

    def get_file_content(self, path):
        file = open(self.directory + "/" + path, "r")
        content = file.read()
        file.close()
        return content

    def replace_variables(self, text):
        result = text
        variables = set(re.findall("{{([^{}]+?)}}", text))

        if len(variables) == 0:
            return text

        for variable_definition in variables:
            variable = self.parse_variable_definition(variable_definition)

            if "var" in variable:
                variable_value = self.get_variable_value(variable["var"])
                result = result.replace("{{" + variable_definition + "}}", variable_value)
            elif "res" in variable :
                if "requests/" + variable["res"] in self.responses:
                    request_result_body = self.responses["requests/" + variable["res"]]["body"]
                    result = result.replace("{{" + variable_definition + "}}", request_result_body)
                else:
                    result = result.replace("{{" + variable_definition + "}}", "")
            elif "base64" in variable:
                result = result.replace("{{" + variable_definition + "}}", base64.b64encode(variable["base64"].encode('utf-8')).decode('utf-8'))

        return self.replace_variables(result)

    def parse_variable_definition(self, variable_definition):
        variable_parts = re.findall("([^}\s]+?):([^},]+)", variable_definition);
        result = {}

        for variable_part in variable_parts:
            result[variable_part[0]] = variable_part[1]

        return result

    def get_variable_value(self, variable_path):
        variable_path_parts = variable_path.strip().split(".")
        result = self.variables

        for variable_path_part in variable_path_parts:
            result = result[variable_path_part]

        return result

    def parse_http_request(self, request_definition):
        request = { "headers": {} }

        blocks = request_definition.split("\n\n")
        header = blocks[0].strip()
        header_lines = header.split("\n")

        header_parts = re.match("(.+?) (http|https)://(\S+?)(/.*)$", header_lines[0])
        request["method"] = header_parts[1]
        request["protocol"] = header_parts[2]
        request["host"] = header_parts[3]
        request["path"] = header_parts[4]

        header_lines = header_lines[1:]

        while True:
            is_query_param = re.match("\s*[?&]", header_lines[0])

            if is_query_param != None:
                request["path"] = request["path"] + header_lines[0].strip()
                header_lines = header_lines[1:]
            else:
                break

        for raw_header in header_lines:
            raw_header_parts = raw_header.split(":")
            header_name = raw_header_parts[0].strip()
            header_value = raw_header_parts[1].strip()
            request["headers"][header_name] = header_value

        if len(blocks) > 1:
            request["payload"] = blocks[1].strip()
        else:
            request["payload"] = ""

        return request

if __name__ == "__main__":
    RequestExecutionContext().exec_request(sys.argv[1])
