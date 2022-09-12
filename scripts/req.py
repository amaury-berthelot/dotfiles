#!/usr/bin/python3

import http.client
import json
import re
import os
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
        request_definition = self.replace_variables(self.get_file_content("requests/" + request_name))
        request = self.parse_http_request(request_definition)

        if request["protocol"] == "http":
            conn = http.client.HTTPConnection(request["host"])
            conn.request(request["method"],request["path"], request["payload"], request["headers"])
            res = conn.getresponse()
        else:
            conn = http.client.HTTPSConnection(request["host"])
            conn.request(request["method"],request["path"], request["payload"], request["headers"])
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
        variables = set(re.findall("{{(.+)}}", text))

        for variable_definition in variables:
            variable = self.parse_variable_definition(variable_definition)

            if "var" in variable:
                variable_value = self.get_variable_value(variable["var"])
                result = result.replace("{{" + variable_definition + "}}", variable_value)
            elif "res" in variable and variable["res"] in self.responses:
                request_result_body = self.responses[variable["res"]]["body"]
                result = result.replace("{{" + variable_definition + "}}", request_result_body)

        return result

    def parse_variable_definition(self, variable_definition):
        variable_parts = re.findall("([^}\s]+):([^}\s]+)", variable_definition);
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

        host_parts = re.match("(http|https)://(\S+)", blocks[0])
        request["protocol"] = host_parts[1]
        request["host"] = host_parts[2]

        header = blocks[1].strip()
        if len(blocks) > 2:
            request["payload"] = blocks[2].strip()
        else:
            request["payload"] = ""

        header_lines = header.split("\n")
        endpoint = header_lines[0]
        raw_headers = header_lines[1:]

        endpoint_parts = endpoint.split(" ")
        request["method"] = endpoint_parts[0]
        request["path"] = endpoint_parts[1]

        for raw_header in raw_headers:
            raw_header_parts = raw_header.split(":")
            header_name = raw_header_parts[0].strip()
            header_value = raw_header_parts[1].strip()
            request["headers"][header_name] = header_value

        return request

if __name__ == "__main__":
    RequestExecutionContext().exec_request(sys.argv[1])
