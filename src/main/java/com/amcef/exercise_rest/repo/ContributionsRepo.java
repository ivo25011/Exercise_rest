package com.amcef.exercise_rest.repo;

import com.amcef.exercise_rest.model.Contribution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ContributionsRepo extends JpaRepository<Contribution,Integer> {

    // Search by user Id
    Optional<Contribution> findByUserId(Integer userId);

}
