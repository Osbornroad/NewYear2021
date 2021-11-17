package com.gmail.osbornroad.model;

public class Team {

    private String leftName;
    private Integer leftScore;

    private String rightName;
    private Integer rightScore;

    public Team(String leftName, Integer leftScore, String rightName, Integer rightScore) {
        this.leftName = leftName;
        this.leftScore = leftScore;
        this.rightName = rightName;
        this.rightScore = rightScore;
    }

    public String getLeftName() {
        return leftName;
    }

    public void setLeftName(String leftName) {
        this.leftName = leftName;
    }

    public Integer getLeftScore() {
        return leftScore;
    }

    public void setLeftScore(Integer leftScore) {
        this.leftScore = leftScore;
    }

    public String getRightName() {
        return rightName;
    }

    public void setRightName(String rightName) {
        this.rightName = rightName;
    }

    public Integer getRightScore() {
        return rightScore;
    }

    public void setRightScore(Integer rightScore) {
        this.rightScore = rightScore;
    }
}
