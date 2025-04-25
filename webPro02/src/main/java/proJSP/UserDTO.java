package proJSP;

public class UserDTO {
    private String userId;
    private String userName;
    private String userBirth; // 이건 String 그대로 둬도 되고, Date로 바꿔도 돼

    public UserDTO(String userId, String userName, String userBirth) {
        this.userId = userId;
        this.userName = userName;
        this.userBirth = userBirth;
    }

    public String getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getUserBirth() {
        return userBirth;
    }
}