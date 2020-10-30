package com.toombs.backend.dog;

import com.fasterxml.jackson.databind.node.TextNode;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/dog")
public class DogController {

    private final DogService dogService;

    public DogController(DogService dogService) {
        this.dogService = dogService;
    }

    @PutMapping("/store")
    public ResponseEntity<Long> store(@RequestBody TextNode url) {
        long id = dogService.store(url.asText());
        return new ResponseEntity<>(id, HttpStatus.OK);
    }

    @PutMapping("/like")
    public ResponseEntity<Long> like(@RequestBody TextNode url) {
        long id = dogService.like(url.asText());
        return new ResponseEntity<>(id, HttpStatus.OK);
    }

    @PutMapping("/dislike")
    public ResponseEntity<Long> dislike(@RequestBody TextNode url) {
        long id = dogService.dislike(url.asText());
        return new ResponseEntity<>(id, HttpStatus.OK);
    }

    @GetMapping("/highest-voted")
    public List<VoteResultDTO> highestVoted() {
        List<VoteResultDTO> highestVoted = dogService.highestVoted();
        return highestVoted;
    }

    @GetMapping("/most-liked")
    public List<VoteResultDTO> mostLiked() {
        List<VoteResultDTO> mostLiked = dogService.mostLiked();
        return mostLiked;
    }

    @GetMapping("/most-disliked")
    public List<VoteResultDTO> mostDisliked() {
        List<VoteResultDTO> mostDisliked = dogService.mostDisliked();
        return mostDisliked;
    }

}
