package domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CartItemVO {
    private Integer id;
    private Integer uid;
    private Integer pid;
    private String productName;
    private String productImgUrl;
    private Integer quantity;
    private Double totalMoney;
}
