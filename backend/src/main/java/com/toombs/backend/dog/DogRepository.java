package com.toombs.backend.dog;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface DogRepository extends CrudRepository<Dog, Long> {

    Optional<Dog> findFirstByUrl(String url);

    @Query(nativeQuery = true, value =
        "SELECT " +
            "d.breed AS breed, " +
            "count(d) AS count " +
        "FROM dog d " +
        "WHERE d.liked IS NOT NULL " +
        "GROUP BY d.breed " +
        "ORDER BY count(d) DESC, d.breed ASC " +
        "LIMIT 10"
    )
    List<VoteResultDTO> findHighestVoted();

    @Query(nativeQuery = true, value =
        "SELECT " +
            "d.breed AS breed, " +
            "count(d) AS count " +
        "FROM dog d " +
        "WHERE d.liked = True " +
        "GROUP BY d.breed " +
        "ORDER BY count(d) DESC, d.breed ASC " +
        "LIMIT 10"
    )
    List<VoteResultDTO> findMostLiked();

    @Query(nativeQuery = true, value =
        "SELECT " +
            "d.breed AS breed, " +
            "count(d) AS count " +
        "FROM dog d " +
        "WHERE d.liked = False " +
        "GROUP BY d.breed " +
        "ORDER BY count(d) DESC, d.breed ASC " +
        "LIMIT 10"
    )
    List<VoteResultDTO> findMostDisliked();
}
