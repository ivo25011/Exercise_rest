package com.amcef.exercise_rest.controller;

import com.amcef.exercise_rest.model.Contribution;
import com.amcef.exercise_rest.service.ContributionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@Controller
public class ContributionController {

    @Autowired
    ContributionService service;

    // Redirect to home.jsp
    @Operation(summary = "Redirect to home.jsp")
    @RequestMapping("/")
    public String home() {
        return "home";
    }

    // Returns the contribution by Id if found, otherwise uses external API
    @Operation(summary = "Get a contribution by ID", description = "Returns the contribution by Id if found, otherwise uses external API")
    @ApiResponse(responseCode = "200", description = "Contribution found")
    @ApiResponse(responseCode = "404", description = "Contribution not found")
    @GetMapping("/contributions/{id}")
    @ResponseBody
    public ResponseEntity<Contribution> getContributionById(@PathVariable Integer id) {
        Contribution contribution = service.getContributionsById(id);
        if (contribution != null) {
            return ResponseEntity.ok(contribution);
        } else {
            return getContributionFromExternalApi(id);
        }
    }

    // Returns the contribution by userId if found
    @Operation(summary = "Returns the contribution by userId if found")
    @GetMapping("/contributions/user/{userId}")
    @ResponseBody
    public ResponseEntity<Contribution> getContributionByUserId(@PathVariable Integer userId) {
        Contribution contribution = service.getContributionsByUserId(userId);
        if (contribution != null) {
            return ResponseEntity.ok(contribution);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Add a new contribution
    @Operation(summary = "Add a new contribution")
    @PostMapping("/contributions/add")
    public ResponseEntity<String> addContribution(@RequestBody Contribution contribution) {
        Contribution existContribution = service.getContributionsById(contribution.getID());
        if (existContribution != null) {
            return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body("It's already exist, You can update it..");
        }
        service.addContribution(contribution);
        return ResponseEntity.ok("Contribution added successfully");
    }

    // Delete a contribution by ID
    @Operation(summary = "Delete a contribution by ID")
    @DeleteMapping("/contributions/delete/{id}")
    public void deleteContribution(@PathVariable Integer id) {
        service.deleteContribution(id);
    }

    // Update an existing contribution
    @Operation(summary = "Update an existing contribution")
    @PutMapping("/contributions/update")
    public ResponseEntity<String> updateContribution(@RequestBody Contribution contribution) {
        Contribution existContribution = service.getContributionsById(contribution.getID());
        if (existContribution != null) {
            // Only title and body are allowed to change, So Its ignoring any other changes.
            contribution.setID(existContribution.getID());
            contribution.setUserId(existContribution.getUserId());
            service.updateContribution(contribution);
            return ResponseEntity.ok("Contribution updated successfully");
        }
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN)
                .body("It doesn't exist.");
    }

    // External API for get response by Id and saved.
    // The API is the same as Contribution, so Its mapped the same (id, userId, title, body)
    private ResponseEntity<Contribution> getContributionFromExternalApi(Integer id) {
        String apiUrl = "https://jsonplaceholder.typicode.com/posts/" + id;
        RestTemplate restTemplate = new RestTemplate();

        try {
            // Search contribution by Id in external API
            Contribution externalContribution = restTemplate.getForObject(apiUrl, Contribution.class);

            // Check for contribution founding
            if (externalContribution != null) {
                // If found, save to database
                service.addContribution(externalContribution);
                return ResponseEntity.ok(externalContribution);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            // If happen something bad with external API
            return ResponseEntity.status(500).body(null);
        }
    }
}
