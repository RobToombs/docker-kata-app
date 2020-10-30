package com.toombs.backend.dog;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class DogService {

    private static final String BREED = "breed";
    private static final Pattern DOG_URL_PATTERN = Pattern.compile(".*?breeds/(?<"+BREED+">[^/]+).*");

    private final DogRepository dogRepository;

    public DogService(DogRepository dogRepository) {
        this.dogRepository = dogRepository;
    }

    public long store(String url) {
        Optional<Dog> dog = dogRepository.findFirstByUrl(url);
        if(!dog.isPresent()) {
            Dog newDog = createDog(url);
            Dog savedDog = saveDog(newDog);
            return savedDog.getId();
        }
        else {
            return dog.get().getId();
        }
    }

    public long like(String url) {
        Dog dog = findOrCreateDog(url);
        dog.setLiked(true);

        Dog savedDog = saveDog(dog);
        return savedDog.getId();
    }

    public long dislike(String url) {
        Dog dog = findOrCreateDog(url);
        dog.setLiked(false);

        Dog savedDog = saveDog(dog);
        return savedDog.getId();
    }

    public List<VoteResultDTO> highestVoted() {
        return dogRepository.findHighestVoted();
    }

    public List<VoteResultDTO> mostLiked() {
        return dogRepository.findMostLiked();
    }

    public List<VoteResultDTO> mostDisliked() {
        return dogRepository.findMostDisliked();
    }

    @Transactional
    protected Dog saveDog(Dog dog) {
        return dogRepository.save(dog);
    }

    private Dog findOrCreateDog(String url) {
        Optional<Dog> dog = dogRepository.findFirstByUrl(url);
        return dog.orElse(createDog(url));
    }

    private Dog createDog(String url) {
        Dog result = new Dog();
        result.setUrl(url);
        result.setBreed(parseBreedFromUrl(url));

        return result;
    }

    private String parseBreedFromUrl(String url) {
        String breed = "";

        if(!StringUtils.isEmpty(url)) {
            Matcher m = DOG_URL_PATTERN.matcher(url);
            if(m.find() && !m.group(BREED).isEmpty()) {
                breed = m.group(BREED);
            }
        }

        return breed;
    }

}
