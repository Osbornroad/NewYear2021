package com.gmail.osbornroad.model;

public class Stage {

    private String stageQuestion;

    private String firstAnswer;
    private Integer firstScore;
    private String secondAnswer;
    private Integer secondScore;
    private String thirdAnswer;
    private Integer thirdScore;
    private String fourthAnswer;
    private Integer fourthScore;
    private String fifthAnswer;
    private Integer fifthScore;
    private String sixthAnswer;
    private Integer sixthScore;

    public Stage(String stageQuestion, String firstAnswer, Integer firstScore, String secondAnswer, Integer secondScore, String thirdAnswer, Integer thirdScore, String fourthAnswer, Integer fourthScore, String fifthAnswer, Integer fifthScore, String sixthAnswer, Integer sixthScore) {
        this.stageQuestion = stageQuestion;
        this.firstAnswer = firstAnswer;
        this.firstScore = firstScore;
        this.secondAnswer = secondAnswer;
        this.secondScore = secondScore;
        this.thirdAnswer = thirdAnswer;
        this.thirdScore = thirdScore;
        this.fourthAnswer = fourthAnswer;
        this.fourthScore = fourthScore;
        this.fifthAnswer = fifthAnswer;
        this.fifthScore = fifthScore;
        this.sixthAnswer = sixthAnswer;
        this.sixthScore = sixthScore;
    }

    public Stage() {
    }

    public String getStageQuestion() {
        return stageQuestion;
    }

    public void setStageQuestion(String stageQuestion) {
        this.stageQuestion = stageQuestion;
    }

    public String getFirstAnswer() {
        return firstAnswer;
    }

    public void setFirstAnswer(String firstAnswer) {
        this.firstAnswer = firstAnswer;
    }

    public Integer getFirstScore() {
        return firstScore;
    }

    public void setFirstScore(Integer firstScore) {
        this.firstScore = firstScore;
    }

    public String getSecondAnswer() {
        return secondAnswer;
    }

    public void setSecondAnswer(String secondAnswer) {
        this.secondAnswer = secondAnswer;
    }

    public Integer getSecondScore() {
        return secondScore;
    }

    public void setSecondScore(Integer secondScore) {
        this.secondScore = secondScore;
    }

    public String getThirdAnswer() {
        return thirdAnswer;
    }

    public void setThirdAnswer(String thirdAnswer) {
        this.thirdAnswer = thirdAnswer;
    }

    public Integer getThirdScore() {
        return thirdScore;
    }

    public void setThirdScore(Integer thirdScore) {
        this.thirdScore = thirdScore;
    }

    public String getFourthAnswer() {
        return fourthAnswer;
    }

    public void setFourthAnswer(String fourthAnswer) {
        this.fourthAnswer = fourthAnswer;
    }

    public Integer getFourthScore() {
        return fourthScore;
    }

    public void setFourthScore(Integer fourthScore) {
        this.fourthScore = fourthScore;
    }

    public String getFifthAnswer() {
        return fifthAnswer;
    }

    public void setFifthAnswer(String fifthAnswer) {
        this.fifthAnswer = fifthAnswer;
    }

    public Integer getFifthScore() {
        return fifthScore;
    }

    public void setFifthScore(Integer fifthScore) {
        this.fifthScore = fifthScore;
    }

    public String getSixthAnswer() {
        return sixthAnswer;
    }

    public void setSixthAnswer(String sixthAnswer) {
        this.sixthAnswer = sixthAnswer;
    }

    public Integer getSixthScore() {
        return sixthScore;
    }

    public void setSixthScore(Integer sixthScore) {
        this.sixthScore = sixthScore;
    }
}
