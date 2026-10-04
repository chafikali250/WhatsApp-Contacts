#include "httplib.h"
#include "json.hpp"
#include <iostream>

using json = nlohmann::json;

int main() {
    httplib::Server svr;

    // Sample database (JSON array)
    json contacts = json::parse(R"([
        {"id": 1, "name": "Contact_Alpha", "phone": "+212600112233", "status": "Available"},
        {"id": 2, "name": "Contact_Beta", "phone": "+212611223344", "status": "Busy"},
        {"id": 3, "name": "Contact_Gamma", "phone": "+212622334455", "status": "At work"},
        {"id": 4, "name": "Contact_Delta", "phone": "+212633445566", "status": "Sleeping"},
        {"id": 5, "name": "Contact_Epsilon", "phone": "+212644556677", "status": "Available"},
        {"id": 6, "name": "Contact_Zeta", "phone": "+212655667788", "status": "Urgent calls only"},
        {"id": 7, "name": "Contact_Eta", "phone": "+212666778899", "status": "In a meeting"},
        {"id": 8, "name": "Contact_Theta", "phone": "+212677889900", "status": "Available"},
        {"id": 9, "name": "Contact_Iota", "phone": "+212688990011", "status": "Battery about to die"},
        {"id": 10, "name": "Contact_Kappa", "phone": "+212699001122", "status": "Available"}
    ])");

    // Endpoint 1: Healthcheck (mziyand bash Cloud Run y-3raf l-app khedama)
    svr.Get("/health", [](const httplib::Request&, httplib::Response& res) {
        res.set_content("{\"status\": \"OK\"}", "application/json");
    });

    // Endpoint 2: Get all contacts
    svr.Get("/api/contacts", [&contacts](const httplib::Request&, httplib::Response& res) {
        res.set_content(contacts.dump(), "application/json");
    });

    std::cout << "Server started on port 8080..." << std::endl;
    svr.listen("0.0.0.0", 8080);

    return 0;
}
