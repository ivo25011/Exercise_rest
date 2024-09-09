package com.amcef.exercise_rest.service;

import com.amcef.exercise_rest.model.Contribution;
import com.amcef.exercise_rest.repo.ContributionsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ContributionService {

    @Autowired
    ContributionsRepo repo;

    // Search contribution by Id
    public Contribution getContributionsById(Integer id) {
        Optional<Contribution> contributionsByIdOpt = repo.findById(id);
        if (contributionsByIdOpt.isPresent()) {
            return contributionsByIdOpt.get();
        }
        return null;
    }

    // Search contribution by user Id
    public Contribution getContributionsByUserId(Integer userId) {
        Optional<Contribution> contributionsByUserIdOpt = repo.findByUserId(userId);
        if (contributionsByUserIdOpt.isPresent()) {
            return contributionsByUserIdOpt.get();
        }
        return null;
    }


    // Add contribution
    public void addContribution(Contribution contribution) {
        repo.save(contribution);
    }

    // Delete contribution by Id
    public void deleteContribution(Integer id) {
        repo.deleteById(id);
    }

    // Update current contribution
    public void updateContribution(Contribution contribution) {
        repo.save(contribution);
    }
}
